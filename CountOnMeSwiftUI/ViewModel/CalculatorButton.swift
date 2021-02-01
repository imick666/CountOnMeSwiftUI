//
//  CalculatorButton.swift
//  CountOnMeSwiftUI
//
//  Created by mickael ruzel on 01/02/2021.
//

import SwiftUI

enum calculatorButtonType {
    case number, oper, other, clear, equal
}

enum CalculatorButton {
    
    case one, two, three, four, five, six, seven, height, nine, zero
    case plus, minus, multiply, divide, equal
    case ac, plusMinus, percent
    case decimal
    
    var backgroundColor: Color {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .height, .nine, .zero, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.gray)
        default: return Color(.orange)
        }
    }
    
    var title: String {
        switch self {
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .height: return "8"
        case .nine: return "9"
        case .zero: return "0"
        case .decimal: return ","
        case .equal: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .divide: return "/"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .ac: return "AC"
        }
    }
    
    var type: calculatorButtonType {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .height, .nine, .zero, .decimal:
            return .number
        case .plus, .minus, .divide, .multiply:
            return .oper
        case .ac:
            return .clear
        case .equal:
            return .equal
        default: return .other
        }
    }
}
