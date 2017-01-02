//
//  Listing.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 19.06.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import Foundation

protocol ListingProtocol {
    static func get(_ page: Int, size: Int, preferences: UserPreferences?, success: @escaping ([AnyObject], Int) -> Void, failure: @escaping (NSError) -> Void)
    init?(dictionary: [String:AnyObject])
}

/**
 Obsługa listingu wraz z prefetch'em
 Zasada działania.

 Dane z API są pobierane stronami. Na stronie znajduje się PAGESIZE elementów, które zostają zwrócone w formie tablicy. Taka tablica (strona) jest wpisywana do słownika localCache pod klucz będący ID danej strony, np:

 Strona o id 1 będzie wpisana jako [1, Array<AnyObject>]

 Jak działa metoda get(index:)
 =============================
 
 Parametrem metody jest index, czyli kolejny numer obiektu. Przykładowo: zwierzaków w bazie jest 120, więc index może przyjąć wartość od 1 do 120.
 Przyjmijmy, że metoda get została wywołana z parametrem 56, przy czym rozmiar strony jest ustalony na 10 (stała PAGESIZE)
 Oznacza to, że szukany obiekt znajduje się na stronie nr 5 (56/10) i jest to 6-ty element tej strony 56-5*10.
 Otrzymujemy więc zmienne:
    localCachePage = 5
    localCacheIndex = 6
 Kolejnym krokiem jest test, czy localCacheIndex wskazuje dokładnie połowę aktualnej strony. Jeśli tak, to należy wykonać prefetch kolejnej strony.
 Przy rozmiarze strony 10, index 6 wykracza poza połowę, więc nie należy wykonywać prefetch (gdyż został wykonany przy poprzednim pobieraniu indexu o wartości 5)
 Skoro nie trzeba wykonywać prefetch, to metoda get kończy pracę zwracając obiekt nr 6 na stronie nr 5.
 
 ------
 
 Rozważmy inny przypadek, gdy prefetch będzie konieczny.
 Pytamy o index = 85
    localCachePage = 8 (gdyż 85/10)
    localCacheIndex = 5 (85 - 8*10)
 localCacheIndex wskazuje dokładnie na PAGESIZE/2, więc należy wykonać prefetch kolejnej strony (czyli strona nr 9). Dodatkowo wykonywane są jeszcze 3 inne czynności:
 1. prefetch _poprzedniej_ strony, czyli strony nr 7, gdyby użytkownik zechciał się cofnąć.
 2. usuwana jest strona oddalona o 2 od aktualnej, czyli 8 + 2 = 10 (bo nie chcemy przechowywać tak wielu stron)
 3. usuwana jest strona oddalona o -2 od aktualnej, czyli 8 - 2 = 6 (j.w.)
 W wyniku w/w operacji w pamięci urządzenia znajdują się 3 strony: poprzednia, aktualna oraz następna.
 (btw. prefetch stron nie jest wykonywany jeśli strony już znajdują się w pamięci)
 
 Uwaga, metody prefetch i clearAndPrefetch wykonywane są asynchronicznie. Oznacza to, że wyjście z metody get może nastąpić _zanim_ te metody zakończą pracę.
 Może to się zdarzyć w momencie np. problemów sieciowych, timeoutu na serwerze itp. Możliwe są 2 scenariusze błędów:
 1. metoda prefetch zakończyła się błędem (bo np. serwer nie odpowiada)
 2. metoda prefetch zakończyła się poprawnie, lecz po długim czasie (np. 10 sek.)
 
 W przypadku wariantu 1, nie zostanie załadowana kolejna strona. Wszystkie obiekty aktualnej strony będą dostępne dla użytkownika 
 (czyli obiekty o localCacheIndex od 1 do 10), jednak podczas zmiany strony na kolejną użytkownik otrzyma błąd. Metoda get posiada zabezpieczenie i zawsze
 próbuje jeszcze raz pobrać aktualną stronę, o ile nie została wcześniej załadowana. Jeśli jednak i to zawiedzie, to oznacza problem sieciowy/serwerowy i należy
 oddać inicjatywę użytkownikowi (np. przycisk "spróbuj ponownie")
 
 W przypadku wariantu nr 2, metoda get zakończy się wcześniej niż prefetch. Użytkownik nadal będzie dysponował obiektami aktualnej strony (od 1 do 10) i teraz
 mogą się zdarzyć 2 kolejne warianty:
 a. użytkownik bardzo szybko "doscrollował" do obiektu nr 10 i przełączył stronę zanim metoda prefetch się zakończyła
 b. użytkownik powoli scrolluje i metoda prefetch zdążyła zakończyć się zanim została przełączona strona.
 
 Jeśli wystąpił wariant 'a', to użytkownik dostanie błąd, który jest spowodowany problemami sieciowymi. Należy więc oddać mu inicjatywę jak to opisano wyżej.
 Wariant 'b' oznacza, że użytkownik nie zauważy problemu gdyż kolejna strona zdąży zostać załadowana zanim wystąpi potrzeba jej wyświetlenia.
 
 Wszystkie operacje na lokalnym cache MUSZĄ być wykonywane na tym samym wątku, więc w przypadku wprowadzenia wielowątkowości do aplikacji należy to zabezpieczyć.
 
 */

class Listing {
    fileprivate var localCache: [Int: AnyObject] = [:]
    fileprivate var localCacheIndex = 0
    fileprivate var localCachePage = 0
    fileprivate var count = 0
    fileprivate let listingType: ListingProtocol.Type

    func prefetch(_ page: Int, success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        log.debug("prefetch page: \(page)")
        let userPreferences = UserPreferences.init()
        listingType.get(page, size: PAGESIZE, preferences: userPreferences,
            success: { [weak self] (elements, count) in
                guard let strongSelf = self else { return }
                strongSelf.localCache[page] = elements as AnyObject?
                strongSelf.count = elements.count
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

    private func prefetch( _ success: @escaping () -> Void ) {
        self.prefetch(0) {
            success()
        }
    }

    // Jeśli aktualny index strony przekroczy połowę wielkości to należy:
    // - pobrać kolejną stronę (+1)
    // - pobrać wcześniejszą stronę (-1)
    // - usunąć (-2)
    // - usunąć (+2)
    private func clearAndPrefetch() {
        // +1
        if self.localCache[localCachePage+1] == nil {
            self.prefetch(localCachePage+1)
        }
        // -1
        if self.localCache[localCachePage-1] == nil {
            self.prefetch(localCachePage-1)
        }
        // -2
        self.localCache.removeValue(forKey: localCachePage-2)
        // +2
        self.localCache.removeValue(forKey: localCachePage+2)
    }

    func getCount() -> UInt {
        return UInt(self.count)
    }

    func get(_ index: UInt) -> AnyObject? {
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

        if let returnPage = self.localCache[localCachePage] as? [AnyObject] , returnPage.count > 0 {
            return returnPage[localCacheIndex]
        } else {
            return nil
        }
    }
}
