/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

protocol CookiesStorage: Inject {
    func get(hash: String) throws -> Cookies?
    func upsert(cookies: Cookies) throws
    func delete(hash: String) throws
}

public final class InMemoryCookiesStorage: CookiesStorage {
    var cookies: [String : Cookies]

    public init() {
        self.cookies = [:]
    }

    func get(hash: String) throws -> Cookies? {
        return self.cookies[hash]
    }

    func upsert(cookies: Cookies) throws {
        self.cookies[cookies.hash] = cookies
    }

    func delete(hash: String) throws {
        cookies[hash] = nil
    }
}
