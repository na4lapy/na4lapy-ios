//
//  PomagajViewController.swift
//  Na4Łapy
//
//  Created by scoot on 04.11.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit

class PomagajViewController: UIViewController {

    @IBAction func pomagaj(_ sender: AnyObject) {
        let url2 = URL(string: "https://secure.paylane.com/pl.html,Zw7PmynVVL")
        UIApplication.shared.openURL(url2!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
