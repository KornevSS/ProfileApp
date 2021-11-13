//
//  CompanyDetailsViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import UIKit

class CompanyDetailsViewController: UIViewController {

    @IBOutlet var companyInfoTextView: UITextView!
    var company: Suggestion!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        companyInfoTextView.text = company.data?.name?.short_with_opf
    }

}

