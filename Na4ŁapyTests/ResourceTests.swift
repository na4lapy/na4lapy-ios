//
//  ResourceTests.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 01/04/2017.
//  Copyright © 2017 Koduj dla Polski. All rights reserved.
//

import XCTest
@testable import Na4Łapy

class ResourceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let resource = Resource<Shelter>(endPoint: EndPoint.shelter, parse: { json in
            guard let dictionaries = json as? [JSONDictionary] else { return nil }
            return dictionaries.flatMap(Shelter.init) as? Shelter
        })

    }

    override func tearDown() {

        super.tearDown()
    }
    
    func testExample() {

    }
    
}
