/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

import Log
import Stream

protocol RequestHandlerProtocol {
    func handleRequest(_ request: Request) -> Response?
}

protocol StreamingServer: RequestHandlerProtocol {
    var bufferSize: Int { get }
    func process<T: Stream>(stream: T) throws
}

extension StreamingServer {
    func process<T: Stream>(stream: T) throws {
        try process(
            inputStream: BufferedInputStream(
                baseStream: stream,
                capacity: bufferSize),
            outputStream: BufferedOutputStream(
                baseStream: stream,
                capacity: bufferSize))
    }

    func process<I: InputStream, O: OutputStream>(
        inputStream: BufferedInputStream<I>,
        outputStream: BufferedOutputStream<O>
    ) throws {
        while true {
            let request = try Request(from: inputStream)
            if request.expect == .continue {
                let `continue` = Response(status: .continue)
                try `continue`.encode(to: outputStream)
                try outputStream.flush()
            }
            if let response = handleRequest(request) {
                try response.encode(to: outputStream)
                try outputStream.flush()
            }
            if request.connection == .close {
                break
            }
        }
    }
}

extension Server {
    @inline(__always)
    func handleRequest(_ request: Request) -> Response? {
        return router.handleRequest(request)
    }
}
