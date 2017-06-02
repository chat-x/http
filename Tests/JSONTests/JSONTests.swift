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
@testable import JSON

class JSONTests: TestCase {
    func testSerialize() {
        do {
            struct Person {
                let name: String = "Tony"
                let age: Int = 16
            }
            let bytes = try JSON.encode(Person())
            let string = String(cString: bytes + [0])
            guard string == "{\"name\":\"Tony\",\"age\":16}" ||
                string == "{\"age\":16,\"name\":\"Tony\"}"  else {
                    fail()
                    return
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testSerializeArray() {
        do {
            let integers: [Int] = [1,2,3,4,5]
            let bytes = try JSON.encode(integers)
            let string = String(cString: bytes + [0])
            assertEqual(string, "[1,2,3,4,5]")
        } catch {
            fail(String(describing: error))
        }
    }

    func testSerializeArrayProperty() {
        do {
            struct Numbers {
                let integers: [Int] = [1,2,3,4,5]
            }
            let bytes = try JSON.encode(Numbers())
            let string = String(cString: bytes + [0])
            assertEqual(string, "{\"integers\":[1,2,3,4,5]}")
        } catch {
            fail(String(describing: error))
        }
    }

    func testSerializeDictionaryProperty() {
        do {
            struct Model {
                let dictionary: [String: Int] = ["number" : 2]
            }
            let bytes = try JSON.encode(Model())
            let string = String(cString: bytes + [0])
            assertEqual(string, "{\"dictionary\":{\"number\":2}}")
        } catch {
            fail(String(describing: error))
        }
    }

    func testSerializeNestedStruct() {
        do {
            struct Model {
                struct Person {
                    let name: String = "Tony"
                    let age: Int = 16
                }
                let person: Person = Person()
            }

            let bytes = try JSON.encode(Model())
            let string = String(cString: bytes + [0])
            guard string == "{\"person\":{\"name\":\"Tony\",\"age\":16}}" ||
                string == "{\"person\":{\"age\":16,\"name\":\"Tony\"}}" else {
                    fail()
                    return
            }
        } catch {
            fail(String(describing: error))
        }
    }


    static var allTests = [
        ("testSerialize", testSerialize),
        ("testSerializeArray", testSerializeArray),
        ("testSerializeArrayProperty", testSerializeArrayProperty),
        ("testSerializeDictionaryProperty", testSerializeDictionaryProperty),
        ("testSerializeNestedStruct", testSerializeNestedStruct),
    ]
}
