//
//  UserPreferences.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 07.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class UserPreferences {
    fileprivate var typeDog: Bool?
    fileprivate var typeCat: Bool?
    fileprivate var typeOther: Bool?
    fileprivate var genderFemale: Bool?
    fileprivate var genderMale: Bool?
    fileprivate var ageMin: Int = 0
    fileprivate var ageMax: Int = 20
    fileprivate var sizeSmall: Bool?
    fileprivate var sizeMedium: Bool?
    fileprivate var sizeLarge: Bool?
    fileprivate var activityLow: Bool?
    fileprivate var activityHigh: Bool?

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

    func dictionaryRepresentation() {

    }
}
