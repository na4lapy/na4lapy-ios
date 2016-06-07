//
//  Request.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 07.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Request {
    typealias APISuccessClosure = ([Animal]) -> Void
    typealias APIFailureClosure = (NSError) -> Void

    /**
     Metoda realizuje pobieranie danych z API zgodnie z parametrami:
     
     - Parameter page: Index strony do pobrania
     - Parameter size: Liczba zwróconych elementów (domyślnie PAGESIZE)
     - Parameter success: Tablica zwróconych obiektów
     - Parameter failure: Informacje o błędzie
    */
    class func get(page page: Int, size: Int = PAGESIZE, success: APISuccessClosure, failure: APIFailureClosure) {
        // TODO: pobierz dane z API
        // TODO: zbuduj obiekty Animal i Photo
    }
}