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
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self?.favouriteAnimals.append(animals.first!)
                    log.debug("Zwierzak nr \(animals.first?.id) pobrany z ulubionych")
                    self?.tableView.reloadData()
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
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "favouriteCell")
        
        cell.textLabel?.text = favouriteAnimals[indexPath.row].name
        return cell
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
