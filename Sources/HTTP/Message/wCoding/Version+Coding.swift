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

extension Version {
    private struct Bytes {
        static let httpSlash = ASCII("HTTP/")
        static let oneOne = ASCII("1.1")
    }

    init<T: StreamReader>(from stream: T) throws {
        try stream.read(count: Bytes.httpSlash.count) { bytes in
            guard bytes.elementsEqual(Bytes.httpSlash) else {
                throw ParseError.invalidVersion
            }
        }

        self = try stream.read(count: Bytes.oneOne.count) { bytes in
            guard bytes.elementsEqual(Bytes.oneOne) else {
                throw ParseError.invalidVersion
            }
            return .oneOne
        }
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        try stream.write(Bytes.httpSlash)
        switch self {
        case .oneOne: try stream.write(Bytes.oneOne)
        }
    }
}
