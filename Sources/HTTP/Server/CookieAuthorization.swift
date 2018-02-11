/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public final class CookieAuthorization: AuthorizationProtocol, InjectService {
    let repository: UserRepository

    public init(_ repository: UserRepository) {
        self.repository = repository
    }

    func authenticate(context: Context) throws {
        guard let userId = context.cookies["tris-user"] else {
            context.user = nil
            return
        }
        context.user = try repository.get(id: userId)
    }

    func loginRequired(context: Context) {
        context.response = Response(status: .unauthorized)
    }

    func accessDenied(context: Context) {
        context.response = Response(status: .unauthorized)
    }
}
