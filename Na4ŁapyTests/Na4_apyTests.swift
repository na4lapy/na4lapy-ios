//
//  Na4_apyTests.swift
//  Na4ŁapyTests
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
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
            "errKey":"errValue" as AnyObject
            ])
        XCTAssertNil(animal)
    }

    func testAnimalInitWithInsufficientParams1() {
        let animal = Animal(dictionary: [
            JsonAttr.id:1 as AnyObject,
            ])
        XCTAssertNil(animal)
    }

    func testAnimalInitWithInsufficientParams2() {
        let animal = Animal(dictionary: [
            JsonAttr.name:"Vika" as AnyObject,
            ])
        XCTAssertNil(animal)
    }

    func testAnimalInitWithGoodParams() {
        let animal = Animal(dictionary: [
                JsonAttr.id:1 as AnyObject,
                JsonAttr.name:"Vika" as AnyObject,
                JsonAttr.gender:Gender.female.rawValue as AnyObject,
                JsonAttr.activity:Activity.high.rawValue as AnyObject,
                JsonAttr.description:"My belowed doggy!" as AnyObject,
                JsonAttr.vaccination:Vaccination.basic.rawValue as AnyObject,
                JsonAttr.training:Training.basic.rawValue as AnyObject,
                JsonAttr.size:Size.medium.rawValue as AnyObject
            ])
        XCTAssertNotNil(animal)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
