//
//  Utilities.swift
//  calc
//
//  Created by Ethan Nguyen on 16/3/21.
//  Copyright © 2021 UTS. All rights reserved.
//

import Foundation

struct Utilities {
    func isNumber(item: String) -> Bool {
        let num = Int(item)
        return num != nil
    }
    func isOperator(item: String) -> Bool {
        let elements = ["+", "-", "x", "/", "%"]
        return elements.contains(item)
    }
    
    func getPrecedence(item: String) -> Int {
        if (["x", "/", "%"].contains(item)) {
            return 2
        }
        if (["+", "-"].contains(item)) {
            return 1
        }
        return 0
    }
}
