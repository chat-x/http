/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Test
import Foundation

@testable import HTTP

class UserManagerTests: TestCase {
    public final class InMemoryUserRepository: UserRepository {
        var users: [User]

        public init() {
            self.users = []
        }

        public func get(id: String) throws -> User? {
            return users.first(where: { $0.id == id })
        }

        public func add(user: User) throws -> String {
            var user = user
            let id = UUID().uuidString
            user.id = id
            users.append(user)
            return id
        }

        public func find(email: String) throws -> User? {
            return users.first(where: { $0.email == email })
        }
    }

    func testRegister() {
        do {
            let users = UserManager(InMemoryUserRepository())

            let user = try users.register(UserManager.NewCredentials(
                name: "user", email: "new@user.com", password: "123"))

            assertEqual(user.name, "user")
            assertEqual(user.email, "new@user.com")
            assertTrue(user.password == "123")
            assertTrue(user.password.hash != "123")

            assertThrowsError(try users.register(UserManager.NewCredentials(
                name: "user", email: "new@user.com", password: "123")))
            { error in
                assertEqual(error as? UserManager.Error, .alreadyRegistered)
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testLogin() {
        do {
            let users = UserManager(InMemoryUserRepository())

            _ = try users.register(UserManager.NewCredentials(
                name: "user", email: "new@user.com", password: "123"))

            let user = try users.login(UserManager.Credentials(
                email: "new@user.com", password: "123"))

            assertEqual(user.name, "user")
            assertEqual(user.email, "new@user.com")
            assertTrue(user.password == "123")
            assertTrue(user.password.hash != "123")

            assertThrowsError(try users.login(UserManager.Credentials(
                email: "unknown@user.com", password: "123")))
            { error in
                assertEqual(error as? UserManager.Error, .notFound)
            }

            assertThrowsError(try users.login(UserManager.Credentials(
                email: "new@user.com", password: "000")))
            { error in
                assertEqual(error as? UserManager.Error, .invalidCredentials)
            }

        } catch {
            fail(String(describing: error))
        }
    }


    static var allTests = [
        ("testRegister", testRegister),
        ("testLogin", testLogin),
    ]
}