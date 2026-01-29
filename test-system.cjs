const http = require('http');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const LOG_PREFIX = '[SystemCheck]';

function log(msg, type = 'INFO') {
    const color = type === 'ERROR' ? '\x1b[31m' : type === 'SUCCESS' ? '\x1b[32m' : '\x1b[33m';
    console.log(`${color}${LOG_PREFIX} ${msg}\x1b[0m`);
}

async function checkPort(port) {
    return new Promise((resolve) => {
        const req = http.get(`http://localhost:${port}/`, (res) => {
            log(`Port ${port} is active (Status: ${res.statusCode})`, 'SUCCESS');
            resolve(true);
        }).on('error', (err) => {
            log(`Port ${port} check failed: ${err.message}`, 'ERROR');
            resolve(false);
        });
        req.end();
    });
}

async function checkDatabase() {
    try {
        log('Checking Database connection...');
        const userCount = await prisma.user.count();
        log(`Database connected. User count: ${userCount}`, 'SUCCESS');

        const admin = await prisma.user.findUnique({ where: { email: 'admin@admin.com' } });
        if (admin) {
            log('Admin user exists.', 'SUCCESS');
        } else {
            log('Admin user MISSING.', 'ERROR');
        }
    } catch (e) {
        log(`Database check failed: ${e.message}`, 'ERROR');
    } finally {
        await prisma.$disconnect();
    }
}

async function run() {
    log('Starting Deep Verification...');
    
    // Check Backend
    const backendUp = await checkPort(3001);
    
    // Check Frontend
    const frontendUp = await checkPort(5000);

    // Check Database
    await checkDatabase();

    if (!backendUp || !frontendUp) {
        log('CRITICAL: One or more services are down.', 'ERROR');
    } else {
        log('Services appear running. If app is broken, check Browser Console.', 'INFO');
    }
}

run();
