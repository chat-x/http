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
return Response(string: String)
return Response(html: String)
return Response(bytes: [UInt8])
return Response(json: Any)
return Response(status: Status)

enum Status {
    case ok
    case notFound
    case badRequest
    case unauthorized
    case internalServerError
}

return String // - return Response(string: String)

return Any | [String : Any] // - return Response(json: serializeToJson(..))


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

func post(_ url: String, json object: Any) throws -> Response
```

## Usage

You can find this code and more in [examples](https://github.com/tris-foundation/examples).

#### Server

```swift
// 0. Create server
let server = try Server(host: "0.0.0.0", port: 8080, async: AsyncFiber())

// 1. Simple route
server.route(get: "/hello") {
    return "hey there!"
}

// 2. Map url param to primitive types
server.route(get: "/hello/:name") { (name: String) in
    return "hey \(name)!"
}

server.route(get: "/robot/:id") { (id: Int) in
    return "Hello. My name is Robo\(id). I'm here to.. BSOD"
}

// Reflection

// 3.1. get method
struct Page {
    let name: String
    let skip: Int
}
// you can mix values from url and query:
// example: /page/news?skip=2
server.route(get: "/page/:name") { (page: Page) in
    return page
}

// 3.2. post data
struct TodoUpdate {
    let name: String
    let done: Bool
}
// urlencoded example: name=sleep+sometimes&done=false
// json example: {"name": "sleep sometimes", "done": false}
server.route(post: "/todo") { (todo: TodoUpdate) in
    return todo
}
// you can also mix values from url and post body:
// example: /todo/commitChanges
// post query: done=true
server.route(post: "/todo/:name") { (todo: TodoUpdate) in
    return todo
}
// 3.3. serialize model into json
server.route(get: "/todo/as/json") {
    return TodoUpdate(name: "serialized", done: true)
}

// 4. Use request & return handcoded json
server.route(get: "/request") { request in
    return [
        "method": String(describing: request.method),
        "url": request.url.path,
    ]
}

// 5. Wildcard
server.route(get: "/*") { (request: Request) in
    return "wildcard: \(request.url.path)"
}

try server.start()
```

#### Client

```swift
let client = try Client(async: AsyncFiber())
try client.connect(to: "http://0.0.0.0:8080")

try client.get("/hello")
try client.get("/hello/username")
try client.get("/robot/8")
try client.get("/page/news?skip=2")

try client.post("/todo", json: [
    "name": "sleep sometimes",
    "done": false
])

try client.post("/todo/post", json: [
    "done": true
])

try client.get("/todo/as/json")
try client.get("/request")
try client.get("/whatdoesmarcelluswallacelooklike")
```
