//
//  ContentView.swift
//  CountOnMeSwiftUI
//
//  Created by mickael ruzel on 30/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var env: CalculatorModel
    var alertIsShow: Bool {
        return env.errorHasAppend
    }
    
    let buttonList: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .height, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            HStack {
                Spacer()
                Text(env.display)
                    .foregroundColor(.white)
                    .font(.system(size: 48))
                    .padding()
            }
            
            ForEach(buttonList, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButtonView(button: button) {
                            env.pressedButton(button)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .alert(isPresented: $env.errorHasAppend, content: {
            Alert(title: Text("Error"), message: Text(env.errorMessage!), dismissButton: .default(Text("Ok")))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CalculatorModel())
    }
}
