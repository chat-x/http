/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

// Convenience constructors

extension RouterProtocol {
    // GET
    @_inlineable
    public mutating func route(
        get path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route(
        get path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        get path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        get path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        get path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        get path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    // HEAD
    @_inlineable
    public mutating func route(
        head path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route(
        head path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        head path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        head path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        head path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        head path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    // POST
    @_inlineable
    public mutating func route(
        post path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route(
        post path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        post path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        post path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        post path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        post path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    // PUT
    @_inlineable
    public mutating func route(
        put path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route(
        put path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        put path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        put path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        put path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        put path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    // DELETE
    @_inlineable
    public mutating func route(
        delete path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route(
        delete path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        delete path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        delete path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        delete path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        delete path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    // OPTIONS
    @_inlineable
    public mutating func route(
        options path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route(
        options path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        options path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        options path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        options path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        options path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    // ALL
    @_inlineable
    public mutating func route(
        all path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route(
        all path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        all path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<Model: Decodable>(
        all path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        all path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public mutating func route<URLMatch: Decodable, Model: Decodable>(
        all path: String,
        middleware: [Middleware.Type] = [],
        handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }
}