//
//  ViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit
import Koloda

private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent:CGFloat = 0.1

class AnimalCardsViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource{
    private var listing: Listing?
    @IBOutlet weak var kolodaView: AnimalKolodaView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.listing = Listing(listingType: Animal.self)
 
        // FIXME: co zrobić jeśli nie uda się pierwszy prefetch
        self.listing?.prefetch { [weak self] in
            guard let strongSelf = self else { return }
            //setting up the swipeable KolodaView
            dispatch_async(dispatch_get_main_queue()) {
                strongSelf.kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
                strongSelf.kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
                strongSelf.kolodaView.dataSource = self
                strongSelf.kolodaView.delegate = self
                strongSelf.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
                strongSelf.kolodaView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: KolodaDataSourceImplementation 
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return listing?.getCount() ?? 0
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let animalCard = NSBundle.mainBundle().loadNibNamed("AnimalCardView", owner: self, options: nil)[0] as? AnimalCardView
        guard
            let animal = listing?.get(index) as? Animal,
            let animalImage = animal.getFirstImage()
        else {
            // FIXME: w tym miejscu zwrócić obrazek z błędem
            return UIView()
        }
        animalCard?.animalPhoto?.image = animalImage
        animalCard?.animal = animal
        return animalCard ?? UIView()           // FIXME: w tym miejscu obrazek z błędem
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        let overlay = UIView(frame: kolodaView.frame)
        overlay.backgroundColor = UIColor.blackColor()
        overlay.alpha = 0.5
        return overlay as? OverlayView
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        log.debug("didSelectCardAtIndex \(index)")
    }
    
    func kolodaShouldApplyAppearAnimation(koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func koloda(koloda: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        
        if(direction == .Left) {
            koloda.revertAction()
        }
    }
    

}

