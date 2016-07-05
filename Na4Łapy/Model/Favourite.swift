//
//  Favourite.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.07.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Favourite {
    
    class func get() -> [Animal]? {
        // Pobierz aktualny stan
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let favourites = defaults.arrayForKey("Favourites") as? [[String: Int]] else {
            log.error("Brak NSUserDefaults dla klucza: 'Favourites'")
            return nil
        }
        
        // DEBUG
        for favourite in favourites {
            let animalId = favourite["animalId"]
            let shelterId = favourite["shelterId"]
            log.debug("--- id: \(animalId), shelter: \(shelterId) ")
        }
        
        // TODO: pobierz wszystkie wymagane obiekty Animal
        
        return nil
    }
    
    class func add(animal: Animal) {
        let animalId = animal.id
        guard let shelterId = animal.shelterId else {
            log.error("Brak shelterId")
            return
        }
        
        // Pobierz aktualny stan 
        let defaults = NSUserDefaults.standardUserDefaults()
        var favouritesTable: [AnyObject]! = defaults.arrayForKey("Favourites") ?? []
        let data = ["animalId": animalId, "shelterId": shelterId] as AnyObject

        // TODO: sprawdzić, czy obiekt już występuje
        favouritesTable.append(data)
        
        // Zapisz nową tablicę
        defaults.setObject(favouritesTable, forKey: "Favourites")
    }
    
    class func delete(animal: Animal) {
        
    }
    
    class func isFavourite(animal: Animal) -> Bool {
        return true
    }
    
}
