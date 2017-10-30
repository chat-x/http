# HTTP

Incredibly fast http modules primarily designed for cooperative multitasking,<br>
but also has a fallback to [dispatch](https://github.com/tris-foundation/async-dispatch) system if you can't use fibers for some reason.<br>
Currently limited to us-ascii routes. Unicode router & session & (middleware | filters) are coming.<br>


## Package.swift

```swift
.package(url: "https://github.com/tris-foundation/http.git", from: "0.4.0")
```

## Memo

#### Server
```swift
// route return types
return Response(status: Status)
return Response(string: String)
return Response(html: String)
return Response(bytes: [UInt8])
return Response(json: Encodable)

enum Status {
    case ok
    case notFound
    case badRequest
    case unauthorized
    case internalServerError
}

return // the same as Response(status: .ok)
return String // the same as Response(string: String)
return Encodable // the same as Response(json: Encodable)


// main routers
func route(method: RequestType, url: String, handler: (Void) -> Any)
func route(method: RequestType, url: String, handler: (Request) -> Any)
func route<A>(method: RequestType, url: String, handler: (A) -> Any)
func route<A>(method: RequestType, url: String, handler: (Request, A) -> Any)

// convenience routers
func route(get url: String, handler: (Void) -> Any)
func route(get url: String, handler: (Request) -> Any)
func route<A>(get url: String, handler: (A) -> Any)
func route<A>(get url: String, handler: (Request, A) -> Any)

func route(head url: String, handler: (Void) -> Any)
func route(head url: String, handler: (Request) -> Any)
func route<A>(head url: String, handler: (A) -> Any)
func route<A>(head url: String, handler: (Request, A) -> Any)

func route(post url: String, handler: (Void) -> Any)
func route(post url: String, handler: (Request) -> Any)
func route<A>(post url: String, handler: (A) -> Any)
func route<A>(post url: String, handler: (Request, A) -> Any)

func route(put url: String, handler: (Void) -> Any)
func route(put url: String, handler: (Request) -> Any)
func route<A>(put url: String, handler: (A) -> Any)
func route<A>(put url: String, handler: (Request, A) -> Any)

func route(delete url: String, handler: (Void) -> Any)
func route(delete url: String, handler: (Request) -> Any)
func route<A>(delete url: String, handler: (A) -> Any)
func route<A>(delete url: String, handler: (Request, A) -> Any)

func route(options url: String, handler: (Void) -> Any)
func route(options url: String, handler: (Request) -> Any)
func route<A>(options url: String, handler: (A) -> Any)
func route<A>(options url: String, handler: (Request, A) -> Any)

func route(all url: String, handler: (Void) -> Any)
func route(all url: String, handler: (Request) -> Any)
func route<A>(all url: String, handler: (A) -> Any)
func route<A>(all url: String, handler: (Request, A) -> Any)
```

#### Client
```swift
init(async: Async) throws
func connect(to url: URL) throws
func close() throws

func makeRequest(_ request: Request) throws -> Response

func get(_ url: String) throws -> Response
func head(_ url: String) throws -> Response
func post(_ url: String) throws -> Response
func put(_ url: String) throws -> Response
func delete(_ url: String) throws -> Response
func options(_ url: String) throws -> Response

func post(_ url: String, json object: Encodable) throws -> Response
```

## Usage

You can find this code and more in [examples](https://github.com/tris-foundation/examples).

#### Async

```swift
import AsyncFiber
AsyncFiber().registerGlobal()
```

#### Server

```swift
// 1. Simple route
server.route(get: "/hello") {
    return "hey there!"
}

// Decodable
// 2. Decode url
server.route(get: "/hello/:string") { (name: String) in
    return "hey \(name)!"
}

server.route(get: "/user/:integer") { (id: Int) in
    return "get user where id=\(id)"
}

// 3. Custom model
struct Todo: Codable {
    let name: String
    let done: Bool
}

// 3.1. Encode response to json
server.route(get: "/todos") {
    return [
        Todo(name: "One", done: true),
        Todo(name: "Two", done: false)
    ]
}

// 3.2. Decode request from json | form-urlencoded
server.route(post: "/todo") { (todo: Todo) in
    return todo
}

// 4. Custom url & request model
struct Date: Decodable {
    let day: Int
    let month: String
}
struct Event: Decodable {
    let name: String
}

// 4.1. Pass request & decode url + body
server.route(post: "/date/:month/:day"){ (request: Request, date: Date, event: Event) in
    return "\(request.url) \(date) \(event)"
}

// 5. Wildcard
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
try client.get("/hello/username")
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
