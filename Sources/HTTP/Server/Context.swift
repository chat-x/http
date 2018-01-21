/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public final class Context {
    public var request: Request
    public var response: Response
    public var services: Services

    init(
        request: Request,
        response: Response = Response(status: .ok),
        services: Services
    ) {
        self.request = request
        self.response = response
        self.services = services
    }
}

extension Context: Service {
    public convenience init() {
        let request = Request(url: "/", method: .get)
        let response = Response(status: .ok)
        let services = Services.shared
        self.init(request: request, response: response, services: services)
    }
}
