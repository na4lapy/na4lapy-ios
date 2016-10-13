//
//  Shelter.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Shelter: APIObject {
    fileprivate var street: String?
    fileprivate var buildingNumber: String?
    fileprivate var city: String?
    fileprivate var postalCode: String?
    fileprivate var email: String?
    fileprivate var phoneNumber: String?
    fileprivate var website: String?
    fileprivate var accountNumber: String?
    fileprivate var adoptionRules: String?
    //
    // MARK: init()
    //
    required init?(dictionary: [String:AnyObject]) {
        super.init(dictionary: dictionary)
        initializeWithDictionary(dictionary)
    }

    override class func get(_ page: Int, size: Int, preferences: UserPreferences?, success: @escaping ([AnyObject], Int) -> Void, failure: @escaping (NSError) -> Void) {
    }

    fileprivate func initializeWithDictionary(_ dictionary: [String: AnyObject]) {
    }

}
