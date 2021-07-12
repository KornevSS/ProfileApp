//
//  OrganizationDetailsViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import UIKit

class EntityDetailsViewController: UIViewController {

    @IBOutlet var entityInfoTextView: UITextView!
    var entity: Entity!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        entityInfoTextView.text = entity.description
    }

}

