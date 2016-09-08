//
//  Favourite.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.07.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Favourite {
    
    class func get() -> [Int]? {
        // Pobierz aktualny stan
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let favourites = defaults.stringArrayForKey("Favourites") else {
            log.error("Brak NSUserDefaults dla klucza: 'Favourites'")
            return nil
        }
        
        // Konwersja tablicy String na Int
        let favouritesResult: [Int] = favourites.map { (arg: String) -> Int in
            return Int(arg) ?? 0
        }
        return favouritesResult
    }
    
    class func add(id: Int) {
        let animalId = String(id)

        // Pobierz aktualny stan
        let defaults = NSUserDefaults.standardUserDefaults()
        var favouritesTable: [String]! = defaults.stringArrayForKey("Favourites") ?? []

        if !favouritesTable.contains(animalId) {
            favouritesTable.append(animalId)
        }
        
        // Zapisz nową tablicę
        defaults.setObject(favouritesTable, forKey: "Favourites")
    }
    
    class func delete(id: Int) {
        let animalId = String(id)
        let defaults = NSUserDefaults.standardUserDefaults()
        let favouritesTable: [String]! = defaults.stringArrayForKey("Favourites") ?? []
        let newFavourites = favouritesTable.filter {
            $0 != animalId
        }
        defaults.setObject(newFavourites, forKey: "Favourites")
    }
    
    class func isFavourite(id: Int) -> Bool {
        let animalId = String(id)
        let defaults = NSUserDefaults.standardUserDefaults()
        let favouritesTable: [String]! = defaults.stringArrayForKey("Favourites") ?? []
        return favouritesTable.contains(animalId)
    }
}
