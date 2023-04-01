//
//  PopoverProfile.swift
//  TrashGo
//
//  Created by Ari Yam on 4/1/23.
//

import UIKit

class PopoverProfile: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!

    @IBOutlet var firstPlaceBtn: UIImageView!
    @IBOutlet var secondPlaceBtn: UIImageView!
    @IBOutlet var thirdPlaceBtn: UIImageView!
    
    @IBOutlet var podiumView: UIView!
    
    
    struct lboard{
        let icon: String
        let username: String
        let points: String
        
    }
    
    let data: [lboard] = [lboard(icon: "first", username: "DaCat4MVP", points: "1000000"), lboard(icon: "second", username: "IDK", points: "89022"), lboard(icon: "third", username: "JOHS", points: "12344")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        podiumView.layer.masksToBounds = false
        
        firstPlaceBtn.layer.cornerRadius = 0.40 * firstPlaceBtn.bounds.size.width

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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell  = table.dequeueReusableCell(withIdentifier: "lbcell", for: indexPath) as! LBCell
            let d  = data[indexPath.row]
            
            cell.username.text = d.username
            cell.points.text = d.points
            cell.icon.image = UIImage(named: d.icon)
            
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            
            return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
