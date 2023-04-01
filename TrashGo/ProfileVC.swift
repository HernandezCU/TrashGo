//
//  ProfileVC.swift
//  TrashGo
//
//  Created by Ari Yam on 3/31/23.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var bgBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2

        bgBackgroundView.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
