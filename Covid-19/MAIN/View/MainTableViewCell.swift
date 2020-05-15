//
//  MainTableViewCell.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 13.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
//MARK: - LINKS
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
