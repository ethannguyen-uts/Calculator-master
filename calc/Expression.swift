//
//  Expression.swift
//  calc
//
//  Created by Ethan Nguyen on 15/3/21.
//  Copyright © 2021 UTS. All rights reserved.
//
import Foundation
struct Expression {
    var utilities = Utilities()
    var expression: [String]
    init (expression: [String]) {self.expression = expression}
    //Convert from Infix to Postfix erpression
    func infixToPostfix() throws -> String {
        var infixExpression : String = ""
        var operatorStack = Stack<String>()
        //expression must have an odd number of tokens
        if (expression.count % 2 == 0) {
            throw CalculateError.invalidInput
        }
        
        /*
         Shunting-yard algorithm
         https://en.wikipedia.org/wiki/Shunting-yard_algorithm
        */
        for (index, token) in (self.expression).enumerated() {
            if utilities.isNumber(item: token) {
                infixExpression.append(" ");
                infixExpression.append(token)
            } else if utilities.isOperator(item: token) {
                if index + 1 == self.expression.count {
                    //last character must not be an operator
                    throw CalculateError.invalidInput
                }
                if (!utilities.isNumber(item: (self.expression)[index + 1])){
                    //if current Item is an operator, so the next item must be an number
                    throw CalculateError.invalidInput
                }
                while (
                    (operatorStack.len() > 0)
                        &&
                        (utilities.isOperator(item: (operatorStack.data[operatorStack.len() - 1])))
                        && (
                            (utilities.getPrecedence(item: (operatorStack.data[operatorStack.len() - 1])) > utilities.getPrecedence(item: token))
                                || (utilities.getPrecedence(item: (operatorStack.data[operatorStack.len() - 1])) == utilities.getPrecedence(item: token) /* && all operators has left associative*/)
                        )
                        && (operatorStack.data[operatorStack.len() - 1] != "(")
                ) {
                    infixExpression.append(" ");
                    infixExpression.append(operatorStack.pop())
                }
                operatorStack.push(item: token)
            } else if(token == "(") {
                operatorStack.push(item: token)
            } else if(token == "(") {
                if (operatorStack.len() > 0){
                    while ((operatorStack.len() > 0) && (operatorStack.data[operatorStack.len() - 1] != "(")) {
                        infixExpression.append(" ");
                        infixExpression.append(operatorStack.pop())
                        /* If the stack runs out without finding a left parenthesis, then there are mismatched parentheses. */
                        //Not yet implemented because we dont need parathensis
                    }
                }
                if (operatorStack.data[operatorStack.len() - 1] != "(") {
                    _ = operatorStack.pop()
                }
                //if there is a function token at the top of the operator stack, then:pop the function from the operator stack onto the output queue. (No functions in assignment)
            } else { throw CalculateError.invalidInput}
        }
        while (!operatorStack.isEmpty()) {
            /* If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses. => skip */
            //pop the operator from the operator stack onto the output queue.
            infixExpression.append(" ");
            infixExpression.append(operatorStack.pop())
        }
        //End algorithm
        //return the postfix expression
        if (infixExpression.count > 0) {
            //remove the first space
            infixExpression.remove(at: infixExpression.startIndex)
        }
        return infixExpression
    }
}
