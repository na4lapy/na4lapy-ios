//
//  AnimalURLBuilder.swift
//  Na4Łapy
//
//  Created by mac on 15/09/2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import Foundation

class AnimalURLBuilder: URLBuildable {

    static func buildURLFrom(baseUrl: String, page: Int, pageSize: Int, params: UserPreferences?) -> String {
        var url = baseUrl + "?page=\(page)&size=\(pageSize)"

        guard let preferencesParams = params?.dictionaryRepresentation() else {
            //NO PARAMS PROVIDED
            return url
        }

        var spieciesParams = [String]()
        var genderParams = [String]()
        var sizeParams = [String]()
        var activitiesParams = [String]()
        for (paramKey, paramValue) in preferencesParams {

            switch paramKey {
            case Species.dog.rawValue, Species.cat.rawValue, Species.other.rawValue:
                if paramValue != 0 {
                    spieciesParams.append(paramKey)
                }
            case Gender.female.rawValue, Gender.male.rawValue:
                if paramValue != 0 {
                    genderParams.append(paramKey)
                }
            case Size.small.rawValue, Size.medium.rawValue, Size.large.rawValue:
                if paramValue != 0 {
                    sizeParams.append(paramKey)
                }
            case Activity.low.rawValue, Activity.high.rawValue:
                if paramValue != 0 {
                    activitiesParams.append(paramKey)
                }
            case ageBoundaries.ageMax.rawValue, ageBoundaries.ageMin.rawValue:
                url += "&\(paramKey)=\(paramValue)"

            default:
                break
            }
        }

        if (!spieciesParams.isEmpty) {
            let joinedParams = spieciesParams.joined(separator: ",")
            url += "&spiecies=\(joinedParams)"
        }

        if (!genderParams.isEmpty) {
            let joinedParams = genderParams.joined(separator: ",")
            url += "&genders=\(joinedParams)"
        }

        if (!sizeParams.isEmpty) {
            let joinedParams = sizeParams.joined(separator: ",")
            url += "&sizes=\(joinedParams)"
        }

        if (!activitiesParams.isEmpty) {
            let joinedParams = sizeParams.joined(separator: ",")
            url += "&activities=\(joinedParams)"
        }

        return url
    }
}
