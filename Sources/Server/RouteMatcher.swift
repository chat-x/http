/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

let asterisk: UInt8 = "*"
let colon: UInt8 = ":"
let separator: UInt8 = "/"

enum RouterError: Error {
    case invalidRoute
}

struct Node<T> {
    lazy var payload: [T] = []
    var wildcard: [Node]? = nil
    var rlist: [Node]? = nil
}

public struct RouteMatcher<T> {
    public init() {}

    var root = Node<T>()

    public mutating func add(route bytes: String.UTF8View, payload: T) {
        guard let first = bytes.first, first == separator else {
            return
        }

        // ascii table
        for byte in bytes {
            guard byte >= 0 && byte < 128 else {
                return
            }
        }

        // main route: "/"
        guard bytes.count > 1 else {
            root.payload.append(payload)
            return
        }

        addNode(to: &root, characters: bytes.dropFirst(), payload: payload)
    }

    public mutating func matches(route bytes: String.UTF8View) -> [T] {
        let startIndex = bytes.startIndex
        guard bytes[startIndex] == separator else {
            return []
        }

        // ascii table
        for byte in bytes {
            guard byte >= 0 && byte < 128 else {
                return []
            }
        }

        let route = bytes.dropFirst()
        guard route.count > 0 else {
            if root.wildcard != nil {
                return root.payload + root.wildcard![Int(asterisk)].payload
            }
            return root.payload
        }

        var result = [T]()
        findNode(in: root, characters: route, result: &result)
        return result
    }

    func addNode(to node: inout Node<T>, characters: String.UTF8View.SubSequence, payload: T) {
        let character = Int(characters[characters.startIndex])
        if character == Int(asterisk) || character == Int(colon) {
            if node.wildcard == nil {
                node.wildcard = [Node](repeating: Node(), count: 128)
            }

            var index = characters.startIndex
            while index < characters.endIndex && characters[index] != separator {
                characters.formIndex(after: &index)
            }

            guard index < characters.endIndex else {
                node.wildcard![Int(asterisk)].payload.append(payload)
                return
            }

            guard characters.index(after: index) < characters.endIndex else {
                node.wildcard![Int(separator)].payload.append(payload)
                return
            }

            let next = characters.index(after: index)
            addNode(to: &node.wildcard![Int(separator)], characters: characters.suffix(from: next), payload: payload)
        } else {
            if node.rlist == nil {
                node.rlist = [Node](repeating: Node(), count: 128)
            }

            guard characters.index(after: characters.startIndex) < characters.endIndex else {
                node.rlist![character].payload.append(payload)
                return
            }

            let next = characters.index(after: characters.startIndex)
            addNode(to: &node.rlist![character], characters: characters.suffix(from: next), payload: payload)
        }
    }

    mutating func findNode(in node: Node<T>, characters: String.UTF8View.SubSequence, result: inout [T]) {
        guard characters.startIndex < characters.endIndex else {
            var node = node // accessing lazy initializer on immutable type
            if node.payload.count > 0 {
                result.append(contentsOf: node.payload)
            }
            return
        }

        if let rlist = node.rlist  {
            let childNode = rlist[Int(characters[characters.startIndex])]
            let next = characters.index(after: characters.startIndex)
            findNode(in: childNode, characters: characters.suffix(from: next), result: &result)
        }

        if let wildcard = node.wildcard {
            var index = characters.startIndex
            while characters.index(after: index) < characters.endIndex && characters[index] != separator {
                characters.formIndex(after: &index)
            }

            let childNode = characters[index] == separator ?
                wildcard[Int(separator)] :
                wildcard[Int(asterisk)]

            let next = characters.index(after: index)
            findNode(in: childNode, characters: characters.suffix(from: next), result: &result)
        }
    }
}

extension RouteMatcher {
    public mutating func add(route: String, payload: T) {
        add(route: route.utf8, payload: payload)
    }

    public mutating func matches(route: String) -> [T] {
        return matches(route: route.utf8)
    }

    public mutating func first(route: String) -> T? {
        return matches(route: route.utf8).first
    }
}
