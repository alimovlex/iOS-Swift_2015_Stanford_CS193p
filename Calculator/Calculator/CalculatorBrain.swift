//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by robot on 2/13/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation

class CalculatorBrain
{
   private enum Op {
        case Operand(Double);
        case UnaryOperation(String, (Double) -> Double);
        case BinaryOperation(String, (Double, Double) -> Double);
    
    var description: String {
        get {
            switch self {
            case .Operand(let operand):
                return "\(operand)";
            case .UnaryOperation(let symbol, _):
                return symbol;
            case .BinaryOperation(let symbol, _):
                return symbol;
            }
        }
    }
    }
   private var opStack = [Op]();
    private var knownOps = [String:Op]();
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op;
        }
        learnOp(op: Op.BinaryOperation("✖️", *));
        learnOp(op: Op.BinaryOperation("➗", {$1/$0}));
        learnOp(op: Op.BinaryOperation("➕", +));
        learnOp(op: Op.BinaryOperation("➖", {$1-$0}));
        learnOp(op: Op.UnaryOperation("√", sqrt));
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops;
            let op = remainingOps.removeLast();
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps);
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(ops:remainingOps);
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps);
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(ops:remainingOps);
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(ops: op1Evaluation.remainingOps);
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps);
                    }
                }
            }
        }
        return (nil, ops);
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(ops: opStack);
        return result;
    }
    
    func pushOperand(operand:Double) -> Double? {
        opStack.append(Op.Operand(operand));
        return evaluate();
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation);
        }
        return evaluate();
    }
};
