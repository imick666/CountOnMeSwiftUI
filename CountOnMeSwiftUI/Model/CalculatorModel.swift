//
//  CalculatorModel.swift
//  CountOnMeSwiftUI
//
//  Created by mickael ruzel on 01/02/2021.
//

import Foundation

class CalculatorModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var display: String?
    
    private var numberFormatter = NumberFormatter()
    
    private var calculDisplay: [String] {
        return display?.components(separatedBy: " ").map({$0.replacingOccurrences(of: ",", with: ".")}) ?? []
    }
    
    private var operatorHasBeenPress: Bool {
        return calculDisplay.last == "+" || calculDisplay.last == "-"
            || calculDisplay.last == "X" || calculDisplay.last == "/"
    }
    
    private var canAddOperator: Bool {
        return calculDisplay.count > 0 && !operatorHasBeenPress
    }
    
    private var calculIsEmpty: Bool {
        return calculDisplay.isEmpty
    }
    
    
    // MARK: - Methodes
    
    func pressedButton(_ button: CalculatorButton) {
        switch button.type {
        case .number: numberHasBeenPress(button)
        case .equal: pressedEqualdButton()
        case .oper: operatorHasBeenPress(button)
        case .clear: display = nil
        default: return
        }
    }
    
    private func pressedEqualdButton() {
        guard calculDisplay.count >= 3 && !operatorHasBeenPress else { return }
        
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
        
        display = numberFormatter.string(for: result)
    }
    
    private func calculate(left: String, operand: String, right: String) -> Double {
        guard let left = Double(left) else { return Double() }
        guard let right = Double(right) else { return Double () }
        
        switch operand {
        case "+": return left + right
        case "-": return left - right
        case "X": return left * right
        case "/": return left / right
        default: return Double()
        }
    }
    
    private func numberHasBeenPress(_ button: CalculatorButton) {
        if display == nil {
            if button == .decimal {
                display = "0,"
                return
            }
            display = button.title
        } else {
            guard !operatorHasBeenPress else {
                display?.append(" \(button.title)")
                return
            }
            display?.append(button.title)
        }
    }
    
    private func operatorHasBeenPress(_ button: CalculatorButton) {
        if canAddOperator {
            display?.append(" \(button.title)")
        }
    }
    
}
