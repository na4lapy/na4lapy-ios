//
//  Logger.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 07.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

let log = Logger.sharedInstance

/**
 Prosty Logger komunikatów na konsolę
*/
class Logger {
    static let sharedInstance = Logger()
    
    private func out(msg: String) {
    #if DEBUG
        print(msg)
    #endif
    }
    
    func error(msg: String, file: String = #file, function: String = #function) {
        self.out("\(file) \(function) : \(msg)")
    }
    
    func debug(msg: String, file: String = #file, function: String = #function) {
        self.out("\(file) \(function) : \(msg)")
    }
    
}