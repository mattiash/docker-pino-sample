import logger from './logger'
import { createServer } from 'http'

const server = createServer((_req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' })
    res.end('ok')
})

server.listen(3000, () => {
    logger.info('Listening')
})

process.on('SIGTERM', () => {
    logger.info('Shutting down')
    server.close(() => {
        logger.info('Socket closed')
    })
})
