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
            let id = dictionary[JsonAttr.id] as? Int,
            let urlstring = dictionary[JsonAttr.url] as? String,
            let url = NSURL(string: urlstring)
        else {
            log.error(ErrorString.NO_ID_OR_NAME)
            return nil
        }
        
        self.id = id
        self.url = url
        
        if let author = dictionary[JsonAttr.author] as? String {
            self.author = author
        }
    }
    
    /**
    Asynchroniczne pobieranie obrazka
    */
    func download() {
        log.debug("Start downloading... \(self.url.absoluteString)")
        Request.getImageData(self.url,
            success: { (image) in
                self.image = image
            },
            failure: { (error) in
                log.error("Błąd podczas pobierania obrazka dla urla: \(self.url.absoluteString), error: \(error.description)")
            }
        )
    }
}