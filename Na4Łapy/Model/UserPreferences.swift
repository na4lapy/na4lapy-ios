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
        switch preferenceIndex {
        case 0:
            self.typeDog?.toggle()
        case 1:
            self.typeCat?.toggle()
        case 2:
            self.typeOther?.toggle()
        case 3:
            self.genderFemale?.toggle()
        case 4:
            self.genderMale?.toggle()
        case 5:
            self.sizeSmall?.toggle()
        case 6:
            self.sizeMedium?.toggle()
        case 7:
            self.sizeLarge?.toggle()
        case 8:
           self.activityHigh?.toggle()
        case 9:
            self.activityLow?.toggle()
        default:
            break
        }
    }

    func setMinAge(newValue: Int) {
        self.ageMin = newValue
    }

    func setMaxAge(newValue: Int) {
        self.ageMax = newValue
    }


    func dictionaryRepresentation() -> [String: Int] {

        if let dogValue = self.typeDog {
            userPreferencesDictionary["DOG"] = dogValue ? 1 : 0
        }
        if let catValue = self.typeCat {
            userPreferencesDictionary["CAT"] = catValue ? 1 : 0
        }
        if let otherValue = self.typeOther {
            userPreferencesDictionary["OTHER"] = otherValue ? 1 : 0
        }

        if let femaleValue = self.genderFemale {
            userPreferencesDictionary["FEMALE"] = femaleValue ? 1 : 0
        }

        if let maleValue = self.genderMale {
            userPreferencesDictionary["MALE"] = maleValue ? 1 : 0
        }
        if let smallValue = self.sizeSmall {
            userPreferencesDictionary["SMALL"] = smallValue ? 1 : 0
        }
        if let mediumValue = self.sizeMedium {
            userPreferencesDictionary["MEDIUM"] = mediumValue ? 1 : 0
        }
        if let largeValue = self.sizeLarge {
            userPreferencesDictionary["LARGE"] = largeValue ? 1 : 0
        }
        if let highValue = self.activityHigh {
            userPreferencesDictionary["HIGH"] = highValue ? 1 : 0
        }

        if let lowValue = self.activityLow {
            userPreferencesDictionary["LOW"] = lowValue ? 1 : 0
        }

        userPreferencesDictionary["minAge"] = ageMin

        userPreferencesDictionary["maxAge"] = ageMax

        return  userPreferencesDictionary
    }

    func savePreferencesToUserDefault() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.dictionaryRepresentation(), forKey: USER_PREFERENCES_KEY)

    }
}
