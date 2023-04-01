//
//  RaidsVC.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit
import MapKit
import Alamofire
import NotificationBannerSwift

var logged_in = false

class RaidsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    struct event{
        let icon: String
        let title: String
        let date: String
        let address: String
        
    }
    struct user: Codable{
        let user: me
    }
    struct me: Codable{
        let email : String
        let name : String
        let password : String
        let ping : String
        let points : Int
        let raids : Int
        let username : String
        let zip : String
    }
    
    struct nplaces: Codable{
        let places: [place]
    }
    
    struct place: Codable{
        let address: String
        let location: latlong
        let name: String
        let type: String
    }
    
    struct latlong: Codable{
        let lat: Float
        let lng: Float
    }
    
    var data: [event] = [] /*= [
        event(icon: "tree.circle.fill", title: "Park Cleanup", date: "4/01/2023", address: "9123 S Park Way, Siloam Springs, AR, 72761"),
        event(icon: "signpost.right.and.left.circle.fill", title: "Clean up the Trails", date: "4/19/2023", address: "911 S Washington St, Siloam Springs, AR, 72761")]
    */
    
    var key: String = ""
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        fetch_me()
        print(key)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        if !logged_in{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }else{
            key = user_key
            fetch_me()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !logged_in{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }else{
            key = user_key
            fetch_me()
        }
    }
    
    func fetch_me(){
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        let parameters: Parameters = [
            "email": "matt@matt.com"
        ]

        AF.request("https://greencitygo.net/me", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                if let dictionary = data as? [String: Any],
                let user = dictionary["user"] as? [String: Any] {
                    print(user) // Access the 'user' dictionary
                    if let zip = user["zip"] as? String {
                        self.fetch_data(zip: String(zip))
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetch_data(zip: String){
        let parameters: Parameters = ["zip_code": zip]
        
        let request = AF.request("http://127.0.0.1:5000/search", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                                                      
        request.responseDecodable(of: nplaces.self) { (response) in
            print("here4")
            guard let response = response.value else {
                print("Failed")
                print(response)
                return }
            print("Success")
            self.spinner.stopAnimating()
            
                DispatchQueue.main.async {
                    self.data.removeAll()
                    for i in response.places{
                        var icn = ""
                        if i.type == "park"{
                            var icn = "tree.circle.fill"
                        }else{
                            var icn = "signpost.right.and.left.circle.fill"
                        }
                        self.data.append(event(icon: icn, title: i.name, date: Date().formatted(), address: i.address))
                        
                    }
                    
                    self.table.reloadData()//                        self.key_label.text = user.user.key
//                        self.email_label.text = user.user.email
//                        self.name_label.text = user.user.name
//                        self.password_label.text = user.user.password
//                        self.phone_label.text = user.user.phone_number
                }
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TV_Cell
        let d  = data[indexPath.row]
        
        cell.title.text = d.title
        cell.date.text = d.date
        cell.address.text = d.address
        cell.icon.image = UIImage(systemName: d.icon)
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}
extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
