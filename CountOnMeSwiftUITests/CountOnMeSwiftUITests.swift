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

    func testTwoDotTwoPlusTwo() {
        env?.pressedButton(.two)
        env?.pressedButton(.decimal)
        env?.pressedButton(.two)
        env?.pressedButton(.plus)
        env?.pressedButton(.two)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "4,2")
    }
    
    func testTwoMultiplyByThree() {
        env?.pressedButton(.two)
        env?.pressedButton(.multiply)
        env?.pressedButton(.three)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "6")
    }
    
    func testOnePlusTwoMultiplyByTwo() {
        env?.pressedButton(.one)
        env?.pressedButton(.plus)
        env?.pressedButton(.two)
        env?.pressedButton(.multiply)
        env?.pressedButton(.two)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "5")
    }
    
    func testCalculIsIncorrect() {
        env?.pressedButton(.two)
        env?.pressedButton(.plus)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.errorHasAppend, true)
        XCTAssertEqual(env?.display, "0")
    }
    
    func testDivideByZero() {
        env?.pressedButton(.two)
        env?.pressedButton(.divide)
        env?.pressedButton(.zero)
        
        XCTAssertEqual(env?.errorHasAppend, true)
        XCTAssertEqual(env?.display, "0")
    }

}
