//
//  AnimalCardView.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 20/06/16.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

//Karta określająca sposób prezentacji danych dotyczących zwierzaka

class AnimalCollectionCell: UICollectionViewCell {

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
        animalDescriptionLabel.text = animal?.getAgeName()
        animalImage.image = animal?.getFirstImage()

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
