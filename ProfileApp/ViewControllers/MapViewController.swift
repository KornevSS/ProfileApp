//
//  MapViewController.swift
//  MapViewController
//
//  Created by Сергей Корнев on 15.11.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    var company: Suggestion!
    
    func route(firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPosition()
    }
    
    private func setPosition() {
        guard let latitude = Double(company.data?.address?.data?.geo_lat ?? "") else { return }
        guard let longitude = Double(company.data?.address?.data?.geo_lon ?? "") else { return }
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = company.data?.name?.full_with_opf
        annotation.subtitle = company.data?.address?.value
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
}
