//
//  MapViewController.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var data: UILabel!
    
    
    let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(gdata[gindex].lat), longitude: CLLocationDegrees(gdata[gindex].lng))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.setRegion(MKCoordinateRegion(center: coord, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
        map.delegate = self
        DispatchQueue.main.async{
            self.name.text = gdata[gindex].title
            self.address.text = gdata[gindex].address
            self.data.text = gdata[gindex].date
        }
        
        addPin()


    }
    
    
    private func addPin(){
        let pin  =  MKPointAnnotation()
        pin.coordinate = coord
        pin.title = "Park"
        pin.subtitle = "Clean it"
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
