//
//  Listing.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 19.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

protocol ListingProtocol {
    static func get(page: Int, size: Int, preferences: UserPreferences?, success: ([AnyObject], Int) -> Void, failure: (NSError) -> Void)
    init?(dictionary: [String:AnyObject])
}

/**
 Obsługa listingu wraz z prefetch'em
 Zasada działania.

 Dane z API są pobierane stronami. Na stronie znajduje się PAGESIZE elementów, które zostają zwrócone w formie tablicy. Taka tablica (strona) jest wpisywana do słownika localCache pod klucz będący ID danej strony, np:

 Strona o id 1 będzie wpisana jako [1, Array<AnyObject>]

 Jak dzała prefetch.
 Wywołując metodę next() poruszamy się wzdłuż aktualnej strony (localCachePage) inkrementując localCacheIndex. Jeśli localCacheIndex znajdzie się w połowie aktualnej strony, to wykonywane są kolejno następujące operacje:
 - ładowana jest kolejna strona (czyli aktualna strona +1)
 - ładowana jest także wcześniejsza strona (-1) /* aby uprościć sprawdzanie w którą stronę następuje ruch, ale można to poprawić */
 - usuwana jest strona +2 /* to też można poprawić poprzez wykrywanie kierunku ruchu */
 - usuwana jest strona -2
 Oczywiście jeśli strony +1 lub -1 są już w pamięci, to nie zostaną ponownie załadowane.
 W wyniku działania powyższego algorytmu zawsze w pamięci znajdują się obiekty:
 - strona wcześniejsza
 - strona aktualna
 - strona kolejna
*/

class Listing {
    private var localCache: [Int: AnyObject] = [:]
    private var localCacheIndex = 0
    private var localCachePage = 0
    private var count = 0
    private let listingType: ListingProtocol.Type

    func prefetch(page: Int, success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        log.debug("prefetch page: \(page)")
        let userPreferences = UserPreferences.init()
        listingType.get(page, size: PAGESIZE, preferences: userPreferences,
            success: { [weak self] (elements, count) in
                guard let strongSelf = self else { return }
                strongSelf.localCache[page] = elements
                strongSelf.count = count
                success?()
            },
            failure: { (error) in
                log.error(error.localizedDescription)
                failure?()
            }
        )
    }

    init<T: ListingProtocol>(listingType: T.Type) {
        self.listingType = listingType
    }

    func prefetch( success: () -> Void ) {
        self.prefetch(0) {
            success()
        }
    }

    // Jeśli aktualny index strony przekroczy połowę wielkości to należy:
    // - pobrać kolejną stronę (+1)
    // - pobrać wcześniejszą stronę (-1)
    // - usunąć (-2)
    // - usunąć (+2)
    func clearAndPrefetch() {
        // +1
        if self.localCache[localCachePage+1] == nil {
            self.prefetch(localCachePage+1)
        }
        // -1
        if self.localCache[localCachePage-1] == nil {
            self.prefetch(localCachePage-1)
        }
        // -2
        self.localCache.removeValueForKey(localCachePage-2)
        // +2
        self.localCache.removeValueForKey(localCachePage+2)
    }

    func getCount() -> UInt {
        return UInt(self.count)
    }

    func get(index: UInt) -> AnyObject? {
        // Aktualna strona musi być dostepna, w przeciwnym wypadku należy ją pobrać
        guard let page = self.localCache[localCachePage] else {
            log.debug("Aktualna strona \(localCachePage) nie jest dostępna!")
            self.prefetch(localCachePage)
            return nil
        }

        // Konwersja index -> index/page
        self.localCachePage = Int(index)/PAGESIZE
        self.localCacheIndex = Int(index) - localCachePage*PAGESIZE

        if self.localCacheIndex == page.count/2 {
            self.clearAndPrefetch()
        }
        if self.localCacheIndex > page.count - 1 || Int(index) > self.count - 1 {
            return nil
        }

        log.debug("===== Strona: \(localCachePage), index: \(localCacheIndex)")

        if let returnPage = self.localCache[localCachePage] as? [AnyObject] where returnPage.count > 0 {
            return returnPage[localCacheIndex]
        } else {
            return nil
        }
    }
}
