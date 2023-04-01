//
//  PopoverProfile.swift
//  TrashGo
//
//  Created by Ari Yam on 4/1/23.
//

import UIKit
import Alamofire
import NotificationBannerSwift

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
    
    let data: [lboard] = [lboard(icon: "first", username: "matt@matt.com", points: "123"), lboard(icon: "second", username: "godaddy123222", points: "100"), lboard(icon: "third", username: "godaddy123223", points: "80"), lboard(icon: "", username: "godaddy123224", points: "50"), lboard(icon: "", username: "godaddy123225", points: "40"), lboard(icon: "", username: "godaddy123226", points: "20"), lboard(icon: "", username: "godaddy123227", points: "10"),
        lboard(icon: "", username: "godaddy123228", points: "0"),
        lboard(icon: "", username: "godaddy123229", points: "0"),
        lboard(icon: "", username: "godaddy123230", points: "0")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLB()
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
        
        if d.icon != ""{
            cell.icon.image = UIImage(named: d.icon)
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func fetchLB(){
        
        let request = AF.request("https://greencitygo.net/leaderboard", method: .get)
        
        request.responseDecodable(of: resp.self) { (response) in
            print("here4")
            guard let response = response.value else {
                print("Failed")
                print(response)
                return }
            print("Success")
            //self.spinner.stopAnimating()
            if (response.success != true){
                let error_banner = FloatingNotificationBanner(title: "Could not Log In", subtitle: response.error, style: .danger)
                error_banner.show(queuePosition: .front,
                                  bannerPosition: .top,
                                  cornerRadius: 10,
                                  shadowBlurRadius: 0)
                
            }else{
                let success_banner = FloatingNotificationBanner(title: "Logged In Successfully", subtitle: response.error, style: .success)
                success_banner.show(queuePosition: .front,
                                    bannerPosition: .top,
                                    cornerRadius: 10,
                                    shadowBlurRadius: 0)
                print(response.success)
                DispatchQueue.main.async {
                    //self.dismiss(animated: true)
                    
                    //                        self.key_label.text = user.user.key
                    //                        self.email_label.text = user.user.email
                    //                        self.name_label.text = user.user.name
                    //                        self.password_label.text = user.user.password
                    //                        self.phone_label.text = user.user.phone_number
                }
            }
            
        }
        
    }
}
