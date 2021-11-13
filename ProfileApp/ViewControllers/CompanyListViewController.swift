//
//  CompanyListViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import UIKit

protocol NewCompanyViewControllerDelegate {
    func newCompany(_ companies: [Suggestion])
}

class CompanyListViewController: UIViewController, NewCompanyViewControllerDelegate {

    override func viewDidLoad() {
       searchBar.searchBarStyle = UISearchBar.Style.default
       searchBar.placeholder = "Search..."
       searchBar.sizeToFit()
       searchBar.isTranslucent = false
 //      searchBar.backgroundImage = UIImage()
       searchBar.delegate = self
       navigationItem.titleView = searchBar
    }
    
    func newCompany(_ companies: [Suggestion]) {
        companyList.append(contentsOf: companies)
        tableView.reloadData()
    }
    

    @IBOutlet var tableView: UITableView!
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    var companyList: [Suggestion] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newCompanyVC = segue.destination as! NewCompanyViewController
        newCompanyVC.delegate = self
    }
    
}

extension CompanyListViewController: UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
        var content = cell.defaultContentConfiguration()
        content.text = "\(companyList[indexPath.row].value ?? "") \(companyList[indexPath.row].data?.inn ?? "")"
        content.secondaryText = companyList[indexPath.row].data?.management?.name
        cell.contentConfiguration = content

        return cell
    }
}

extension CompanyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let companyDetailsViewController = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsVC") as? CompanyDetailsViewController else { return }
        
        companyDetailsViewController.company = companyList[indexPath.row]
//        entityDetailsViewController.modalPresentationStyle = .fullScreen
//        entityDetailsViewController.modalTransitionStyle = .flipHorizontal
        present(companyDetailsViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CompanyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
        NetworkManager.shared.fetchData(with: textSearched) { [self] companies in
            guard let companies = companies else { return }
            self.companyList = companies
        }
        
        tableView.reloadData()
    }
}
