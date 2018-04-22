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

import HTTP
import Stream

extension Response {
    func encode() throws -> String {
        let stream = OutputByteStream()
        try encode(to: stream)
        return String(decoding: stream.bytes, as: UTF8.self)
    }
}

extension Request {
    func encode() throws -> String {
        let stream = OutputByteStream()
        try encode(to: stream)
        return String(decoding: stream.bytes, as: UTF8.self)
    }
}

extension InputByteStream {
    convenience
    init(_ string: String) {
        self.init([UInt8](string.utf8))
    }
}

extension OutputByteStream {
    var string: String {
        return String(decoding: bytes, as: UTF8.self)
    }
}
