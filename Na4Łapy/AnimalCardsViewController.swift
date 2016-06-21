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
    var animals : [Animal]?
    var index = 0
    
    @IBOutlet weak var kolodaView: AnimalKolodaView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        //setting up the swipeable KolodaView
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        fetchAnimals()
      
    }
    
    
    func fetchAnimals() {
        
        Request.getAnimal(
            page: 1,
            size: 10,
            success: { [weak self] (animals) in
                            guard let strongSelf = self else { return }
                            print(animals.count)
                            strongSelf.animals = animals
                dispatch_async(dispatch_get_main_queue(),{strongSelf.kolodaView.reloadData()})
                
                        },
            failure: { (error) in
            log.error(error.localizedDescription)
            }
        )
    }
    
    @IBAction func prev(sender: UIButton) {
        if self.index-1 < 0 {
            return
        }
        self.index -= 1
//        self.showMainPhoto()
    
    }
    @IBAction func next(sender: UIButton) {
        if index+1 >= self.animals?.count {
            return
        }
        self.index += 1
//        self.showMainPhoto()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: KolodaDataSourceImplementation 
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        //TODO: review nie wiem czy to dobrze unwrappuje
        return UInt(self.animals?.count ?? 0)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let animalCard = NSBundle.mainBundle().loadNibNamed("AnimalCardView", owner: self, options: nil)[0] as? AnimalCardView
        let animalImage = animals?[Int(index)].getFirstImage()
        animalCard?.animalPhoto?.image = animalImage
        animalCard?.animalName.text = animals?[Int(index)].name
        log.debug((animals?[Int(index)].name)!)
        return animalCard!
//        return UIImageView(image: animals?[Int(index)].getFirstImage())
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

}

