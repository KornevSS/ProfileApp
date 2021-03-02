//
//  OrganizationDetailsViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import UIKit

class OrganizationDetailsViewController: UIViewController {

    @IBOutlet var organizationNameLabel: UILabel!
    
    var organizationName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        organizationNameLabel.text = organizationName
    }

}
