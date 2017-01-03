//
//  Photo.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 06.06.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    let id: Int
    let url: URL
    var author: String?
    var image: UIImage?
    var downloaded: Bool = false

    init?(dictionary: [String:AnyObject]) {
        guard
            let id = dictionary[JsonAttr.id] as? Int,
                let fileName = dictionary[JsonAttr.fileName] as? String,
                let url = URL(string: baseUrl + "shelter/" + EndPoint.files + fileName)
        else {
            log.error(Err.noIdOrName.desc())
            return nil
        }

        self.id = id
        self.url = url
        self.image = UIImage(named: "Placeholder")

        if let author = dictionary[JsonAttr.author] as? String {
            self.author = author
        }
    }

    /**
    Asynchroniczne pobieranie obrazka
    */
    func download(_ success: (() -> Void)? = nil) {
        if self.downloaded {
            log.debug("Zdjęcie zostało już wcześniej pobrane.")
            return
        }
        log.debug("Pobieram zdjęcie... \(self.url.absoluteString)")
        Request.getImageData(self.url,
            success: { (image) in
                self.image = image
                self.downloaded = true
                success?()
            },
            failure: { (error) in
                log.error("Błąd: \(error.localizedDescription) dla urla: \(self.url.absoluteString)")
            }
        )
    }
}
