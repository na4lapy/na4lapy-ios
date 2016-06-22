//
//  Listing.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 19.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

protocol ListingProtocol {
    static func get(page: Int, size: Int, preferences: UserPreferences?, success: ([AnyObject]) -> Void, failure: (NSError) -> Void)
    init?(dictionary: [String:AnyObject])
}

class Listing {
    private var localCache : [AnyObject] = []
    private var localCacheIndex = 0
    private let listingType: ListingProtocol.Type
    
    private func prefetch(page: Int) {
        listingType.get(page, size: PAGESIZE, preferences: nil,
            success: { [weak self] (elements) in
                guard let strongSelf = self else { return }
                strongSelf.localCache = elements
            },
            failure: { (error) in
                log.error(error.localizedDescription)
            }
        )
    }

    init<T: ListingProtocol>(listingType: T.Type) {
        self.listingType = listingType
        self.prefetch(1)
    }
    
    func next() -> AnyObject? {
        if self.localCacheIndex+1 >= self.localCache.count {
            return nil
        }
        self.localCacheIndex += 1
        return localCache[self.localCacheIndex] ?? nil
    }
    
    func prev() -> AnyObject? {
        if self.localCacheIndex-1 < 0 {
            return nil
        }
        self.localCacheIndex -= 1
        return localCache[self.localCacheIndex] ?? nil
    }
}