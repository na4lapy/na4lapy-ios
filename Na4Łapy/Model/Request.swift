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
                    failure(Error.NoImageData.err())
                    return
                }
                success(image)
            },
            failure: { (error) in
                failure(error)
            }
        )
    }

    /**
     Pobranie struktury JSON ze wskazanego endpointu

     - Parameter endpoint: adres endpointu
     - Parameter success: Przekazanie pobranej struktury
     - Parameter failure: Przekazanie błędu
    */
    class func getJSONData(endpoint: NSURL, parseData: Bool = true, success: ([AnyObject], Int) -> Void, failure: (NSError) -> Void) {
        Request.httpGET(endpoint,
            success: { (data) in
                do {
                    let json = try Request.parseJSON(data)
                    if parseData {
                        guard
                            let jsondata = json[JsonAttr.data] as? [[String: AnyObject]],
                                count = json[JsonAttr.total] as? Int
                        else {
                            throw JsonError.parseError
                        }
                            success(jsondata, count)
                    } else {
                        success([json], 0)
                    }
                } catch let error as NSError {
                    failure(error)
                } catch JsonError.parseError {
                    failure(Error.WrongJsonStruct.err())
                }
            },
            failure: { (error) in
                failure(error)
            }
        )
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
            if error != nil {
                failure(error!)
                return
            }
            guard let data = data else {
                failure(Error.NoData.err())
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
}
