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
    
    func getFirstPhoto() -> UIImage? {
        guard let image = self.photos?.first?.image else {
            return nil
        }
        return image
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