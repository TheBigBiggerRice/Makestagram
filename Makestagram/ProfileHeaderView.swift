//
//  ProfileHeaderView.swift
//  Makestagram
//
//  Created by Chenyang Zhang on 7/3/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import UIKit


protocol ProfileHeaderViewDelegate: class {
    func didTapSettingsButton(_ button: UIButton, on headerView: ProfileHeaderView)
        
    
    
}
class ProfileHeaderView: UICollectionReusableView {
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    
    @IBOutlet weak var settingsButton: UIButton!
    weak var delegate: ProfileHeaderViewDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingsButton.layer.cornerRadius = 6
        settingsButton.layer.borderColor = UIColor.lightGray.cgColor
        settingsButton.layer.borderWidth = 1
        
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        delegate?.didTapSettingsButton(sender, on: self)

        
    }
    
}
