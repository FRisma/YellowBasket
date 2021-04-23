//
//  YellowBasketTests.swift
//  YellowBasketTests
//
//  Created by Franco on 23/04/21.
//  Copyright © 2021 FRisma. All rights reserved.
//

@testable import YellowBasket
import XCTest

class YellowBasketTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringExtension() throws {
        let someMoney: Double = 2
        let resultString = String.convert(toMoneyFromDouble: someMoney)
        
        XCTAssertEqual(resultString, "$ 2.00", "Failed conversion")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
