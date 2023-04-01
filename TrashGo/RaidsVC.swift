//
//  RaidsVC.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit
import MapKit

var logged_in = false

class RaidsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    
    struct event{
        let icon: String
        let title: String
        let date: String
        let address: String
        
    }
    
    let data: [event] = [
        event(icon: "tree.circle.fill", title: "Park Cleanup", date: "4/01/2023", address: "9123 S Park Way, Siloam Springs, AR, 72761"),
        event(icon: "signpost.right.and.left.circle.fill", title: "Clean up the Trails", date: "4/19/2023", address: "911 S Washington St, Siloam Springs, AR, 72761")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        if !logged_in{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "login", sender: nil)
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
