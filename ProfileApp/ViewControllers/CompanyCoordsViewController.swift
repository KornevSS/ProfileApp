//
//  CompanyCoordsViewController.swift
//  CompanyCoordsViewController
//
//  Created by Сергей Корнев on 13.11.2021.
//

import UIKit
import MapKit

class CompanyCoordsViewController: UIViewController {

    @IBOutlet var companyCoordinates: MKMapView!
    var company: Suggestion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        position()
    }

    private func position() {
        guard let latitude = Double(company.data?.address?.data?.geo_lat ?? "0.0") else { return }
        guard let longitude = Double(company.data?.address?.data?.geo_lon ?? "0.0") else { return }
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        
        companyCoordinates.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = company.data?.name?.full_with_opf
        annotation.subtitle = company.data?.address?.value
        annotation.coordinate = location
        companyCoordinates.addAnnotation(annotation)
    }
}
