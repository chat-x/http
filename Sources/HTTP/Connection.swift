/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public enum Connection {
    case keepAlive
    case close
    case upgrade
}

extension Connection {
    init(from bytes: UnsafeRawBufferPointer) throws {
        switch bytes.lowercasedHashValue {
        case Mapping.keepAlive.lowercasedHashValue: self = .keepAlive
        case Mapping.close.lowercasedHashValue: self = .close
        case Mapping.upgrade.lowercasedHashValue: self = .upgrade
        default: throw HTTPError.unsupportedContentType
        }
    }
}

extension Connection {
    fileprivate struct Mapping {
        static let keepAlive = ASCII("keep-alive")
        static let close = ASCII("close")
        static let upgrade = ASCII("Upgrade")
    }

    var bytes: [UInt8] {
        switch self {
        case .keepAlive: return Mapping.keepAlive
        case .close: return Mapping.close
        case .upgrade: return Mapping.upgrade
        }
    }
}
