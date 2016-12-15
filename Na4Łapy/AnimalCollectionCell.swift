//
//  AnimalCardView.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 20/06/16.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit

//Karta określająca sposób prezentacji danych dotyczących zwierzaka

class AnimalCollectionCell: UICollectionViewCell {

    @IBOutlet weak var favouriteButtonOutlet: UIButton!
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        guard let id = animal?.id else {
            return
        }
        if Favourite.isFavourite(id) {
            Favourite.delete(id)
            log.debug("polubienie usunięte dla nr \(id) :(")
            self.favouriteButtonOutlet.setImage(UIImage(named: "unfavouriteStateIcon"), for: UIControlState.normal)
        } else {
            Favourite.add(id)
            log.debug("zwierzak nr \(id) polubiony")
            self.favouriteButtonOutlet.setImage(UIImage(named: "favouriteStateIcon"), for: UIControlState.normal)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.animalImage.clipsToBounds = true
    }

    //MARK: Public API

    var animal: Animal? {
        didSet {
            updateUI()
        }
    }

    
    @IBOutlet fileprivate weak var animalDescriptionLabel: UILabel!
    @IBOutlet fileprivate weak var animalImage: UIImageView!

    fileprivate func updateUI() {
        guard let animal = animal else {
            log.error("Brak zwierzaka.")
            return
        }
        
        if Favourite.isFavourite(animal.id) {
            self.favouriteButtonOutlet.setImage(UIImage(named: "favouriteStateIcon"), for: UIControlState.normal)
        } else {
            self.favouriteButtonOutlet.setImage(UIImage(named: "unfavouriteStateIcon"), for: UIControlState.normal)
        }
        
        animalDescriptionLabel.text = animal.getAgeName()
        animalImage.image = animal.getFirstImage()


    }

}
