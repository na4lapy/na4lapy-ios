//
//  Animal.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit

class Animal {
    private(set) var id: Int
    private(set) var name: String
    private(set) var race: String?
    private(set) var description: String?
    private(set) var birthDate: NSDate?
    private(set) var admittanceDate: NSDate?
    private(set) var chipId: String?
    private(set) var sterilization: Sterilization?
    private(set) var species: Species?
    private(set) var gender: Gender?
    private(set) var size: Size?
    private(set) var activity: Activity?
    private(set) var training: Training?
    private(set) var vaccination: Vaccination?
    private(set) var status: Status?
    private var photos: [Photo]?
    
    /**
     Pobieranie pierwszego (głównego) zdjęcia zwierzaka
    */
    func getFirstPhoto() -> UIImage? {
        guard let image = self.photos?.first?.image else {
            return nil
        }
        return image
    }
    
    /**
     Pobieranie wszystkich zdjęć zwierzaka
    */
    func getAllPhotos() -> [Photo]? {
        guard let photos = self.photos where !photos.isEmpty else {
            return nil
        }
        log.debug("\(self.name): liczba zdjęć: \(self.photos?.count)")
        for photo in photos {
            photo.download()
        }
        return photos
    }
    
    init?(dictionary: [String:AnyObject]) {
        guard
            let id = dictionary[JsonAttr.id] as? Int,
            let name = dictionary[JsonAttr.name] as? String
        else {
            log.error(ErrorString.NO_ID_OR_NAME)
            return nil
        }
        
        self.id = id
        self.name = name
        
        for (key, value) in dictionary {
            switch key {
            case JsonAttr.race:
                if let race = value as? String {
                    self.race = race
                }
            case JsonAttr.description:
                if let description = value as? String {
                    self.description = description
                }
            case JsonAttr.birthDate:
                if let birthDate = value as? String {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone = NSTimeZone(name: JsonAttr.birthDateTimeZone)
                    dateFormatter.dateFormat = JsonAttr.birthDateFormat
                    self.birthDate = dateFormatter.dateFromString(birthDate)
                }
            case JsonAttr.admittanceDate:
                if let admittanceDate = value as? String {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone = NSTimeZone(name: JsonAttr.admittanceDateTimeZone)
                    dateFormatter.dateFormat = JsonAttr.admittanceDateFormat
                    self.admittanceDate = dateFormatter.dateFromString(admittanceDate)
                }
            case JsonAttr.chipId:
                if let chipId = value as? String {
                    self.chipId = chipId
                }
            case JsonAttr.sterilization:
                if let value = value as? String, let sterilization = Sterilization(rawValue: value) {
                    self.sterilization = sterilization
                }
            case JsonAttr.species:
                if let value = value as? String, let species = Species(rawValue: value) {
                    self.species = species
                }
            case JsonAttr.gender:
                if let value = value as? String, let gender = Gender(rawValue: value) {
                    self.gender = gender
                }
            case JsonAttr.size:
                if let value = value as? String, let size = Size(rawValue: value) {
                    self.size = size
                }
            case JsonAttr.activity:
                if let value = value as? String, let activity = Activity(rawValue: value) {
                    self.activity = activity
                }
            case JsonAttr.training:
                if let value = value as? String, let training = Training(rawValue: value) {
                    self.training = training
                }
            case JsonAttr.vaccination:
                if let value = value as? String, let vaccination = Vaccination(rawValue: value) {
                    self.vaccination = vaccination
                }
            case JsonAttr.status:
                if let value = value as? String, let status = Status(rawValue: value) {
                    self.status = status
                }
            case JsonAttr.photos:
                if let value = value as? [[String: AnyObject]] {
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
            case JsonAttr.name:
                break
            case JsonAttr.id:
                break
            default:
                log.error(ErrorString.WRONG_JSON_KEY+" \(key)")

            }
        }
    }
}