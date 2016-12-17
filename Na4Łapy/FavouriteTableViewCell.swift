//
//  FavouriteTableViewCell.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 15/11/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalDescLabel: UILabel!
    var favouriteAnimalId: Int?
    weak var delegate: FavouriteTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(withAnimal animal:Animal) {
        animalDescLabel.text = animal.getAgeName()
        animalImage.image = animal.getFirstImage()
        favouriteAnimalId = animal.id
    }


    @IBAction func onRemoveFavouriteButtonPressed(_ sender: Any) {
        if let animalId = favouriteAnimalId {
            delegate?.removeFromFavouritesAnimal(withId: animalId)
        }
    }

}
