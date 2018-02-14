/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public final class UserManager: InjectService {
    enum Error: Swift.Error {
        case alreadyRegistered
        case invalidCredentials
        case notFound
    }

    let repository: UserRepository

    public init(_ repository: UserRepository) {
        self.repository = repository
    }

    struct NewCredentials: Codable {
        let name: String
        let email: String
        let password: String
    }

    func register(_ credentials: NewCredentials) throws -> User {
        guard try repository.find(email: credentials.email) == nil else {
            throw Error.alreadyRegistered
        }
        var user = User(credentials: credentials)
        user.id = try repository.add(user: user)
        return user
    }

    struct Credentials: Decodable {
        let email: String
        let password: String
    }

    func login(_ credentials: Credentials) throws -> User {
        guard let user = try repository.find(email: credentials.email) else {
            throw Error.notFound
        }
        guard user.password == credentials.password else {
            throw Error.invalidCredentials
        }
        return user
    }
}

extension User {
    init(credentials: UserManager.NewCredentials) {
        self.init(
            name: credentials.name,
            email: credentials.email,
            password: credentials.password)
    }
}
