//
//  LBCell.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit

class LBCell: UITableViewCell {
        
        @IBOutlet weak var icon: UIImageView!
        @IBOutlet weak var username: UILabel!
        @IBOutlet weak var points: UILabel!
        
        override func layoutSubviews() {
            super.layoutSubviews()

            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
            contentView.layer.cornerRadius = 15
        }

}
