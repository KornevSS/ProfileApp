//
//  CompanyCoordsViewController.swift
//  CompanyCoordsViewController
//
//  Created by Сергей Корнев on 13.11.2021.
//

import UIKit

class CompanyDetailsViewController: UIViewController {

    @IBOutlet var companyInfoTextView: UITextView!
    
    var company: Suggestion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = company.data?.description else { return }
        companyInfoTextView.text = data
    }
    
 
// MARK: - Navigation
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showMapVC" else { return }
        guard let destination = segue.destination as? MapViewController else { return }
        destination.company = company
    }
    
}


