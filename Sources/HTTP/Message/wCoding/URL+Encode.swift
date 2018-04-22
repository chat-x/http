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

import Stream
import struct Foundation.CharacterSet

extension String {
    func encode<T: StreamWriter>(
        to stream: T,
        allowedCharacters: CharacterSet
    ) throws {
        let escaped = addingPercentEncoding(
            withAllowedCharacters: allowedCharacters)!
        try stream.write(escaped)
    }
}

extension URL.Query {
    func encode() -> [UInt8] {
        let queryString = values
            .map({ "\($0.key)=\($0.value)" })
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return [UInt8](queryString.utf8)
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        let queryString = values
            .map({ "\($0.key)=\($0.value)" })
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        try stream.write(queryString)
    }
}

extension URL.Host {
    func encode<T: StreamWriter>(to stream: T) throws {
        try stream.write(Punycode.encode(domain: address))
        if let port = port {
            try stream.write(.colon)
            try stream.write("\(port)")
        }
    }
}
