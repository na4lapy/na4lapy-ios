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
//        let animalImageMask = CAShapeLayer()
//        animalImageMask.path = UIBezierPath(roundedRect: animalImage.bounds, byRoundingCorners:  UIRectCorner.TopLeft.union(.TopRight), cornerRadii: CGSize(width: 10, height: 10)).CGPath
//        self.animalImage.layer.mask = animalImageMask
    }

    //MARK: Public API

    var animal: Animal? {
        didSet {
            updateUI()
        }
    }

    //MARK: Private

//    @IBOutlet private weak var animalActivityLevelIcon: UIImageView!
//    @IBOutlet private weak var animalGenderIcon: UIImageView!
//    @IBOutlet private weak var animalSizeIcon: UIImageView!
    
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

//        if let animalSize = animal?.size?.pl() {
//            animalSizeIcon.image = UIImage(named: animalSize)
//        }
//
//        if let animalGender = animal?.gender?.pl() {
//            animalGenderIcon.image = UIImage(named: animalGender)
//        }
//
//        if let animalActivityLevel = animal?.activity?.pl() {
//            animalActivityLevelIcon.image = UIImage(named: animalActivityLevel)
//        }


    }

}
