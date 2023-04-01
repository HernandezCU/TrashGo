//
//  MapViewController.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class MapViewController: UIViewController, MKMapViewDelegate {
    
    struct reply: Codable{
        let success: Int
        let error: Bool
    }
    
    var mode = ""
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var data: UILabel!
    
    
    let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(gdata[gindex].lat), longitude: CLLocationDegrees(gdata[gindex].lng))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        check()
        map.setRegion(MKCoordinateRegion(center: coord, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
        map.delegate = self
        DispatchQueue.main.async{
            self.name.text = gdata[gindex].title
            self.address.text = gdata[gindex].address
            self.data.text = gdata[gindex].date
        }
        
        addPin()
    }
    
    func check(){
        
        let parameters: Parameters = ["email": "matt@matt.com", "address": gdata[gindex].address]
        
        let request = AF.request("http://127.0.0.1:5000/check", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                                                      
        request.responseDecodable(of: reply.self) { (response) in
            print("here4")
            guard let response = response.value else {
                print("Failed")
                print(response)
                return }
            print("Success")
            // self.spinner.stopAnimating()
            
                DispatchQueue.main.async {
                    if response.error == true {
                        self.btn.isEnabled = true
                        self.btn.configuration?.title = "Claim Raid!"
                        self.mode = "raid"
                    }
                    else{
                        self.btn.isEnabled = true
                        self.mode = "away"
                    
                    }
                }
                
            }
            
            
    }
    
    private func addPin(){
        let pin  =  MKPointAnnotation()
        pin.coordinate = coord
        pin.title = gdata[gindex].title
        pin.subtitle = "A great place so lets take care of it."
        map.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
         
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(systemName: "pin.fill")?.withTintColor(.red)
        return annotationView
    }
    
    
    @IBAction func click(_ sender: Any) {
        
        if mode == "raid"{
            let parameters: Parameters = ["email": "matt@matt.com"]
            
            let request = AF.request("http://127.0.0.1:5000/finish_raid", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                                                          
            request.responseDecodable(of: reply.self) { (response) in
                print("here4")
                guard let response = response.value else {
                    print("Failed")
                    print(response)
                    return }
                print("Success")
                // self.spinner.stopAnimating()
                    
                }
        }
        else{
            
            var locManager = CLLocationManager()
            locManager.requestWhenInUseAuthorization()
            
            var currentLocation: CLLocation!

            if
               CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
               CLLocationManager.authorizationStatus() ==  .authorizedAlways
            {
                currentLocation = locManager.location
            }
            
            
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentLocation.coordinate.longitude, longitude: currentLocation.coordinate.latitude)))
            source.name = "Source"
                    
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(gdata[gindex].lat), longitude: CLLocationDegrees(gdata[gindex].lng))))
            destination.name = "Destination"
                    
            MKMapItem.openMaps(
              with: [source, destination],
              launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            )
        }
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
