/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public protocol CookiesStorage: Inject {
    func get(hash: String) throws -> Cookies?
    func upsert(cookies: Cookies) throws
    func delete(hash: String) throws
}

public final class InMemoryCookiesStorage: CookiesStorage {
    var cookies: [String : [String : String]]

    public init() {
        self.cookies = [:]
    }

    public func get(hash: String) throws -> Cookies? {
        guard let values = self.cookies[hash] else {
            return nil
        }
        return Cookies(hash: hash, values: values)
    }

    public func upsert(cookies: Cookies) throws {
        self.cookies[cookies.hash] = cookies.values
    }

    public func delete(hash: String) throws {
        cookies[hash] = nil
    }
}
