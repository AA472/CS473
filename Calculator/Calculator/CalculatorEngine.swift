//
//  CalculatorEngine.swift
//  Calculator
//
//  Created by Aljandali, Abdullah on 9/4/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import Foundation

class CalculatorEngine{
    var previousNum: Double = 0
    var previousOp: String = "C"
    var performingMath = false;
    var replace = false;
    var operand2: Double = 0
    var newResult: String = "ERROR"
    var previousClick: String = "C"
    
    func buttonPressed(buttonTitle: String, currentDisplay: String) -> String{
        
        
        switch buttonTitle {
            
        case ".":
            if currentDisplay.contains("."){
                newResult = currentDisplay
            }
            else{
                newResult = currentDisplay + "."
            }
            
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if (currentDisplay == "0"){
                newResult = buttonTitle;
            }
            else if (currentDisplay == "-0"){
                newResult = "-" + buttonTitle;
            }
            else{
                if(replace){
                    newResult = buttonTitle;
                    replace = false;
                }
                else{
                    newResult = currentDisplay + buttonTitle
                }
            }
            
        case "+", "-", "÷", "✕":

            if(performingMath)
            {
                if(previousClick != "+" && previousClick != "-" && previousClick != "÷" && previousClick != "✕"){
                    newResult = math(operation: buttonTitle, a: previousNum, b: Double(currentDisplay)!)
                }
            }
            
            previousOp = buttonTitle;
            performingMath = true;
            if(newResult != "ERROR"){
                previousNum = Double(newResult)!
            }
            replace = true;
            
        case "=":
            if(performingMath){
                operand2 = Double(currentDisplay)!
            }
            newResult =  math(operation: previousOp, a: previousNum, b: operand2)
            
            if(newResult != "ERROR"){
                previousNum = Double(newResult)!
            }
            performingMath = false;
            
        case "Sin":
            newResult = String (sin(Double(currentDisplay)!));
        case "Cos":
            newResult = String (cos(Double(currentDisplay)!));
        case "Tan":
            newResult = String (tan(Double(currentDisplay)!));
        case "+/-":
            newResult = String( -1 * (Double(currentDisplay)!))
        case "1/x":
            if(Double(currentDisplay) == 0){
                newResult = "ERROR";
            }
            else{
                newResult = String (1 /  (Double(currentDisplay)!));
            }
        case "√":
            if(Double(currentDisplay)! < 0){
                newResult = "ERROR";
            }
            else{
                newResult = String ((Double(currentDisplay)!).squareRoot());
            }
        case "C":
            newResult = "0"
            performingMath = false;
        default:
            return "0"
        }
        
        if buttonTitle != "."{
        newResult = removeZeros(number: newResult)
        }
        if newResult != "ERROR" {
            if(Double(newResult)! > 999999999999999){
                newResult = "ERROR"
            }
        }
        
        previousClick = buttonTitle
        
        return newResult
        
        
    }
    
    func math (operation: String, a: Double, b: Double) -> String{
        var answer: Double = 0;
        
        
        switch operation {
        case "+":
            answer = a + b
        case "-":
            answer = a - b
        case "÷":
            if(b == 0){
                return "ERROR"
            }else{
                answer = a/b
            }
        case "✕":
            answer = a * b
            
        default:
            answer = 0
        }
        return String(answer)
    }
    
    func removeZeros(number: String ) -> String{
        if number == "ERROR"{
            return number
        }
        else{
            let temp = Double(number)
            if floor(temp!) == temp{
                return String(Int(temp!))
            }
            else{
                return String(temp!)
            }
        }
    }
}
