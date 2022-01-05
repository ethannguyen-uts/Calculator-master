//
//  Stack.swift
//  calc
//
//  Created by Ethan Nguyen on 15/3/21.
//  Copyright © 2021 UTS. All rights reserved.
//

import Foundation

struct Stack<T> {
    var data: [T] = []
    mutating func push(item: T) {
        data.append(item)
    }
    mutating func pop() -> T {
        return data.removeLast()
    }
    mutating func len() -> Int {
        return data.count
    }
    mutating func isEmpty() -> Bool {
        return data.count == 0
    }
}
