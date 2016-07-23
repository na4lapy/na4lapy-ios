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
