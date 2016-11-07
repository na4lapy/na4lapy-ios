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
    fileprivate var voivodeship: String?
    fileprivate var facebookProfile: String?
    //
    // MARK: init()
    //
    required init?(dictionary: [String:AnyObject]) {
        super.init(dictionary: dictionary)
        initializeWithDictionary(dictionary: dictionary)
    }

    override class func get(_ page: Int, size: Int, preferences: UserPreferences?, success: @escaping ([AnyObject], Int) -> Void, failure: @escaping (NSError) -> Void) {

        if (page < 0) {
            failure(Err.illegalPageNumber.err())
            return
        }

        let urlstring = baseUrl + EndPoint.shelter + "/1"

        guard let enpoint = NSURL(string: urlstring) else {
            failure(Err.wrongURL.err())
            return
        }

        Request.getJSONData(enpoint as URL, success: { (json, count) in
            let shelter = Shelter.jsonToObj(json) //HACK should be changed
            success(shelter, count)
        }) { (error) in
            failure(error)
        }
    }

    func getAdress() -> String {
        guard let
            street = self.street,
            let builidingNumber = self.buildingNumber

                else {
                    return ""
                }

        return street + " " + builidingNumber
    }

    func getAdressSecondLine() -> String {
        guard let
            postalCode = postalCode,
            let city = self.city else {
                return " "
            }
        return postalCode + " " + city
    }

    private func initializeWithDictionary(dictionary: [String: AnyObject]) {

        for (key, value) in dictionary {
            switch key {
            case ShelterJsonAttr.accountNumber:
                if let accountNumber = value as? String {
                    self.accountNumber = accountNumber
                }
            case  ShelterJsonAttr.adoptionRules:
                if let adoptionRules = value as? String {
                    self.adoptionRules = adoptionRules
                }
            case ShelterJsonAttr.buildingNumber:
                if let buildingNumber = value as? String {
                    self.buildingNumber = buildingNumber
                }
            case ShelterJsonAttr.city:
                if let city = value as? String {
                    self.city = city
                }
            case ShelterJsonAttr.email:
                if let email = value as? String {
                    self.email = email
                }
            case ShelterJsonAttr.facebookProfile:
                if let facebookProfile = value as? String {
                    self.facebookProfile = facebookProfile
                }
            case ShelterJsonAttr.id:
                break
            case ShelterJsonAttr.name:
                break
            case ShelterJsonAttr.phoneNumber:
                if let phoneNumber = value as? String {
                    self.phoneNumber = phoneNumber
                }
            case ShelterJsonAttr.postalCode:
                if let postalCode = value as? String {
                    self.postalCode = postalCode
                }
            case ShelterJsonAttr.street:
                if let street = value as? String {
                    self.street = street
                }
            case ShelterJsonAttr.voivodeship:
                if let voivodeship = value as? String {
                    self.voivodeship = voivodeship
                }
            case ShelterJsonAttr.website:
                if let website = value as? String {
                    self.website = website
                }
            default:
                log.error(Err.wrongJsonKey.desc() + " \(key)")
             }
        }
    }

}
