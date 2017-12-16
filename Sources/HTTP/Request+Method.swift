/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

extension Request {
    public enum Method {
        case get
        case head
        case post
        case put
        case delete
        case options
    }
}

extension Request.Method {
    init<T: RandomAccessCollection>(from bytes: T) throws
        where T.Element == UInt8, T.Index == Int {
        for (type, method) in RequestMethodBytes.values {
            if bytes.elementsEqual(method) {
                self = type
                return
            }
        }
        throw HTTPError.invalidMethod
    }

    func encode(to buffer: inout [UInt8]) {
        switch self {
        case .get: buffer.append(contentsOf: RequestMethodBytes.get)
        case .head: buffer.append(contentsOf: RequestMethodBytes.head)
        case .post: buffer.append(contentsOf: RequestMethodBytes.post)
        case .put: buffer.append(contentsOf: RequestMethodBytes.put)
        case .delete: buffer.append(contentsOf: RequestMethodBytes.delete)
        case .options: buffer.append(contentsOf: RequestMethodBytes.options)
        }
    }
}

fileprivate struct RequestMethodBytes {
    static let get = ASCII("GET")
    static let head = ASCII("HEAD")
    static let post = ASCII("POST")
    static let put = ASCII("PUT")
    static let delete = ASCII("DELETE")
    static let options = ASCII("OPTIONS")

    static let values: [(Request.Method, ASCII)] = [
        (.get, get),
        (.head, head),
        (.post, post),
        (.put, put),
        (.delete, delete),
        (.options, options),
    ]
}
