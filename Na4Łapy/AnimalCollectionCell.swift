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
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shouldRasterize = false
//        self.layer.shadowPath = UIBezierPath(rect: self.frame).CGPath
    }

    //MARK: Public API
    
    var animal: Animal? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: Private
 
    @IBOutlet weak var animalActivityLevelIcon: UIImageView! 
    
    @IBOutlet weak var animalGenderIcon: UIImageView!
    
    @IBOutlet weak var animalSizeIcon: UIImageView!
    
    @IBOutlet weak var animalDescriptionLabel: UILabel!
    
    @IBOutlet weak var animalImage: UIImageView!
    
    
    private func updateUI() {
        animalDescriptionLabel.text! = (animal?.getDescription())!
        animalImage.image = animal?.getFirstImage()
        
        if let animalSize = animal?.size?.pl() {
            animalSizeIcon.image = UIImage(named: animalSize)
        }
        
        if let animalGender = animal?.gender?.pl() {
            animalGenderIcon.image = UIImage(named: animalGender)
        }
        
        if let animalActivityLevel = animal?.activity?.pl() {
            animalActivityLevelIcon.image = UIImage(named: animalActivityLevel)
        }
        
        
    }
    
}
