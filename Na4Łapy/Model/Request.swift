//
//  Request.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 07.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

class Request {
    enum JsonError: ErrorType {
        case ParseError
        case NoData
    }

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
            guard let json = json[JsonAttr.Data] as? [[String:AnyObject]] else {
                failure(NSError(domain: ErrorString.WRONG_JSON_STRUCT, code: 1, userInfo: nil))
                return
            }
            success(Request.animalConstructor(json))
        }, failure: { (error) in
            failure(error)
        })
    }
    
    //
    // MARK: private
    //
    
    /**
     Tworzenie obiektów Animal na podstawie JSON
 
     - Parameter json: Struktura JSON
     - Returns: Tablica obiektów Animal
    */
    private class func animalConstructor(json: [[String:AnyObject]]) -> [Animal] {
        var animals = [Animal]()
        for item in json {
            if let animal = Animal(dictionary: item) {
                animals.append(animal)
            }
        }
        return animals
    }
    
    /**
     Implementacja zapytania HTTP GET

     - Parameter url: Endpoint
     - Parameter success: Closure w przypadku sukcesu
     - Parameter failure: Closure w przypadku błędu
    */
    private class func httpGET(url: String, success: ([String:AnyObject]) -> Void, failure: (NSError) -> Void) {
        guard let endpoint = NSURL(string: url) else {
            failure(NSError(domain: ErrorString.WRONG_URL, code: 1, userInfo: nil))
            return
        }
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: endpoint)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JsonError.NoData
                }
                let json = try Request.parseJSON(data)
                success(json)
            }
            catch let error as NSError {
                failure(error)
            }
            catch JsonError.NoData {
                failure(NSError(domain: ErrorString.JSON_NO_DATA, code: 1, userInfo: nil))
            }
            catch JsonError.ParseError {
                failure(NSError(domain: ErrorString.JSON_PARSE_ERROR, code: 1, userInfo: nil))
            }
        }
        task.resume()
    }
    
    /**
     Parsowanie JSON
 
     - Parameter data: Obiekt NSData
     - Returns: Dictionary<String:AnyObject>
    */
    private class func parseJSON(data: NSData) throws -> [String:AnyObject] {
        guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject] else {
            throw JsonError.ParseError
        }
        return json
    }
    
    /**
     Metoda realizuje pobieranie danych z API zgodnie z parametrami:
     */
    class func getShelter() {
        // TODO:
    }
    

}