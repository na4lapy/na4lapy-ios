//
//  FavouriteViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 04.11.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var favouriteAnimals: [Animal] = []

    var searchController: UISearchController?


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        let nib = UINib(nibName: "FavouriteTableHeaderView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableHeader")

    }

    
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        self.favouriteAnimals.removeAll()
        self.prepareFavouriteTable()
    }
    
    func prepareFavouriteTable() {
        guard let favouriteIds = Favourite.get() else {
            log.debug("Brak ulubionych zwierzaków")
            return
        }
        for id in favouriteIds {
            Animal.getById(id,
               success: { [weak self] animals in

                    DispatchQueue.main.async {
                        self?.favouriteAnimals.append(animals.first!)
                        log.debug("Zwierzak nr \(animals.first?.id) pobrany z ulubionych")
                        self?.tableView.reloadData()

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
        let header = bundle.loadNibNamed("FavouriteTableHeader", owner: self, options: nil)?.first

        guard let h = header as? FavouriteTableHeader else {
            return nil
        }
        h.delegate = self
        return h
    }


}

extension FavouriteViewController: FavouriteTableHeaderDelegate {

    func didSelect(favAnimalType: FavAnimalType) {
        log.debug("\(favAnimalType)")
    }
}
