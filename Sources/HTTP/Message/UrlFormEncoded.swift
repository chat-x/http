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
