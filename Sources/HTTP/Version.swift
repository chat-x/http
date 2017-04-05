/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public enum Version {
    case oneOne
}

extension Version {
    init(from buffer: UnsafeRawBufferPointer) throws {
        guard buffer.starts(with: Constants.httpSlash) else {
            throw HTTPError.invalidVersion
        }
        guard buffer.count >= 8,
            buffer[5..<8].elementsEqual(Constants.oneOne) else {
                throw HTTPError.invalidVersion
        }
        self = .oneOne
    }
}

extension Version {
    var bytes: [UInt8] {
        switch self {
        case .oneOne: return Constants.oneOne
        }
    }
}
