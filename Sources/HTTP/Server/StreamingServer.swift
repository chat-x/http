/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

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
