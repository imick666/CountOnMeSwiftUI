//
//  CountOnMeSwiftUITests.swift
//  CountOnMeSwiftUITests
//
//  Created by mickael ruzel on 30/01/2021.
//

import XCTest
@testable import CountOnMeSwiftUI

class CountOnMeSwiftUITests: XCTestCase {
    
    // MARK: - Properties
    
    var env: CalculatorModel?
    
    // MARK: - Init
    
    override func setUp() {
        env = CalculatorModel()
        super.setUp()
    }
    
    override func tearDown() {
        env = nil
        super.tearDown()
    }

    // MARK: - Calcul Tests
    
    func testZeroDotTwoPlusTwo() {
        env?.pressedButton(.decimal)
        env?.pressedButton(.two)
        env?.pressedButton(.plus)
        env?.pressedButton(.two)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "2,2")
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
    
    func testTwoMinusThree() {
        env?.pressedButton(.two)
        env?.pressedButton(.minus)
        env?.pressedButton(.three)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "-1")
    }
    
    func testFiveDevideByTwo() {
        env?.pressedButton(.five)
        env?.pressedButton(.divide)
        env?.pressedButton(.two)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "2,5")
        XCTAssertEqual(env?.errorHasAppend, false)
    }
    
    func testClearButtonPressed() {
        env?.pressedButton(.two)
        env?.pressedButton(.plus)
        env?.pressedButton(.ac)
        
        XCTAssertEqual(env?.display, "0")
    }
    
    func testTwoHundredMinusFifteePercent() {
        env?.pressedButton(.two)
        env?.pressedButton(.zero)
        env?.pressedButton(.zero)
        env?.pressedButton(.minus)
        env?.pressedButton(.five)
        env?.pressedButton(.zero)
        env?.pressedButton(.percent)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "100")
    }
    
    func testHundredPlusHundredPercent() {
        env?.pressedButton(.one)
        env?.pressedButton(.zero)
        env?.pressedButton(.zero)
        env?.pressedButton(.plus)
        env?.pressedButton(.one)
        env?.pressedButton(.zero)
        env?.pressedButton(.zero)
        env?.pressedButton(.percent)
        env?.pressedButton(.equal)
        
        XCTAssertEqual(env?.display, "200")
    }
    
    // MARK: - Error Tests
    
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
    
    func testAddMultipleOperand() {
        env?.pressedButton(.two)
        env?.pressedButton(.plus)
        env?.pressedButton(.multiply)
        
        XCTAssertEqual(env?.display, "2 + ")
    }
    
    func testBeginWithOperand() {
        env?.pressedButton(.plus)
        
        XCTAssertEqual(env?.display, "0")
    }

}
