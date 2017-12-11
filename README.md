# HTTP

Incredibly fast http modules primarily designed for cooperative multitasking.

## Package.swift

```swift
.package(url: "https://github.com/tris-foundation/http.git", .branch("master"))
```

## Usage

You can find this code and more in [examples](https://github.com/tris-foundation/examples).

#### Async

```swift
import AsyncFiber

AsyncFiber().registerGlobal()

async.task {
    // server or client code
    // ...
}

async.loop.run()
```

#### Server

```swift
let server = try Server(host: "0.0.0.0", port: 8080)

// 1. Simple routes
// supported methods: get, head, post, put, delete, options, all

// ascii
server.route(get: "/hello") {
    return "hey there!"
}

// unicode
server.route(get: "/привет") {
    return "привет!"
}

// 2. Use Request data
server.route(get: "/request") { (request: Request) in
    return request.url.path
}

// 3. Match url params
server.route(get: "/page/:string") { (name: String) in
    return "page name: \(name)"
}

server.route(get: "/user/:integer") { (id: Int) in
    return "user id: \(id)"
}

// 4. Custom model
struct Todo: Codable {
    let name: String
    let done: Bool
}

// Encode response to json
server.route(get: "/todos") {
    return [
        Todo(name: "One", done: true),
        Todo(name: "Two", done: false)
    ]
}

// Decode request from json or form-urlencoded
server.route(post: "/todo") { (todo: Todo) in
    return todo
}

// 5. Use all together
struct Date: Decodable {
    let day: Int
    let month: String
}

struct Event: Decodable {
    let name: String
}

// Pass request, match url, decode post data
server.route(post: "/date/:month/:day")
{ (request: Request, date: Date, event: Event) in
    return """
        request url: \(request.url)
        date from url: \(date)
        model from body: \(event)
        """
}

// 6. Wildcard
server.route(get: "/*") { (request: Request) in
    return "wildcard: \(request.url.path)"
}

try server.start()
```

#### Client

```swift
let client = try Client()
try client.connect(to: "http://0.0.0.0:8080")

try client.get("/hello")
try client.get("/привет")
try client.get("/request")
try client.get("/page/news")
try client.get("/user/8")
try client.get("/todos")

struct Todo: Encodable {
    let name: String
    let done: Bool
}

try client.post("/todo", json: Todo(
    name: "sleep sometimes (from json)",
    done: false))

try client.post("/todo", urlEncoded: Todo(
    name: "sleep sometimes (from urlencoded)",
    done: false))

struct Event: Encodable {
    let name: String
}

try client.post("/date/May/8", json: Event(name: "Dance"))

try client.get("/whatdoesmarcelluswallacelooklike")
```
