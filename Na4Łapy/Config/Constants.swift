//
//  Constants.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
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
            case male:
                return "Samiec"
            case female:
                return "Suczka"
            default:
                return "Brak"
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
        default:
            return "Brak"
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

// MARK: Klucze JSON

struct JsonAttr  {
    static let id = "id"
    static let name = "name"
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
}

// MARK: Rozmiary pobieranej strony (liczba elementów)

let PAGESIZE = 10

// MARK: URL

let BaseUrl = "http://na4lapy.kodujdlapolski.pl"
struct EndPoint {
    static let animals = "/api/animals"
    static let shelter = "/api/shelter"
}

// MARK: ErrorDomain dla NSError
let ErrorDomain = "Na4Łapy"

//AnimalCollectionView
let AnimalCollectionViewWidthSubtrahend:CGFloat = 20.0

