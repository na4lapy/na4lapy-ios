//
//  ErrorString.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 08.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit

enum Error: Int {
    case NoIdOrName = 1, WrongJsonKey, JsonParseError, NoData, WrongURL, WrongJsonStruct, NoImageData

    func desc() -> String {
        switch self {
        case NoIdOrName:
            return "Brak 'id' lub 'name' w parametrach kontruktora klasy"
        case WrongJsonKey:
            return "Błędny klucz JSON"
        case JsonParseError:
            return "Błąd parsowania JSON"
        case NoData:
            return "Brak danych"
        case WrongURL:
            return "Błędny URL"
        case WrongJsonStruct:
            return "Nieprawidłowa struktura JSON"
        case NoImageData:
            return "Brak zdjęcia"
        }
    }
    
    func err() -> NSError {
        let error = NSError(domain: ErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: self.desc()])
        return error
    }
}


