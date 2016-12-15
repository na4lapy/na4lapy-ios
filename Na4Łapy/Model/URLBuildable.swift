//
//  URLBuildable.swift
//  Na4Łapy
//
//  Created by mac on 15/09/2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import Foundation

protocol URLBuildable {
    static func buildURLFrom(baseUrl: String, page: Int, pageSize: Int, params: UserPreferences?) -> String
}
