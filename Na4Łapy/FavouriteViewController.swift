//
//  FavouriteViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 04.11.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var favouriteAnimals: [Animal] = []

    var searchController: UISearchController?

    var favAnimalType: FavAnimalType = .All

    var header: FavouriteTableHeader?


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = selfb
        tableView.separatorStyle = .none

        let nib = UINib(nibName: "FavoubriteTableHeaderView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableHeader")

    }

    
    override func viewDidAppear(_ animated: Bool) {

        self.prepareFavouriteTable()
    }
    
    func prepareFavouriteTable() {
        self.favouriteAnimals.removeAll()
        guard let favouriteIds = Favourite.get() else {
            log.debug("Brak ulubionych zwierzaków")
            return
        }
//        Sposób użycia: {{url}}/v1/animals?filter=0,1,2,3,4
        for id in favouriteIds {
            Animal.getById(id,
               success: { [weak self] animals in

                    DispatchQueue.main.async {

                        //if species of animal is the same as the one set from header or any type of species is set
                        if animals.first?.species?.rawValue == self?.favAnimalType.toString() || self?.favAnimalType.rawValue == 0 {
                            self?.favouriteAnimals.append(animals.first!)
                            log.debug("Zwierzak nr \(animals.first?.id) pobrany z ulubionych")
                            self?.tableView.reloadData()
                        }
                    }
                },
                failure: { _ in
                    log.error("Błąd podczas pobierania ulubionych zwierzaków")
                }
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return favouriteAnimals.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as? FavouriteTableViewCell else {
            assert(false, "Cell should be favouriteCell")
        }

        cell.configureCell(withAnimal: favouriteAnimals[indexPath.row])
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let bundle = Bundle.main
        header = bundle.loadNibNamed("FavouriteTableHeader", owner: self, options: nil)?.first as? FavouriteTableHeader

        header?.delegate = self

        header?.animalTypeSelector.selectedSegmentIndex = favAnimalType.rawValue

        return header
    }




    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "FavouriteAnimalSegue",
            let animalId = (sender as? FavouriteTableViewCell)?.favouriteAnimalId,
            let vc = segue.destination as? AnimalDetailViewController
        else {
            return
        }

        vc.animal = favouriteAnimals.filter( { $0.id == animalId } ).first
    }

}

extension FavouriteViewController: FavouriteTableHeaderDelegate {

    func didSelect(favAnimalType: FavAnimalType) {
        self.favAnimalType = favAnimalType

        prepareFavouriteTable()
    }

}


extension FavouriteViewController: FavouriteTableCellDelegate {

    func removeFromFavouritesAnimal(withId id: Int) {
        Favourite.delete(id)
    }
}
