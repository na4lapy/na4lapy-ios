//
//  Resource.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 01/04/2017.
//  Copyright © 2017 Koduj dla Polski. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

struct Resource<A> {
    let endPoint: String
    let parse: (Data) -> A?
}

extension Resource {
    init(endPoint: String, parseJSON: @escaping (Any) -> A?) {
        self.endPoint = endPoint
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }

}
