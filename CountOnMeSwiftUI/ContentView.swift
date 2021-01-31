//
//  ContentView.swift
//  CountOnMeSwiftUI
//
//  Created by mickael ruzel on 30/01/2021.
//

import SwiftUI

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
}

struct ContentView: View {
    
    @State var actualCalcul: [String] = ["bonjour", "je", "suis"]
    
    let buttonList: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .height, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            HStack {
                Spacer()
                Text(actualCalcul.joined(separator: " "))
                    .padding()
                    .foregroundColor(.white)
                    .font(.title)
            }
            
            ForEach(buttonList, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButtonView(button: button)
                    }
                }
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text(button.title)
                .foregroundColor(.white)
                .font(.title)
                .frame(width: buttonSize(button: button).width, height: buttonSize(button: button).height)
                .background(button.backgroundColor)
                .clipShape(Capsule())
        })
    }
    
    private func buttonSize(button: CalculatorButton) -> CGRect {
        var height: CGFloat {
            (UIScreen.main.bounds.width - ( 10 * 5 )) / 4
        }
        
        var width: CGFloat {
            guard button != .zero else {
                return (height * 2) + 10
            }
            return height
        }
        
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
