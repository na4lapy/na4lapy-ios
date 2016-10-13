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

    fileprivate func out(_ msg: String) {
    #if DEBUG
        print(msg)
    #endif
    }

    func error(_ msg: String, file: String = #file, function: String = #function) {
        var filename: String = file
        if let lastPathElement = file.components(separatedBy: "/").last {
            filename = lastPathElement
        }
        self.out("ERROR/\(filename)/\(function): \(msg)")
    }

    func debug(_ msg: String, file: String = #file, function: String = #function) {
        var filename: String = file
        if let lastPathElement = file.components(separatedBy: "/").last {
            filename = lastPathElement
        }
        self.out("DEBUG/\(filename)/\(function): \(msg)")
    }
}
