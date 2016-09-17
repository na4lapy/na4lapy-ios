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
    private(set) var shelterId: Int?
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
        // FIXME: usunąć, jeśli shelterId będzie dostarczane przez API
        self.shelterId = 1
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
        if page < 0 {
            failure(Error.IllegalPageNumber.err())
            return
        }

       let urlstring = AnimalURLBuilder.buildURLFrom(baseUrl+EndPoint.animals, page: page, pageSize: size, params: preferences)

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

    class func getById(id: Int, success: ([Animal]) -> Void, failure: (NSError) -> Void) {
        let urlstring = baseUrl+EndPoint.animals+"/\(id)"
        guard let endpoint = NSURL(string: urlstring) else {
            failure(Error.WrongURL.err())
            return
        }
        Request.getJSONData(endpoint,
                            success: { (json, count) in
                                if let animals = Animal.jsonToObj(json) as? [Animal] {
                                    success(animals)
                                }
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
            image.download() {
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadDetailView", object: nil)
            }
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
            case JsonAttr.shelterId:
                if let shelterId = value as? Int {
                    self.shelterId = shelterId
                }
            case JsonAttr.race:
                if let race = value as? String {
                    self.race = race
                }
            case JsonAttr.description:
                //TODO: Czy możemy zmienić klucz description na jakiś inny? MOże się mylić z debugDescription i description dla obiektów w Swifcie np. na narration albo information
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
                if let value = value as? String, sterilization = Sterilization(rawValue: value) {
                    self.sterilization = sterilization
                }
            case JsonAttr.species:
                if let value = value as? String, species = Species(rawValue: value) {
                    self.species = species
                }
            case JsonAttr.gender:
                if let value = value as? String, gender = Gender(rawValue: value) {
                    self.gender = gender
                }
            case JsonAttr.size:
                if let value = value as? String, size = Size(rawValue: value) {
                    self.size = size
                }
            case JsonAttr.activity:
                if let value = value as? String, activity = Activity(rawValue: value) {
                    self.activity = activity
                }
            case JsonAttr.training:
                if let value = value as? String, training = Training(rawValue: value) {
                    self.training = training
                }
            case JsonAttr.vaccination:
                if let value = value as? String, vaccination = Vaccination(rawValue: value) {
                    self.vaccination = vaccination
                }
            case JsonAttr.status:
                if let value = value as? String, status = Status(rawValue: value) {
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
                    self.images?.first?.download() {
                        NSNotificationCenter.defaultCenter().postNotificationName("ReloadAnimalView", object: nil)
                    }
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
        guard let birthDate = self.birthDate else {
            // w przypadku braku daty urodzenia przyjmowana jest domyślna wartość wieku == 0
            return 0
        }
        return NSCalendar.currentCalendar().components(.Year, fromDate: birthDate, toDate: NSDate(), options: []).year
    }

    //TODO: zmienić to na używanie NSLocalizedString i stringdict (jeszcze nie wiem jak)
    func getAgeName() -> String {
        let age = getAge()
        var ageDescription = " rok"
        if 2 ... 4 ~= age {
            ageDescription = " lata"
        } else if age > 4 || age == 0 {
            ageDescription = " lat"
        }
        return self.name + ", " + String(age) + ageDescription
    }

    func getSize() -> String {

        if let size = self.size {
            return NSLocalizedString(size.rawValue, comment: "size")
        }

        return ""
    }

    func getGender() -> String {
        if let gender = self.gender {
            return NSLocalizedString(gender.rawValue, comment: "gender")
        }
        return ""
    }

    func getActivityLevel() -> String {
        if let activityLevel = self.activity {
            return NSLocalizedString(activityLevel.rawValue, comment: "activityLevel")
        }
        return ""
    }

    func getTraining() -> String {
        if let training = self.training {
            return NSLocalizedString(training.rawValue, comment: "training")
        }
        return ""

    }

    func getSterlization() -> String {
        if let _ = self.sterilization {
            return NSLocalizedString("YES", comment: "positive")
        }
        return NSLocalizedString("NONE", comment: "none")
    }

    func getVaccination() -> String {
        if let vaccination = self.vaccination {
            return NSLocalizedString(vaccination.rawValue, comment: "vaccination")
        }
        return ""
    }

    func getAdmitannceMonthsFromNow() -> Int {

        if let admittanceDate = self.admittanceDate {
            return NSCalendar.currentCalendar().components(.Month, fromDate: admittanceDate, toDate: NSDate(), options: []).month
        }
        // w przypadku braku daty przyjęcia zwracamy zero
        return 0
    }

    func getAdmintannceYearsFromNow() -> Int {
        if let admittanceDate = self.admittanceDate {
            return NSCalendar.currentCalendar().components(.Year, fromDate: admittanceDate, toDate: NSDate(), options: []).year
        }
        // w przypadku braku daty przyjęcia zwracamy zero
        return 0
    }

    func getFeatures() -> [String:String] {
        var features = [String:String]()
        features["Rasa"] = self.race ?? ""

        features["Wielkość"] = getSize()

        features["Płeć"] = getGender()
        features["Aktywność"] = getActivityLevel()
        features["Ułożenie"] = getTraining()

        features["Sterylizacja"] = getSterlization()
        features["Chip"] = self.chipId ?? ""

        let monthsSinceAdmintannce = getAdmitannceMonthsFromNow()
        if monthsSinceAdmintannce != 0 {
            log.debug(floor(Double(monthsSinceAdmintannce)/12).description)
            if monthsSinceAdmintannce >= 12 {
                features["W schronisku od"] = NSString.localizedStringWithFormat(NSLocalizedString("%d num_of_years", comment: ""), getAdmintannceYearsFromNow()) as String
            } else {
                features["W schronisku od"] =  NSString.localizedStringWithFormat(NSLocalizedString("%d num_of_months", comment: ""), monthsSinceAdmintannce) as String
            }
        } else {
            features["W schronisku od"] = ""
        }
        features["Szczepienie"] = getVaccination()

        return features
    }

    func getFeatureKeys() -> [String] {
        return ["Rasa", "Wielkość", "Płeć", "Aktywność", "Ułożenie", "Sterylizacja", "Szczepienie", "Chip", "W schronisku od"]
    }


    class func buildURLFrom(baseUrl: String, page: Int, pageSize: Int, params: UserPreferences?) -> String {
        var url = baseUrl + "?page=\(page)&size=\(pageSize)"

        guard let preferencesParams = params?.dictionaryRepresentation() else {
            //NO PARAMS PROVIDED
            return url
        }

        var spieciesParams = [String]()
        var genderParams = [String]()
        var sizeParams = [String]()
        var activitiesParams = [String]()
        for (paramKey, paramValue) in preferencesParams {

            switch paramKey {
            case Species.dog.rawValue, Species.cat.rawValue, Species.other.rawValue:
                if paramValue != 0 {
                    spieciesParams.append(paramKey)
                }
            case Gender.female.rawValue, Gender.male.rawValue:
                if paramValue != 0 {
                    genderParams.append(paramKey)
                }
            case Size.small.rawValue, Size.medium.rawValue, Size.large.rawValue:
                if paramValue != 0 {
                    sizeParams.append(paramKey)
                }
            case Activity.low.rawValue, Activity.high.rawValue:
                if paramValue != 0 {
                    activitiesParams.append(paramKey)
                }
            case ageBoundaries.ageMax.rawValue, ageBoundaries.ageMin.rawValue:
                url += "&\(paramKey)=\(paramValue)"

            default:
                break
            }
        }

        if (!spieciesParams.isEmpty) {
            let joinedParams = spieciesParams.joinWithSeparator(",")
            url += "&species=\(joinedParams)"
        }

        if (!genderParams.isEmpty) {
            let joinedParams = genderParams.joinWithSeparator(",")
            url += "&genders=\(joinedParams)"
        }

        if (!sizeParams.isEmpty) {
            let joinedParams = sizeParams.joinWithSeparator(",")
            url += "&sizes=\(joinedParams)"
        }

        if (!activitiesParams.isEmpty) {
            let joinedParams = sizeParams.joinWithSeparator(",")
            url += "&activities=\(joinedParams)"
        }

        return url
    }





}
