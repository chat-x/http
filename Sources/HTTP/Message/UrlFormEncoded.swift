/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

struct FormURLEncoded {
    static func encode<T: Encodable>(
        _ object: T
    ) throws -> [UInt8] {
        let values = try KeyValueEncoder().encode(object)
        let query = URL.Query(values: values)
        return query.encode()
    }

    // FIXME: the same interface shadows the generic one
    static func encode(
        encodable object: Encodable
    ) throws -> [UInt8] {
        let values = try KeyValueEncoder().encode(encodable: object)
        let query = URL.Query(values: values)
        return query.encode()
    }
}
