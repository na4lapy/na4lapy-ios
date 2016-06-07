//
//  Constants.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

// MARK: Stałe pobierane z API dla klasy Animal

enum Sterilization: String {
    case Sterilized = "STERILIZED"
}

enum Gender: String {
    case Male = "MALE"
    case Female = "FEMALE"
    case Unknown = "UNKNOWN"
}

enum Size: String {
    case Small = "SMALL"
    case Medium = "MEDIUM"
    case Large = "LARGE"
}

enum Activity: String {
    case Low = "LOW"
    case High = "HIGH"
    case Unknown = "UNKNOWN"
}

enum Training: String {
    case None = "NONE"
    case Basic = "BASIC"
    case Advanced = "ADVANCED"
    case Unknown = "UNKNOWN"
}

enum Vaccination: String {
    case Basic = "BASIC"
    case Extended = "EXTENDED"
    case None = "NONE"
    case Unknown = "UNKNOWN"
}

enum Status: String {
    case ForAdoption = "FOR_ADOPTION"
}

enum Species: String {
    case Dog = "DOG"
    case Cat = "CAT"
    case Other = "OTHER"
}

// MARK: Klucze JSON

struct JsonAttr  {
    static let Id = "id"
    static let Name = "name"
    static let Race = "race"
    static let Description = "description"
    static let BirthDate = "birthDate"
    static let AdmittanceDate = "admittanceDate"
    static let ChipId = "chipId"
    static let Sterilization = "sterilization"
    static let Species = "species"
    static let Gender = "gender"
    static let Size = "size"
    static let Activity = "activity"
    static let Training = "training"
    static let Vaccination = "vaccination"
    static let Photos = "photos"
    static let URL = "url"
    static let Author = "author"
    static let Status = "status"
    static let Total = "total"
}

// MARK: Rozmiary pobieranej strony (liczba elementów)

let PAGESIZE = 10

