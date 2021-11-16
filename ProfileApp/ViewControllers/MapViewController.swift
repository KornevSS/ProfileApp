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
        openInAppleMaps()
    }
    
    private func setLocation() {
        initMap { location, region in
            let destinationTitle = self.company.data?.name?.full_with_opf
            let destinationSubTitle = self.company.data?.address?.value
            self.mapView.setRegion(region, animated: true)
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.title = destinationTitle
            destinationAnnotation.subtitle = destinationSubTitle
            destinationAnnotation.coordinate = location
            self.mapView.addAnnotation(destinationAnnotation)
        }
    }
    
    private func openInAppleMaps() {
        initMap { location, region in
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)
            ]
            let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = self.company.data?.name?.full_with_opf
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    private func initMap(completion: @escaping (CLLocationCoordinate2D, MKCoordinateRegion) -> Void) {
        guard let latitudeDouble = Double(latitudeString) else { return }
        guard let longitudeDouble = Double(longitudeString) else { return }
        let location = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        completion(location, region)
    }
    
    private func fillingLabels() {
        latitudeLabel.text = latitudeString
        longitudeLabel.text = longitudeString
    }
    
}
