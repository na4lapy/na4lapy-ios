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
                urlstring = dictionary[JsonAttr.url] as? String,
                url = NSURL(string: urlstring)
        else {
            log.error(Error.NoIdOrName.desc())
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
        if self.image != nil {
            log.debug("Zdjęcie zostało już wcześniej pobrane.")
            return
        }
        log.debug("Pobieram zdjęcie... \(self.url.absoluteString)")
        Request.getImageData(self.url,
            success: { (image) in
                self.image = image
            },
            failure: { (error) in
                log.error("Błąd: \(error.localizedDescription) dla urla: \(self.url.absoluteString)")
            }
        )
    }
}
