//
//  Shelter.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Shelter: APIObject {
    private var street: String?
    private var buildingNumber: String?
    private var city: String?
    private var postalCode: String?
    private var email: String?
    private var phoneNumber: String?
    private var website: String?
    private var accountNumber: String?
    private var adoptionRules: String?
    //
    // MARK: init()
    //
    required init?(dictionary: [String:AnyObject]) {
        super.init(dictionary: dictionary)
        initializeWithDictionary(dictionary)
    }

    override class func get(page: Int, size: Int, preferences: UserPreferences?, success: ([AnyObject], Int) -> Void, failure: (NSError) -> Void) {
    }

    private func initializeWithDictionary(dictionary: [String: AnyObject]) {
    }

}
