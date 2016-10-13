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
        let defaults = UserDefaults.standard
        guard let favourites = defaults.stringArray(forKey: "Favourites") else {
            log.error("Brak NSUserDefaults dla klucza: 'Favourites'")
            return nil
        }
        
        // Konwersja tablicy String na Int
        let favouritesResult: [Int] = favourites.map { (arg: String) -> Int in
            return Int(arg) ?? 0
        }
        return favouritesResult
    }
    
    class func add(_ id: Int) {
        let animalId = String(id)

        // Pobierz aktualny stan
        let defaults = UserDefaults.standard
        var favouritesTable: [String]! = defaults.stringArray(forKey: "Favourites") ?? []

        if !favouritesTable.contains(animalId) {
            favouritesTable.append(animalId)
        }
        
        // Zapisz nową tablicę
        defaults.set(favouritesTable, forKey: "Favourites")
    }
    
    class func delete(_ id: Int) {
        let animalId = String(id)
        let defaults = UserDefaults.standard
        let favouritesTable: [String]! = defaults.stringArray(forKey: "Favourites") ?? []
        let newFavourites = favouritesTable.filter {
            $0 != animalId
        }
        defaults.set(newFavourites, forKey: "Favourites")
    }
    
    class func isFavourite(_ id: Int) -> Bool {
        let animalId = String(id)
        let defaults = UserDefaults.standard
        let favouritesTable: [String]! = defaults.stringArray(forKey: "Favourites") ?? []
        return favouritesTable.contains(animalId)
    }
}
