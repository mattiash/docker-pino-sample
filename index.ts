import { createServer } from 'http'

const server = createServer((_req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' })
    res.end('ok')
})

server.listen(3000, () => {
    console.log('Listening')
})

process.on('SIGTERM', () => {
    console.log('Shutting down')
    server.close(() => {
        console.log('Socket closed')
    })
})
