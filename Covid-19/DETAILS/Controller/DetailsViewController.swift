//
//  DetailsViewController.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 15.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
//MARK: - LINKS    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    
  
//MARK: - VARIABLES
    var country = Country(fullName: "", iso2: "")
    
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNameLabel.text = country.fullName
    }
    
    
    
//MARK: - FUNCTIONS
   
    
    
}
