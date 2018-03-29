# HTTP

Incredibly fast http modules primarily designed for cooperative multitasking. **No callbacks.**

## Package.swift

```swift
.package(url: "https://github.com/tris-foundation/http.git", .branch("master"))
```

## Usage

You can find this code and more in [examples](https://github.com/tris-foundation/examples).

### Async

```swift
import Fiber

async.use(Fiber.self)

async.task {
    // server or client code
    // ...
}

async.loop.run()
```

### Server

```swift
let server = try Server(host: "0.0.0.0", port: 8080)

server.route(...)
// or
server.addApplication(application)

try server.start()
```

### Routes

>NOTE: you can only use this arguments signature:
>* (Void) - none
>* (Request) - original request
>* (Decodable) with :mask present in url - url match
>* (Decodable) with *NO* :mask present in url - decode url.query or body
>* any combination in order - request, url-match, body
>
> *You can't have more than three input arguments*


#### Simple

```swift

server.route(get: "/ascii") {
    return "hey there!"
}

server.route(get: "/юникод") {
    return "привет!"
}

server.route(get: "/request") { (request: Request) -> Response in
    return Response(status: .ok)
}
```

#### URL match

```swift
server.route(get: "/swift/string/:string") { name: String in
    return "name: \(name)"
}

server.route(get: "/swift/int/:integer") { id: Int in
    return "id: \(id)"
}

struct Date: Decodable {
    let day: Int
    let month: String
}

server.route(get: "/decode-from-url/:month/:day") { date: Date in
    return "date: \(date)"
}
```

#### Body

```swift
struct Event: Decodable {
    let name: String
}

server.route(post: "/decode-json-or-form-urlencoded") { (event: Event) in
    return "event: \(event)"
}
```

#### URL match + Body

```swift
server.route(post: "/date/:month/:day") { (date: Date, event: Event) in
    return """
        date from url: \(date)
        model from body: \(event)
        """
}
```

#### Wildcard

```swift
server.route(get: "/*") { (request: Request) in
    return "wildcard: \(request.url.path)"
}

try server.start()
```

#### Application

`/api/v1/test`

```swift
let api = Application(basePath: "/api" /* middleware: [] */)
api.route(get: "/versions") { return ["v1"] }

let v1 = Application(basePath: "/v1" /* middleware: [] */)
v1.route(get: "/test") { return "ok" }

api.addApplication(v1)
server.addApplication(api)
```

### Client

```swift
let client = try Client(url: "http://0.0.0.0:8080")

try client.get(path: "/ascii")
try client.get(path: "/юникод")
try client.get(path: "/request")
try client.get(path: "/swift/string/user")
try client.get(path: "/swift/int/42")

try client.get(path: "/decode-from-url/January/1")
try client.get(path: "/decode-json-or-form-urlencoded?name=push")

try client.post(path: "/date/January/1", object: Event(name: "push"))

try client.get(path: "/whatdoesmarcelluswallacelooklike")
```
