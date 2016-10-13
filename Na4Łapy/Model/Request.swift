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
    class func getImageData(_ url: URL, success: @escaping (UIImage) -> Void, failure: @escaping (NSError) -> Void) {
        Request.httpGET(url,
            success: { (data) in
                guard let image = UIImage(data: data) else {
                    failure(Err.noImageData.err())
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
    class func getJSONData(_ endpoint: URL, success: @escaping ([AnyObject], Int) -> Void, failure: @escaping (NSError) -> Void) {
        Request.httpGET(endpoint,
            success: { (data) in
                do {
                    let json = try Request.parseJSON(data)
                    guard
                        let jsondata = json[JsonAttr.data] as? [[String: AnyObject]],
                            let count = json[JsonAttr.total] as? Int
                    else {
                        throw JsonError.parseError
                    }
                    success(jsondata as [AnyObject], count)
                } catch let error as NSError {
                    failure(error)
                } catch JsonError.parseError {
                    failure(Err.wrongJsonStruct.err())
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
    fileprivate class func httpGET(_ url: URL, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error != nil {
                failure(error! as NSError)
                return
            }
            guard let data = data else {
                failure(Err.noData.err())
                return
            }
            success(data)
        }) 
        task.resume()
    }

    /**
     Parsowanie JSON

     - Parameter data: Obiekt NSData
     - Returns: Dictionary<String:AnyObject>
    */
    fileprivate class func parseJSON(_ data: Data) throws -> [String:AnyObject] {
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {
            throw JsonError.parseError
        }
        return json
    }
}
