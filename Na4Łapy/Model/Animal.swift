//
//  Animal.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Animal {
    private var id: Int
    private var name: String
    private var race: String?
    private var description: String?
    private var birthDate: NSDate?
    private var admittanceDate: NSDate?
    private var chipId: String?
    private var sterilization: Sterilization?
    private var species: Species?
    private var gender: Gender?
    private var size: Size?
    private var activity: Activity?
    private var training: Training?
    private var vaccination: Vaccination?
    private var status: Status?
    private var photos: [Photo]?
    
    init?(dictionary: [String:AnyObject]) {
        guard
            let id = dictionary[JsonAttr.Id] as? Int,
            let name = dictionary[JsonAttr.Name] as? String
        else {
            log.error("Brak 'id' lub 'name' w parametrach konstruktora klasy")
            return nil
        }
        
        self.id = id
        self.name = name
        
        for (key, value) in dictionary {
            switch key {
            case JsonAttr.Race:
                if let race = value as? String {
                    self.race = race
                }
            case JsonAttr.Description:
                if let description = value as? String {
                    self.description = description
                }
            case JsonAttr.BirthDate:
                if let birthDate = value as? String {
                    // TODO: konwersja do NSDate
                }
            case JsonAttr.AdmittanceDate:
                if let admittanceDate = value as? String {
                    // TODO: konwersja do NSDate
                }
            case JsonAttr.ChipId:
                if let chipId = value as? String {
                    self.chipId = chipId
                }
            case JsonAttr.Sterilization:
                if let value = value as? String, let sterilization = Sterilization(rawValue: value) {
                    self.sterilization = sterilization
                }
            case JsonAttr.Species:
                if let value = value as? String, let species = Species(rawValue: value) {
                    self.species = species
                }
            case JsonAttr.Gender:
                if let value = value as? String, let gender = Gender(rawValue: value) {
                    self.gender = gender
                }
            case JsonAttr.Size:
                if let value = value as? String, let size = Size(rawValue: value) {
                    self.size = size
                }
            case JsonAttr.Activity:
                if let value = value as? String, let activity = Activity(rawValue: value) {
                    self.activity = activity
                }
            case JsonAttr.Training:
                if let value = value as? String, let training = Training(rawValue: value) {
                    self.training = training
                }
            case JsonAttr.Vaccination:
                if let value = value as? String, let vaccination = Vaccination(rawValue: value) {
                    self.vaccination = vaccination
                }
            case JsonAttr.Status:
                if let value = value as? String, let status = Status(rawValue: value) {
                    self.status = status
                }
            case JsonAttr.Photos:
                if let value = value as? [[String:AnyObject]] {
                    self.photos = []
                    for item in value {
                        if let photo = Photo(dictionary: item) {
                            self.photos?.append(photo)
                        }
                    }
                    // Pobranie danych głównego obrazka
                    // TODO: sprawdzić czy na pewno pierwszy obrazek jest zawsze głównym??
                    self.photos?.first?.download()
                }
            default:
                log.error("Błędny klucz JSON: \(key)")

            }
        }
    }
}