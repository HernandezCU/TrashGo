//
//  TV_Cell.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit

class TV_Cell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        contentView.layer.cornerRadius = 15
    }

}
