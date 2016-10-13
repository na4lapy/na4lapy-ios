//
//  ErrorString.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 08.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit

enum Err: Int {
    case noIdOrName = 1, wrongJsonKey, jsonParseError, noData, wrongURL, wrongJsonStruct, noImageData, illegalPageNumber

    func desc() -> String {
        switch self {
        case .noIdOrName:
            return "Brak 'id' lub 'name' w parametrach kontruktora klasy"
        case .wrongJsonKey:
            return "Błędny klucz JSON"
        case .jsonParseError:
            return "Błąd parsowania JSON"
        case .noData:
            return "Brak danych"
        case .wrongURL:
            return "Błędny URL"
        case .wrongJsonStruct:
            return "Nieprawidłowa struktura JSON"
        case .noImageData:
            return "Brak zdjęcia"
        case .illegalPageNumber:
            return "Nieprawidłowy numer strony (musi być >= 0)"
        }
    }

    func err() -> NSError {
        let error = NSError(domain: errorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: self.desc()])
        return error
    }
}

enum JsonError: Error {
    case parseError
    case noData
}
