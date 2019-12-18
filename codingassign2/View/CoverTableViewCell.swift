//
//  CoverTableViewCell.swift
//  codingassign2
//
//  Created by Igwe Onumah on 12/17/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import UIKit

class CoverTableViewCell: UITableViewCell {

  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    
    static let identifier = "CoverTableViewCell"
}
