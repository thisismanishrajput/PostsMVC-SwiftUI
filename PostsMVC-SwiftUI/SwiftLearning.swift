//
//  SwiftLearning.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

func fetchFruits() -> [String]{
    let fruits = ["Apple","Banana","Orange"]
    return fruits
}

func logFruits() {
    let fruits = fetchFruits()
    print(fruits)
}

func runSwiftLearningPlayground() {
    // Put any experimental Swift code here. This function is safe to call from anywhere.

    // Example 1: Using existing code
    let fruits = fetchFruits()
    print("Fruits:", fruits)

    // Example 2: Quick algorithm/playground snippet
    let numbers = [1, 2, 3, 4, 5]
    let squares = numbers.map { $0 * $0 }
    print("Squares:", squares)

    // Example 3: Optionals and string interpolation
    let maybeName: String? = "Taylor"
    if let name = maybeName {
        print("Hello, \(name)!")
    } else {
        print("Hello, stranger!")
    }
}

#if DEBUG && SWIFT_LEARNING_PLAYGROUND
private enum _SwiftLearningPlaygroundBootstrap {
    static let run: Void = {
        // This executes once when the type is first referenced.
        runSwiftLearningPlayground()
    }()
}

// Reference the static to trigger the side effect without a top-level expression.
@inline(__always)
private func _triggerSwiftLearningPlayground() {
    _ = _SwiftLearningPlaygroundBootstrap.run
}

// Ensure the trigger is referenced by something that will be linked; placing in a function avoids top-level expressions.
@discardableResult
public func enableSwiftLearningPlaygroundBootstrap() -> Bool {
    _triggerSwiftLearningPlayground()
    return true
}
#endif
