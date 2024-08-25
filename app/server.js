import express from 'express';
import fs from 'fs-extra';
import path from 'path';
import mysql from 'mysql2/promise';
import pkg from 'pg';
import { dirname } from 'path';
import { fileURLToPath } from 'url';

const { Client } = pkg;
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
const port = 3000;

async function runMySQLScript(scriptPath) {
    const connection = await mysql.createConnection({
        host: 'percona_db',
        user: 'root',
        password: 'rootpassword',
        database: 'testdb',
        port: 3306
    });

    const script = await fs.readFile(scriptPath, 'utf8');
    await connection.query(script);
    await connection.end();
    console.log(`Executed MySQL script: ${scriptPath}`);
}

async function runPostgresScript(scriptPath) {
    const client = new Client({
        host: 'postgres',
        user: 'testuser',
        password: 'testpassword',
        database: 'testdb',
        port: 5432
    });

    await client.connect();
    const script = await fs.readFile(scriptPath, 'utf8');
    await client.query(script);
    await client.end();
    console.log(`Executed PostgreSQL script: ${scriptPath}`);
}

app.post('/run-script', async (req, res) => {
    const { dbType, scriptName } = req.query;

    if (!dbType || !scriptName) {
        return res.status(400).json({ error: 'Missing dbType or scriptName parameters' });
    }

    const scriptPath = path.join(__dirname, 'sql-scripts', scriptName);

    if (!await fs.pathExists(scriptPath)) {
        return res.status(404).json({ error: 'Script not found' });
    }

    try {
        if (dbType === 'mysql') {
            await runMySQLScript(scriptPath);
        } else if (dbType === 'postgres') {
            await runPostgresScript(scriptPath);
        } else {
            return res.status(400).json({ error: 'Invalid dbType. Use "mysql" or "postgres".' });
        }
        res.json({ message: `Script ${scriptName} executed successfully on ${dbType}.` });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'An error occurred while executing the script.' });
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
