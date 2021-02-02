//
//  CalculatorModel.swift
//  CountOnMeSwiftUI
//
//  Created by mickael ruzel on 01/02/2021.
//

import Foundation

final class CalculatorModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var display: String = "0"
    @Published private(set) var errorMessage: String?
    @Published var errorHasAppend = false
    
    private var numberFormatter = NumberFormatter()
    
    private var calculDisplay: [String] {
        return display.split(separator: " ").map({ $0.replacingOccurrences(of: ",", with: ".") })
    }
    
    private var operatorHasBeenPress: Bool {
        return calculDisplay.last == "+" || calculDisplay.last == "-"
            || calculDisplay.last == "X" || calculDisplay.last == "/"
    }
    
    private var canAddOperator: Bool {
        return calculDisplay.count > 0 && !operatorHasBeenPress && display != "0"
    }
    
    private var calculIsEmpty: Bool {
        return calculDisplay.count == 1 && calculDisplay.first == "0"
    }
    private var calculeIsCorrect: Bool {
        return calculDisplay.count >= 3 && !operatorHasBeenPress
    }
    
    
    // MARK: - Methodes
    
    func pressedButton(_ button: CalculatorButton) {
        switch button.type {
        case .number: numberHasBeenPress(button)
        case .equal: pressedEqualdButton()
        case .oper: operatorHasBeenPress(button)
        case .clear: resetCalcul()
        case .other: otherTouchHasBeenPress(button)
        }
    }
    
    private func otherTouchHasBeenPress(_ button: CalculatorButton) {
        if button == .plusMinus {
            errorHasAppend.toggle()
            errorMessage = "Oops il y a eu une erreur"
        }
        if button == .percent {
            operatorHasBeenPress(button)
        }
    }
    
    private func pressedEqualdButton() {
        guard calculeIsCorrect else {
            errorMessage = "Please enter a correct calcul"
            errorHasAppend.toggle()
            resetCalcul()
            return
        }
        
        var currentCalcul = calculDisplay
        var result: Double  = 0
        
        while currentCalcul.contains("X") || currentCalcul.contains("/") {
            guard let index = currentCalcul.firstIndex(where: { $0 == "X" || $0 == "/" }) else { return }
            let left = currentCalcul[index - 1]
            let operand = currentCalcul[index]
            let right = currentCalcul[index + 1]
            
            result = calculate(left: left, operand: operand, right: right)
            
            currentCalcul[index] = "\(result)"
            currentCalcul.remove(at: index + 1)
            currentCalcul.remove(at: index - 1)
        }
        
        while currentCalcul.contains("%") {
            guard let percentIndex = currentCalcul.firstIndex(of: "%") else { return }
            let index = percentIndex - 2
            let left = currentCalcul[index - 1]
            let operand = currentCalcul[index]
            let right = currentCalcul[index + 1]
            
            let percentage = calculate(left: left, operand: "%", right: right)
            
            result = calculate(left: left, operand: operand, right: String(percentage))
            
            currentCalcul[index] = "\(result)"
            currentCalcul.remove(at: index + 2)
            currentCalcul.remove(at: index + 1)
            currentCalcul.remove(at: index - 1)
            
        }
        
        while currentCalcul.count > 1 {
            let left = currentCalcul[0]
            let operand = currentCalcul[1]
            let right = currentCalcul[2]
            
            result = calculate(left: left, operand: operand, right: right)
            
            currentCalcul.removeFirst(3)
            currentCalcul.insert("\(result)", at: 0)

        }
            
        numberFormatter.decimalSeparator = ","
        numberFormatter.numberStyle = .decimal
        
        display = numberFormatter.string(for: result)!
    }
    
    private func calculate(left: String, operand: String, right: String) -> Double {
        guard let left = Double(left) else { return Double() }
        guard let right = Double(right) else { return Double() }
        
        switch operand {
        case "+": return left + right
        case "-": return left - right
        case "X": return left * right
        case "/": return left / right
        case "%": return left * (right / 100)
        default: return Double()
        }
    }
    
    private func numberHasBeenPress(_ button: CalculatorButton) {
        if calculIsEmpty {
            if button == .decimal {
                display.append(button.title)
                return
            }
            display = button.title
        } else {
            guard !(calculDisplay.last == "/" && button == .zero) else {
                errorMessage = "You can't divide by zero"
                errorHasAppend.toggle()
                resetCalcul()
                return
            }
            display.append(button.title)
        }
    }
    
    private func operatorHasBeenPress(_ button: CalculatorButton) {
        guard canAddOperator else { return }
        display.append(" \(button.title) ")
    }
    
    private func resetCalcul() {
        display = "0"
    }
}
