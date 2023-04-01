//
//  PopoverProfile.swift
//  TrashGo
//
//  Created by Ari Yam on 4/1/23.
//

import UIKit

class PopoverProfile: UIViewController {

    
    @IBOutlet var firstPlaceBtn: UIImageView!
    @IBOutlet var secondPlaceBtn: UIImageView!
    @IBOutlet var thirdPlaceBtn: UIImageView!
    
    @IBOutlet var podiumView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        podiumView.layer.masksToBounds = false
        
        firstPlaceBtn.layer.cornerRadius = 0.5 * firstPlaceBtn.bounds.size.width

        secondPlaceBtn.layer.cornerRadius = 0.5 * secondPlaceBtn.bounds.size.width
        thirdPlaceBtn.layer.cornerRadius = 0.5 * thirdPlaceBtn.bounds.size.width
        
        firstPlaceBtn.layer.shadowColor = CGColor( red:0/255.0 , green: 0/255.0 , blue: 0/255.0 , alpha: 1.0 )
        firstPlaceBtn.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        firstPlaceBtn.layer.shadowRadius = 1.7
        firstPlaceBtn.layer.shadowOpacity = 0.45
        
        secondPlaceBtn.layer.shadowColor = CGColor( red:0/255.0 , green: 0/255.0 , blue: 0/255.0 , alpha: 1.0 )
        secondPlaceBtn.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        secondPlaceBtn.layer.shadowRadius = 1.7
        secondPlaceBtn.layer.shadowOpacity = 0.45
        
        thirdPlaceBtn.layer.shadowColor = CGColor( red:0/255.0 , green: 0/255.0 , blue: 0/255.0 , alpha: 1.0 )
        thirdPlaceBtn.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        thirdPlaceBtn.layer.shadowRadius = 1.7
        thirdPlaceBtn.layer.shadowOpacity = 0.45
        
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
