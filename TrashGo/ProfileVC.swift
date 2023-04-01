//
//  ProfileVC.swift
//  TrashGo
//
//  Created by Ari Yam on 3/31/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var leaderboardBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        profileImageView.layer.cornerRadius = profileImageView.frame.height/2

        
        bgView.layer.masksToBounds = false
        
        
    }

}

