//
//  OrganizationListViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import UIKit

class OrganizationListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var organizations = ["Rick", "Morty"]
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard let organizationFindVC = segue.source as? OrganizationFindViewController else { return }
        guard let userName = organizationFindVC.organizationNameTextField.text else { return }
        organizations.append(userName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let organizationDetailsVC = segue.destination as? OrganizationDetailsViewController else { return }
        organizationDetailsVC.organizationName = sender as? String
    }

}

extension OrganizationListViewController: UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        organizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = organizations[indexPath.row]
        return cell
    }
}

extension OrganizationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = organizations[indexPath.row]
        performSegue(withIdentifier: "showOrganizationDetailsVC", sender: user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
