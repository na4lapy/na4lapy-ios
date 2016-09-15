//
//  UserPreferences.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 07.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class UserPreferences {
    private var typeDog: Bool?
    private var typeCat: Bool?
    private var typeOther: Bool?
    private var genderFemale: Bool?
    private var genderMale: Bool?
    private var ageMin: Int = 0
    private var ageMax: Int = 20
    private var sizeSmall: Bool?
    private var sizeMedium: Bool?
    private var sizeLarge: Bool?
    private var activityLow: Bool?
    private var activityHigh: Bool?
    private final let USER_PREFERENCES_KEY = "UserPreferences"
    private var userPreferencesDictionary = [String: Int]()

    init(typeDog: Bool?, typeCat: Bool?, typeOther: Bool?, genderFemale: Bool?, genderMale: Bool?, ageMin: Int, ageMax: Int, sizeSmall: Bool?, sizeMedium: Bool?, sizeLarge: Bool?, activityLow: Bool?, activityHigh: Bool?) {
        self.typeDog = typeDog
        self.typeCat = typeCat
        self.typeOther = typeOther
        self.genderFemale = genderFemale
        self.genderMale = genderMale
        self.ageMin = ageMin
        self.ageMax = ageMax
        self.sizeSmall = sizeSmall
        self.sizeMedium = sizeMedium
        self.sizeLarge = sizeLarge
        self.activityLow = activityLow
        self.activityHigh = activityHigh

    }

    convenience init?() {
        if let animalPreferences = NSUserDefaults.standardUserDefaults().dictionaryForKey("UserPreferences") {

        print(NSUserDefaults.standardUserDefaults().dictionaryRepresentation())
        self.init(
            typeDog: animalPreferences["DOG"] as? Bool,
            typeCat: animalPreferences["CAT"] as? Bool,
            typeOther: animalPreferences["OTHER"] as? Bool,
            genderFemale: animalPreferences["FEMALE"] as? Bool,
            genderMale: animalPreferences["MALE"] as? Bool,
            ageMin: animalPreferences["minAge"] as! Int,
            ageMax: animalPreferences["maxAge"] as! Int,
            sizeSmall: animalPreferences["SMALL"] as? Bool,
            sizeMedium: animalPreferences["MEDIUM"] as? Bool,
            sizeLarge: animalPreferences["LARGE"] as? Bool,
            activityLow: animalPreferences["LOW"] as? Bool,
            activityHigh: animalPreferences["HIGH"] as? Bool
            )
        } else {
            return nil
        }
    }


    func togglePreferenceAtIndex(preferenceIndex: Int) {

    }


    func dictionaryRepresentation() -> [String: Int] {

        if (userPreferencesDictionary.isEmpty) {
            userPreferencesDictionary["DOG"] = Int(self.typeDog ?? 0)
            userPreferencesDictionary["CAT"] = Int(self.typeCat ?? 0)
            userPreferencesDictionary["OTHER"] = Int(self.typeOther ?? 0)
            userPreferencesDictionary["FEMALE"] = Int(self.genderFemale ?? 0)
            userPreferencesDictionary["MALE"] = Int(self.genderMale ?? 0)
            userPreferencesDictionary["SMALL"] = Int(self.sizeSmall ?? 0)
            userPreferencesDictionary["MEDIUM"] = Int(self.sizeMedium ?? 0)
            userPreferencesDictionary["LARGE"] = Int(self.sizeLarge ?? 0)
            userPreferencesDictionary["HIGH"] = Int(self.activityHigh ?? 0)
            userPreferencesDictionary["LOW"] = Int(self.activityLow ?? 0)
            userPreferencesDictionary["minAge"] = self.ageMin
            userPreferencesDictionary["maxAge"] = self.ageMax
        }

        return  userPreferencesDictionary
    }

    func savePreferencesToUserDefault() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.dictionaryRepresentation(), forKey: USER_PREFERENCES_KEY)
    }
}
