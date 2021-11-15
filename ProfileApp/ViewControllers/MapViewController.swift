//
//  MapViewController.swift
//  MapViewController
//
//  Created by Сергей Корнев on 15.11.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var company: Suggestion!

    private var latitudeString: String {
        guard let latitude = company.data?.address?.data?.geo_lat else { return "0.0" }
        return latitude
    }
    
    private var longitudeString: String {
        guard let latitude = company.data?.address?.data?.geo_lon else { return "0.0" }
        return latitude
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fillingLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setLocation()
    }
    
    @IBAction func copyToClipboardButtonClick() {
        UIPasteboard.general.string = "\(latitudeString) \(longitudeString)"
    }
    
    private func fillingLabels() {
        latitudeLabel.text = latitudeString
        longitudeLabel.text = longitudeString
    }
    
    private func setLocation() {
        guard let latitudeDouble = Double(latitudeString) else { return }
        guard let longitudeDouble = Double(longitudeString) else { return }
        
        let location = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)

        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = company.data?.name?.full_with_opf
        destinationAnnotation.subtitle = company.data?.address?.value
        destinationAnnotation.coordinate = location
        mapView.addAnnotation(destinationAnnotation)
    }
    
}
