//
//  SheltersViewController.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 01/04/2017.
//  Copyright © 2017 Koduj dla Polski. All rights reserved.
//

import UIKit

class SheltersViewController: UITableViewController {

    var shelters: [Shelter]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        Shelter.all(success: { (shelters, count) in
            self.shelters = shelters
        }) { (err) in
            Logger.sharedInstance.debug(err.localizedDescription)
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShelterCell", for: indexPath)
        cell.textLabel?.text = shelters?[indexPath.item].name
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelters?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shelter = shelters?[indexPath.item]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShelterViewController") as? ShelterViewController
        vc?.shelter = shelter
        navigationController?.pushViewController(vc!, animated: true)
        
    }

}
