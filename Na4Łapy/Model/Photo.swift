//
//  Photo.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    let id: Int
    let url: NSURL
    var author: String?
    var image: UIImage?
    
    init?(dictionary: [String:AnyObject]) {
        guard
            let id = dictionary[JsonAttr.Id] as? Int,
            let urlstring = dictionary[JsonAttr.URL] as? String,
            let url = NSURL(string: urlstring)
        else {
            log.error(ErrorString.NO_ID_OR_NAME)
            return nil
        }
        
        self.id = id
        self.url = url
        
        if let author = dictionary[JsonAttr.Author] as? String {
            self.author = author
        }
    }
    
    /**
    Asynchroniczne pobieranie obrazka
    */
    func download() {
    
    }
}