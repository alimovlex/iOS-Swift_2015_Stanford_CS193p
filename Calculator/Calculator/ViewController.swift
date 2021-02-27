//
//  ViewController.swift
//  Calculator
//
//  Created by robot on 2/12/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit;

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!;
    
    var userIsInTheMiddleOfTypingAnumber:Bool = false;
    
    var brain = CalculatorBrain();
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle;
        if userIsInTheMiddleOfTypingAnumber {
        display.text = display.text! + digit!;
        }
        else
        {
            display.text = digit;
            userIsInTheMiddleOfTypingAnumber = true;
        }
        //print("digit = \(digit!)");
    }
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingAnumber {
            enter();
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(symbol: operation) {
                displayValue = result;
            }
            else {
                displayValue = 0;
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingAnumber = false;
        if let result = brain.pushOperand(operand: displayValue) {
            displayValue = result;
        }
        else {
            displayValue = 0;
        }
    }
    var displayValue: Double {
        get {
            return (display.text! as NSString).doubleValue;
        }
        set {
            display.text = "\(newValue)";
        }
    }
    
}

