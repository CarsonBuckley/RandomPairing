//
//  PersonTableViewCell.swift
//  RandomPairing
//
//  Created by Carson Buckley on 4/19/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateView(with person: Person) {
        nameLabel.text = "\(person.name)"
    }
    
}
