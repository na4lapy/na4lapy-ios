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
    
    override func awakeFromNib() {
        self.animalPhoto?.layer.masksToBounds = true
        self.animalPhoto?.layer.cornerRadius = 8.0
    }
    
    let animalSizeImageDictionary = [
        Size.small : "Maly",
        Size.medium: "Sredni",
        Size.large: "Duzy"
    ]
    
    let animalGenderImageDictionary = [
        Gender.female : "Suczka",
        Gender.male : "Samiec"
    ]
    
    let animalActivityLevelImageDictionary = [
        Activity.high : "Aktywny",
        Activity.low : "Domator"
    ]
    
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
        
        if let animalSizeImageName = animalSizeImageDictionary[(animal.size)!] {
            animalSize.image = UIImage.init(named: animalSizeImageName)
        }
        
        if let animalGenderImageName = animalGenderImageDictionary[(animal.gender)!] {
            animalGender.image = UIImage.init(named: animalGenderImageName)
        }
        
        if let animalActivityImageName = animalActivityLevelImageDictionary[(animal.activity)!] {
                animalActivity.image = UIImage.init(named: animalActivityImageName)
        }
    }
    
}
