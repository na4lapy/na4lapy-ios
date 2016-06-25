//
//  AnimalCardView.swift
//  Na4Łapy
//
//  Created by mac on 20/06/16.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class AnimalCardView: UIView {
    @IBOutlet weak var animalPhoto: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalSize: UIImageView!
    @IBOutlet weak var animalGender: UIImageView!
    @IBOutlet weak var animalActivity: UIImageView!
    
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
    
    private func updateCellUI(){
        animalName.text = animal?.name
        animalSize.image = UIImage.init(named: animalSizeImageDictionary[(animal?.size)!]!)
        animalGender.image = UIImage.init(named: animalGenderImageDictionary[(animal?.gender)!]!)
        if let animalActivityImageName = animalActivityLevelImageDictionary[(animal?.activity)!] {
                animalActivity.image = UIImage.init(named: animalActivityImageName)
        }
        
    }
    
}
