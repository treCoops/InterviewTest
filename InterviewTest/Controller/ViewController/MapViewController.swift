//
//  MapViewController.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var mapData = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let lat = (self.mapData["latitude"]! as! NSString).doubleValue
        let long = (self.mapData["longitude"]! as! NSString).doubleValue
        
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        mapView.setCenter(coordinates, animated: true)
        
        addMarker(title: self.mapData["title"]! as! String, address: self.mapData["address"]! as! String, coordinates: coordinates)

    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addMarker(title: String, address: String, coordinates: CLLocationCoordinate2D){
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = address
        annotation.coordinate = coordinates
        
        mapView.addAnnotation(annotation)
        
    }
}
