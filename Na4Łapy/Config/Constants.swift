//
//  Constants.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import Foundation
import UIKit

// MARK: Stałe pobierane z API dla klasy Animal

enum Sterilization: String {
    case Sterilized = "STERILIZED"
}

enum Gender: String {
    case male = "MALE"
    case female = "FEMALE"
    case unknown = "UNKNOWN"

    func pl() -> String {
        switch self {
            case .male:
                return "Samiec"
            case .female:
                return "Samica"
            case .unknown:
                return "GenderUnknown"
        }
    }
}

enum Size: String {
    case small = "SMALL"
    case medium = "MEDIUM"
    case large = "LARGE"

    func pl() -> String {
        switch self {
        case .small:
            return "Maly"
        case .medium:
            return "Sredni"
        case .large:
            return "Duzy"
        }
    }
}

enum Activity: String {
    case low = "LOW"
    case high = "HIGH"
    case unknown = "UNKNOWN"

    func pl() -> String {
        switch self {
        case .low:
            return "Domator"
        case .high:
            return "Aktywny"
        case .unknown:
            return "ActivityLevelUnknown"
        }
    }
}

enum Training: String {
    case none = "NONE"
    case basic = "BASIC"
    case advanced = "ADVANCED"
    case unknown = "UNKNOWN"
}

enum Vaccination: String {
    case basic = "BASIC"
    case extended = "EXTENDED"
    case none = "NONE"
    case unknown = "UNKNOWN"
}

enum Status: String {
    case forAdoption = "FOR_ADOPTION"
}

enum Species: String {
    case dog = "DOG"
    case cat = "CAT"
    case other = "OTHER"
}

enum FavAnimalType: Int {

    case All = 0
    case Dogs = 1
    case Cats = 2
    case Others = 3

    func toString() -> String {
        switch self {
        case .All:
            return "ALL"
        case .Dogs:
            return "DOG"
        case .Cats:
            return "CAT"
        case .Others:
            return "OTHER"

        }
    }
}


enum ageBoundaries: String {
    case ageMin = "minAge"
    case ageMax = "maxAge"
}

// MARK: Klucze JSON



struct JsonAttr {
    static let id = "id"
    static let name = "name"
    static let shelterId = "shelterId"
    static let race = "race"
    static let description = "description"
    static let birthDate = "birthDate"
    static let birthDateFormat = "yyyy-MM-dd"
    static let birthDateTimeZone = "GMT"
    static let admittanceDate = "admittanceDate"
    static let admittanceDateFormat = "yyyy-MM-dd"
    static let admittanceDateTimeZone = "GMT"
    static let chipId = "chipId"
    static let sterilization = "sterilization"
    static let species = "species"
    static let gender = "gender"
    static let size = "size"
    static let activity = "activity"
    static let training = "training"
    static let vaccination = "vaccination"
    static let photos = "photos"
    static let url = "url"
    static let author = "author"
    static let status = "status"
    static let total = "total"
    static let data = "data"
    static let fileName = "fileName"
    static let animalStatus = "animalStatus"
}

struct ShelterJsonAttr {
    static let accountNumber = "accountNumber"
    static let adoptionRules = "adoptionRules"
    static let buildingNumber = "buildingNumber"
    static let city = "city"
    static let email = "email"
    static let facebookProfile = "facebookProfile"
    static let id = "id"
    static let name = "name"
    static let phoneNumber = "phoneNumber"
    static let postalCode = "postalCode"
    static let street = "street"
    static let voivodeship = "voivodeship"
    static let website = "website"
}

// MARK: Rozmiary pobieranej strony (liczba elementów)

let PAGESIZE = 10

// MARK: URL

let baseUrl = "https://api.na4lapy.org/"
struct EndPoint {
    static let animals = "v1/animals"
    static let shelter = "shelter"
    static let files = "files/"

}

let USER_PREFERENCES_KEY = "UserPreferences"

let PREFERENCES = [
    Species.dog.rawValue,
    Species.cat.rawValue,
    Species.other.rawValue,
    Gender.female.rawValue,
    Gender.male.rawValue,
    Size.small.rawValue,
    Size.medium.rawValue,
    Size.large.rawValue,
    Activity.low.rawValue,
    Activity.high.rawValue
]

// MARK: ErrorDomain dla NSError
let errorDomain = "Na4Łapy"
