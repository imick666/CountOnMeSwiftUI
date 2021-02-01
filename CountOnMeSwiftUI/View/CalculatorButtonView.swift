//
//  CalculatorButtonView.swift
//  CountOnMeSwiftUI
//
//  Created by mickael ruzel on 01/02/2021.
//

import SwiftUI

struct CalculatorButtonView: View {
    
    // MARK: - Properties
    
    var button: CalculatorButton
    var action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(button.title)
                .foregroundColor(.white)
                .font(.title)
                .frame(width: getButtonSize(button: button).width, height: getButtonSize(button: button).height)
                .background(button.backgroundColor)
                .clipShape(Capsule())
        })
    }
    
    // MARK: - Methodes
    
    private func getButtonSize(button: CalculatorButton) -> CGRect {
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

struct CalculatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonView(button: .five) { }
            .previewLayout(.sizeThatFits)
    }
}
