//
//  APIObject.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 20.06.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import Foundation

class APIObject: ListingProtocol {
    fileprivate(set) var id: Int
    fileprivate(set) var name: String

    //
    // MARK: inicjalizacja obiektu za pomocą struktury JSON (id oraz name)
    //
    required init?(dictionary: [String:AnyObject]) {
        guard
            let id = dictionary[JsonAttr.id] as? Int,
                let name = dictionary[JsonAttr.name] as? String
            else {
                log.error(Err.noIdOrName.desc())
                return nil
        }
        self.id = id
        self.name = name
    }

    /**
     Tworzenie obiektów na podstawie JSON

     - Parameter json: Struktura JSON
     - Returns: Tablica obiektów Animal
     */
    class func jsonToObj(_ obj: [AnyObject]) -> [AnyObject] {
        var animals = [AnyObject]()
        if let obj = obj as? [[String: AnyObject]] {
            for item in obj {
                if let animal = self.init(dictionary: item) {
                    animals.append(animal)
                }
            }
        }
        return animals

    }

    /**
     Metoda nadpisywana w obiektach potomnych, wymagana przez protokół ListingProtocol
     */
    class func get(_ page: Int, size: Int, preferences: UserPreferences?, success: @escaping ([AnyObject], Int) -> Void, failure: @escaping (NSError) -> Void) {}
}
