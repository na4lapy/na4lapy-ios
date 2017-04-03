//
//  AboutAppViewController.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 03/04/2017.
//  Copyright © 2017 Koduj dla Polski. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet weak var aboutLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       aboutLabel.text = "Aplikacja „Na4Łapy” to świetne narzędzie, które pomoże Ci wybrać odpowiedniego dla Ciebie pupila. Chcesz dużego psa? A może szukasz kota? Ma to być zwierzę aktywne, czy chcesz typowego domowego pieszczocha? Określ swoje preferencje, a „Na4Łapy” dopasuje dla Ciebie czworonoga, którego możesz adoptować ze schroniska. Nie ograniczasz się do jednego miasta i schroniska? Nie martw się, niebawem „Na4Łapy” współpracować będzie z większą liczbą schronisk.\n\nTa aplikacja w 3 prostych krokach umożliwi Ci także wpłacenie drobnej kwoty na schronisko. To dzięki takim datkom schronisko funkcjonuje, a mieszkające tam zwierzaki otrzymują jedzenie, leki i opiekę. Wpłata może być jednorazowa, do niczego nie zobowiązuje, operatorzy zrzekli się prowizji i całość pieniędzy wpływa na konto schroniska.\n\nNieustanie staramy się rozwijać, dodawać nowe funkcjonalności, zostań z nami na dłużej i pomagaj zwierzakom.\n\nBądź aktywny, bądź wrażliwy, jeżeli nie Ty to kto?"

    }

    override func viewDidLayoutSubviews() {
        aboutLabel.contentOffset = CGPoint.zero
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
