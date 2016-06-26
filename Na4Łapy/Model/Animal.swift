//
//  Animal.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit

class Animal: APIObject {
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
    private var images: [Photo]?
    
    //
    // MARK: init()
    //
    required init?(dictionary: [String:AnyObject]) {
        super.init(dictionary: dictionary)
        initializeWithDictionary(dictionary)
    }
    
    /**
     Metoda realizuje pobieranie danych z API zgodnie z parametrami:
     
     - Parameter page: Index strony do pobrania
     - Parameter size: Liczba zwróconych elementów (domyślnie PAGESIZE)
     - Parameter preferences: Zestaw preferencji użytkownika do sortowania
     - Parameter success: Tablica zwróconych obiektów
     - Parameter failure: Informacje o błędzie
     */
    override class func get(page: Int, size: Int = PAGESIZE, preferences: UserPreferences? = nil, success: ([AnyObject], Int) -> Void, failure: (NSError) -> Void) {
        if page <= 0 {
            failure(Error.IllegalPageNumber.err())
            return
        }
        let urlstring = BaseUrl+EndPoint.animals+"?page=\(page)&size=\(size)"
        guard let endpoint = NSURL(string: urlstring) else {
            failure(Error.WrongURL.err())
            return
        }
        Request.getJSONData(endpoint,
            success: { (json, count) in
                let animals = Animal.jsonToObj(json)
                success(animals, count)
            },
            failure: { (error) in
                failure(error)
            }
        )
    }

    /**
     Pobieranie pierwszego (głównego) zdjęcia zwierzaka
    */
    func getFirstImage() -> UIImage? {
        guard let image = self.images?.first?.image else {
            return nil
        }
        return image
    }
    
    /**
     Pobieranie wszystkich zdjęć zwierzaka
    */
    func getAllImages() -> [Photo]? {
        guard let images = self.images where !images.isEmpty else {
            return nil
        }
        log.debug("\(self.name): liczba zdjęć: \(self.images?.count)")
        for image in images {
            image.download()
        }
        return images
    }
    
    /**
     Wypełnienie właściwości obiektu na podstawie struktury JSON
 
     - Parameter dictionary: Struktura JSON
    */
    private func initializeWithDictionary(dictionary: [String: AnyObject]) {
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
                    self.images = []
                    for item in value {
                        if let photo = Photo(dictionary: item) {
                            self.images?.append(photo)
                        }
                    }
                    // Pobranie danych głównego obrazka
                    // TODO: sprawdzić czy na pewno pierwszy obrazek jest zawsze głównym??
                    self.images?.first?.download()
                }
            case JsonAttr.name:
                break
            case JsonAttr.id:
                break
            default:
                log.error(Error.WrongJsonKey.desc()+" \(key)")
            }
        }
    }
    
    func getAge() -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: self.birthDate!, toDate: NSDate(), options: []).year
    }
    
    //TODO: zmienić to na używanie NSLocalizedString i stringdict (jeszcze nie wiem jak)
    func getDescription() -> String {
        let age = getAge()
        var ageDescription = " rok"
        if 2 ... 4 ~= age {
            ageDescription = " lata"
        } else if age > 4 {
            ageDescription = " lat"
        }
        return self.name + ", " + String(age) + ageDescription
    }
}