//
//  AnimalCardView.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 20/06/16.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

//Karta określająca sposób prezentacji danych dotyczących zwierzaka

class AnimalCardView: UIView {
    
    @IBOutlet weak var animalPhoto: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalSize: UIImageView!
    @IBOutlet weak var animalGender: UIImageView!
    @IBOutlet weak var animalActivity: UIImageView!
    
    @IBOutlet weak var roundedCorn: UIView!
    @IBOutlet weak var shadowBorder: UIView!
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        roundedCorn.layer.masksToBounds = false
        roundedCorn.layer.shadowColor = UIColor.blackColor().CGColor
        roundedCorn.layer.shadowOpacity = 0.5
        roundedCorn.layer.shadowOffset = CGSize(width: 2.0, height: -2.0)
        
        roundedCorn.layer.shadowPath = UIBezierPath(rect:  self.frame).CGPath
        roundedCorn.layer.shouldRasterize = true
        
        shadowBorder.backgroundColor = UIColor.whiteColor()
        shadowBorder.layer.cornerRadius = 10.0
        shadowBorder.layer.borderColor = UIColor.grayColor().CGColor
        shadowBorder.layer.borderWidth = 0.5
        shadowBorder.layer.masksToBounds = true
        
    }
    
    var animal: Animal? {
        didSet {
            updateCellUI()
        }
    }
    
    
    //jeśli wartości nie są typu Unknown to ustawiamy odpowiednie obrazki w ikonach, jeśli są unknown to UIImageView pozostaje pusty
    private func updateCellUI(){
        
        guard let animal = animal else {
            log.error("No animal specified")
            return
        }
        
        self.animalName.text = animal.getDescription()
        
        if let animalSizeImageName = animal.size?.pl() {
            animalSize.image = UIImage.init(named: animalSizeImageName)
        }
        
        if let animalGenderImageName = animal.gender?.pl() {
            animalGender.image = UIImage.init(named: animalGenderImageName)
        }
        
        if let animalActivityImageName = animal.activity?.pl() {
                animalActivity.image = UIImage.init(named: animalActivityImageName)
        }
    }
    
}
