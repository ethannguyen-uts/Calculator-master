//
//  Calculator.swift
//  calc
//
//  Created by Nhat Huy Nguyen on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    /// For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0;
    var utilities = Utilities()
    var calculatorStack = Stack<String>()
    //Apply postfix expression and stack to calculate result
    func evaluate(postfixExpression: String) throws -> String {
        let data = postfixExpression.components(separatedBy: " ")
        for (token) in data {
            if (utilities.isNumber(item: token)) {
                //if item is a number push to stack
                calculatorStack.push(item: token)
            } else if (utilities.isOperator(item: token)) {
                //if it is an operator, pop two number from stack and calculate
                let b : Int? = Int(calculatorStack.pop())
                let a : Int? = Int(calculatorStack.pop())
                var tmpValue = 0
                switch token {
                    case "+":
                        tmpValue = add(no1: a!, no2: b!)
                    case "-":
                        tmpValue = subtract(no1: a!, no2: b!)
                    case "x":
                        tmpValue = multiply(no1: a!, no2: b!)
                    case "/":
                        //divide by zero
                         do { tmpValue = try divide(no1: a!, no2: b!) }
                         catch {
                            throw error
                        }
                    case "%":
                        tmpValue = remain(no1: a!, no2: b!)
                    default:
                        break
                    }
                //After calculate, push result to the stack
                calculatorStack.push(item: String(tmpValue));
            }
        }
        //final item in the stack is the result
        if calculatorStack.isEmpty() {return "0"} else {
            var str = calculatorStack.pop()
            str = str.replacingOccurrences(of: "+", with: "")
            return str
        }
    }
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2;
    }
    func subtract(no1: Int, no2: Int) -> Int {
        return no1 - no2;
    }
    func multiply(no1: Int, no2: Int) -> Int {
        return no1 * no2;
    }
    func divide(no1: Int, no2: Int) throws -> Int {
        if no2 == 0 {throw CalculateError.divisionByZero}
        return no1 / no2;
    }
    func remain(no1: Int, no2: Int) -> Int {
        return no1 % no2;
    }
    func calculate(args: [String]) throws -> String {
        let expression = Expression(expression: args);
        do {
            //Convert to Postfix expression
            let postfixExpression = try expression.infixToPostfix();
            //Calculate the result using Postfix Expression and Stack
            let result = try evaluate(postfixExpression: postfixExpression);
            return(result)
        } catch {
            throw error
        }
    }
}
