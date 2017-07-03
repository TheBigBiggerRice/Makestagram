//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Chenyang Zhang on 6/29/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import UIKit

class PostHeaderCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let height: CGFloat = 54

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("options button tapped")
    }
}
