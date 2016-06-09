//
//  Request.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 07.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit

class Request {
    enum JsonError: ErrorType {
        case parseError
        case noData
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
        let urlstring = BaseUrl+EndPoint.animals+"?page=\(page)&size=\(size)"
        guard let endpoint = NSURL(string: urlstring) else {
            failure(NSError(domain: ErrorString.WRONG_URL, code: 1, userInfo: nil))
            return
        }
        Request.httpGET(endpoint,
            success: { (data) in
                do {
                    let json = try self.parseJSON(data)
                    guard let jsondata = json[JsonAttr.data] as? [[String: AnyObject]] else {
                        throw JsonError.parseError
                    }
                    success(Request.animalConstructor(jsondata))
                }
                catch let error as NSError {
                    failure(error)
                }
                catch JsonError.parseError {
                    failure(NSError(domain: ErrorString.WRONG_JSON_STRUCT, code: 1, userInfo: nil))
                }
            },
            failure: { (error) in
                failure(error)
            }
        )
    }
    
    /**
     Pobranie danych obrazka ze wskazanego urla
 
     - Parameter url: URL
     - Parameter success: Przekazanie UIImage
     - Parameter failure: Przekazanie błędu
    */
    class func getImageData(url: NSURL, success: (UIImage) -> Void, failure: (NSError) -> Void) {
        Request.httpGET(url,
            success: { (data) in
                guard let image = UIImage(data: data) else {
                    failure(NSError(domain: ErrorString.NO_IMAGE_DATA, code: 1, userInfo: nil))
                    return
                }
                success(image)
            },
            failure: { (error) in
                failure(error)
            }
        )
    }
    
    
    //
    // MARK: private
    //
    
    /**
     Tworzenie obiektów Animal na podstawie JSON
 
     - Parameter json: Struktura JSON
     - Returns: Tablica obiektów Animal
    */
    private class func animalConstructor(json: [[String: AnyObject]]) -> [Animal] {
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
    private class func httpGET(url: NSURL, success: (NSData) -> Void, failure: (NSError) -> Void) {
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
                guard let data = data else {
                    failure(NSError(domain: ErrorString.NO_DATA, code: 1, userInfo: nil))
                    return
                }
                success(data)
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
            throw JsonError.parseError
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

