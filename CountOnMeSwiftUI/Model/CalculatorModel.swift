//
//  CalculatorModel.swift
//  CountOnMeSwiftUI
//
//  Created by mickael ruzel on 01/02/2021.
//

import Foundation

class CalculatorModel: ObservableObject {
    
    @Published var display: String?
    
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
        
        var result = 0.0
        
        while currentCalcul.count > 1 {
            guard let left = Double(currentCalcul[0]) else { return }
            let oper = currentCalcul[1]
            guard let right = Double(currentCalcul[2]) else { return }
            
            switch oper {
            case "+": result = left + right
            case "-": result = left - right
            case "X": result = left * right
            case "/": result = left / right
            default: return
            }
            
            currentCalcul.removeFirst(3)
            currentCalcul.insert("\(result)", at: 0)

        }
                
        display = "\(result)".replacingOccurrences(of: ".", with: ",")
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
