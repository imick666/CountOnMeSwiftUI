//
//  CountOnMeSwiftUITests.swift
//  CountOnMeSwiftUITests
//
//  Created by mickael ruzel on 30/01/2021.
//

import XCTest
@testable import CountOnMeSwiftUI

class CountOnMeSwiftUITests: XCTestCase {
    
    var env: CalculatorModel?
    
    override func setUp() {
        env = CalculatorModel()
        super.setUp()
    }
    
    override func tearDown() {
        env = nil
        super.tearDown()
    }

    func testTwoPlusTwo() {
        env?.pressedButton(.two)
        env?.pressedButton(.plus)
        env?.pressedButton(.two)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "4,0")
    }
    
    func testTwoMultiplyByThree() {
        env?.pressedButton(.two)
        env?.pressedButton(.multiply)
        env?.pressedButton(.three)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "6,0")
    }

}
