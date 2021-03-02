//
//  OrganizationFindViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 01.03.2021.
//

import UIKit


class OrganizationFindViewController: UIViewController {
    
    @IBOutlet var organizationNameTextField: UITextField!
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    deinit {
        print("ContactManagerViewController has been dealocated")
    }
}

