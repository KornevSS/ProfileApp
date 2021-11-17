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
        guard let latitude = company.data?.address?.data?.geoLatitude else { return "0.0" }
        return latitude
    }
    
    private var longitudeString: String {
        guard let longitude = company.data?.address?.data?.geoLongitude else { return "0.0" }
        return longitude
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
        copeToClipboardSuccessAlert {
            UIPasteboard.general.string = "\(self.latitudeString) \(self.longitudeString)"
        }
    }
    
    @IBAction func openAppleMaps() {
        openInAppleMaps()
    }
    
    private func setLocation() {
        initMap { location, region in
            let destinationTitle = self.company.data?.name?.fullWithOpf
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
            mapItem.name = self.company.data?.name?.fullWithOpf
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

// MARK: - Alert

extension MapViewController {

    private func alert(completionHandler: @escaping () -> Void, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            completionHandler()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func copeToClipboardSuccessAlert(completionHandler: @escaping () -> Void) {
        alert(completionHandler: completionHandler, title: "Буфер обмена", message: "Координаты скопированы ✅")
    }

}
