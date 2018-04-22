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

extension HeaderName {
    init<T: StreamReader>(from stream: T) throws {
        let bytes = try stream.read(allowedBytes: .token)
        guard bytes.count > 0 else {
            throw ParseError.invalidHeaderName
        }
        self.init(bytes)
    }
}
