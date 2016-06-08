//
//  Request.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 07.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Request {
    /**
     Metoda realizuje pobieranie danych z API zgodnie z parametrami:
     
     - Parameter page: Index strony do pobrania
     - Parameter size: Liczba zwróconych elementów (domyślnie PAGESIZE)
     - Parameter preferences: Zestaw preferencji użytkownika do sortowania
     - Parameter success: Tablica zwróconych obiektów
     - Parameter failure: Informacje o błędzie
    */
    class func getAnimal(page page: Int, size: Int = PAGESIZE, preferences: UserPreferences? = nil, success: APISuccessClosure, failure: APIFailureClosure) {
        Request.httpGET(BaseUrl+EndPoint.animals+"?page=\(page)&size=\(size)", success: { (json) in
            guard let json = json[JsonAttr.Data] as? NSArray else {
                let error = NSError(domain: ErrorString.WRONG_JSON_STRUCT, code: 0, userInfo: nil)
                failure(error)
                return
            }
            var animals = [Animal]()
            for item in json {
                guard let item = item as? [String:AnyObject] else {
                    let error = NSError(domain: ErrorString.WRONG_JSON_STRUCT, code: 0, userInfo: nil)
                    failure(error)
                    return
                }
                if let animal = Animal(dictionary: item) {
                    animals.append(animal)
                }
            }
            success(animals)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    /**
     Metoda realizuje pobieranie danych z API zgodnie z parametrami:
    */
    class func getShelter() {
        // TODO:
    }
    
    /**
     Implementacja zapytania HTTP GET

     - Parameter url: Endpoint
     - Parameter success: Closure w przypadku sukcesu
     - Parameter failure: Closure w przypadku błędu
    */
    private class func httpGET(url: String, success: (NSDictionary) -> Void, failure: (NSError) -> Void) {
        guard let endpoint = NSURL(string: url) else {
            let error = NSError(domain: ErrorString.WRONG_URL, code: 0, userInfo: nil)
            failure(error)
            return
        }
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: endpoint)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if let error = error {
                failure(error)
                return
            }
            guard
                let data = data,
                let json = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
            else {
                let error = NSError(domain: ErrorString.JSON_PARSE_ERROR_OR_NO_DATA, code: 0, userInfo: nil)
                failure(error)
                return
            }
            success(json)
        }
        task.resume()
    }
}