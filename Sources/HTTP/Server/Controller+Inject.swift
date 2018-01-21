/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public protocol Inject {
    init()
}

public protocol InjectService {
    associatedtype One
    init(_ one: One)
}

public protocol Inject2Services {
    associatedtype One
    associatedtype Two
    init(_ one: One, _ two: Two)
}

public protocol Inject3Services {
    associatedtype One
    associatedtype Two
    associatedtype Three
    init(_ one: One, _ two: Two, _ three: Three)
}

public protocol Inject4Services {
    associatedtype One
    associatedtype Two
    associatedtype Three
    associatedtype Four
    init(_ one: One, _ two: Two, _ three: Three, _ four: Four)
}

public protocol Inject5Services {
    associatedtype One
    associatedtype Two
    associatedtype Three
    associatedtype Four
    associatedtype Five
    init(_ one: One, _ two: Two, _ three: Three, _ four: Four, _ five: Five)
}

public protocol Inject6Services {
    associatedtype One
    associatedtype Two
    associatedtype Three
    associatedtype Four
    associatedtype Five
    associatedtype Six
    init(
        _ one: One,
        _ two: Two,
        _ three: Three,
        _ four: Four,
        _ five: Five,
        _ six: Six
    )
}

extension RouterProtocol {
    public func addController<C>(_ type: C.Type) throws
        where C: Controller & Inject
    {
        try addController(C.self) { _ in
            return C.init()
        }
    }

    private func check<T, C: Controller>(
        type: T.Type,
        for controller: C.Type) throws
    {
        guard T.self != Context.self else {
            return
        }
        do {
            _ = try Services.shared.resolve(T.self)
        } catch let error as Services.Error {
            debugPrint(controller)
            throw error
        }
    }

    @inline(__always)
    private func resolveEither<T>(
        _ type: T.Type,
        _ context: Context) throws -> T
    {
        if T.self == Context.self {
            return context as! T
        } else {
            return try Services.shared.resolve(T.self)
        }
    }

    public func addController<C>(_ type: C.Type) throws
        where C: Controller & InjectService
    {
        try check(type: C.One.self, for: C.self)

        try addController(C.self) { context in
            let one = try self.resolveEither(C.One.self, context)
            return C.init(one)
        }
    }

    public func addController<C>(_ type: C.Type) throws
        where C: Controller & Inject2Services
    {
        try check(type: C.One.self, for: C.self)
        try check(type: C.Two.self, for: C.self)

        try addController(C.self) { context in
            let one = try self.resolveEither(C.One.self, context)
            let two = try self.resolveEither(C.Two.self, context)
            return C.init(one, two)
        }
    }

    public func addController<C>(_ type: C.Type) throws
        where C: Controller & Inject3Services
    {
        try check(type: C.One.self, for: C.self)
        try check(type: C.Two.self, for: C.self)
        try check(type: C.Three.self, for: C.self)

        try addController(C.self) { context in
            let one = try self.resolveEither(C.One.self, context)
            let two = try self.resolveEither(C.Two.self, context)
            let three = try self.resolveEither(C.Three.self, context)
            return C.init(one, two, three)
        }
    }

    public func addController<C>(_ type: C.Type) throws
        where C: Controller & Inject4Services
    {
        try check(type: C.One.self, for: C.self)
        try check(type: C.Two.self, for: C.self)
        try check(type: C.Three.self, for: C.self)
        try check(type: C.Four.self, for: C.self)

        try addController(C.self) { context in
            let one = try self.resolveEither(C.One.self, context)
            let two = try self.resolveEither(C.Two.self, context)
            let three = try self.resolveEither(C.Three.self, context)
            let four = try self.resolveEither(C.Four.self, context)
            return C.init(one, two, three, four)
        }
    }

    public func addController<C>(_ type: C.Type) throws
        where C: Controller & Inject5Services
    {
        try check(type: C.One.self, for: C.self)
        try check(type: C.Two.self, for: C.self)
        try check(type: C.Three.self, for: C.self)
        try check(type: C.Four.self, for: C.self)
        try check(type: C.Five.self, for: C.self)

        try addController(C.self) { context in
            let one = try self.resolveEither(C.One.self, context)
            let two = try self.resolveEither(C.Two.self, context)
            let three = try self.resolveEither(C.Three.self, context)
            let four = try self.resolveEither(C.Four.self, context)
            let five = try self.resolveEither(C.Five.self, context)
            return C.init(one, two, three, four, five)
        }
    }

    public func addController<C>(_ type: C.Type) throws
        where C: Controller & Inject6Services
    {
        try check(type: C.One.self, for: C.self)
        try check(type: C.Two.self, for: C.self)
        try check(type: C.Three.self, for: C.self)
        try check(type: C.Four.self, for: C.self)
        try check(type: C.Five.self, for: C.self)
        try check(type: C.Six.self, for: C.self)

        try addController(C.self) { context in
            let one = try self.resolveEither(C.One.self, context)
            let two = try self.resolveEither(C.Two.self, context)
            let three = try self.resolveEither(C.Three.self, context)
            let four = try self.resolveEither(C.Four.self, context)
            let five = try self.resolveEither(C.Five.self, context)
            let six = try self.resolveEither(C.Six.self, context)
            return C.init(one, two, three, four, five, six)
        }
    }
}
