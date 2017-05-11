/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

@testable import HTTP

class JSONTests: TestCase {
    func testSerialize() {
        do {
            struct Person {
                let name: String = "Tony"
                let age: Int = 16
            }
            let bytes = try JSON.serialize(Person())
            let string = String(cString: bytes + [0])
            assertEqual(string, "{\"name\":\"Tony\",\"age\":16}")
        } catch {
            fail(String(describing: error))
        }
    }

    func testSerializeArray() {
        do {
            let integers: [Int] = [1,2,3,4,5]
            let bytes = try JSON.serialize(integers)
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
            let bytes = try JSON.serialize(Numbers())
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
            let bytes = try JSON.serialize(Model())
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

            let bytes = try JSON.serialize(Model())
            let string = String(cString: bytes + [0])
            assertEqual(string, "{\"person\":{\"name\":\"Tony\",\"age\":16}}")
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
