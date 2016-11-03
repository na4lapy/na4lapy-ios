//
//  BoolInitExtension.swift
//  Na4Łapy
//
//  Created by mac on 12/09/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

extension Bool {
    init<T: Integer>(_ integer: T) {
        if integer == 0 {
            self.init(false)
        } else {
            self.init(true)
        }
    }

}
