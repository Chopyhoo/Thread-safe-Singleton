//
//  SettingsManagerTests.swift
//  Tests iOS
//
//  Created by Алексей Соболевский on 21.11.22.
//

import XCTest

class SettingsManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConcurrentUsage() {
        let concurrentQueue = DispatchQueue(label: "TestQueue",
                                            attributes: .concurrent)

        let expect = expectation(description: "Using SettingsManager.shared from multiple threads shall succeed")
        
        let callCount = 100
        
        for callIndex in 0...callCount {
            concurrentQueue.async {
                SettingsManager.shared.set(value: callIndex, forKey: String(callIndex))
            }
        }

        while SettingsManager.shared.int(forKey: String(callCount)) != callCount { }
        
        expect.fulfill()
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "Test expectation failed")
        }
    }

}
