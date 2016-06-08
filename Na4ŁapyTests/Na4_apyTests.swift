//
//  Na4_apyTests.swift
//  Na4ŁapyTests
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import XCTest
@testable import Na4Łapy

class Na4ŁapyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testAnimalInitWithWrongParams1() {
        let animal = Animal(dictionary: [
            "errKey":"errValue"
            ])
        XCTAssertNil(animal)
    }

    func testAnimalInitWithInsufficientParams1() {
        let animal = Animal(dictionary: [
            JsonAttr.Id:1,
            ])
        XCTAssertNil(animal)
    }

    func testAnimalInitWithInsufficientParams2() {
        let animal = Animal(dictionary: [
            JsonAttr.Name:"Vika",
            ])
        XCTAssertNil(animal)
    }

    func testAnimalInitWithGoodParams() {
        let animal = Animal(dictionary: [
                JsonAttr.Id:1,
                JsonAttr.Name:"Vika",
                JsonAttr.Gender:Gender.Female.rawValue,
                JsonAttr.Activity:Activity.High.rawValue,
                JsonAttr.Description:"My belowed doggy!",
                JsonAttr.Vaccination:Vaccination.Basic.rawValue,
                JsonAttr.Training:Training.Basic.rawValue,
                JsonAttr.Size:Size.Medium.rawValue
            ])
        XCTAssertNotNil(animal)
    }
        
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
