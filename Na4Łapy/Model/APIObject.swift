//
//  APIObject.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 20.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class APIObject: ListingProtocol {
    private(set) var id: Int
    private(set) var name: String

    //
    // MARK: inicjalizacja obiektu za pomocą struktury JSON (id oraz name)
    //
    required init?(dictionary: [String:AnyObject]) {
        guard
            let id = dictionary[JsonAttr.id] as? Int,
            let name = dictionary[JsonAttr.name] as? String
            else {
                log.error(Error.NoIdOrName.desc())
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
    class func jsonToObj(obj: [AnyObject]) -> [AnyObject] {
        var animals = [AnyObject]()
        for item in obj as! [[String: AnyObject]] {
            if let animal = self.init(dictionary: item) as? AnyObject {
                animals.append(animal)
            }
        }
        return animals
    }
    
    /**
     Metoda nadpisywana w obiektach potomnych, wymagana przez protokół ListingProtocol
     */
    class func get(page: Int, size: Int, preferences: UserPreferences?, success: ([AnyObject], Int) -> Void, failure: (NSError) -> Void) {}
}
