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

    @IBOutlet var tableView: UITableView!
    
    private var companyList: [Suggestion] = []
    private lazy var searchBar: UISearchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
       searchBar.searchBarStyle = UISearchBar.Style.default
       searchBar.placeholder = "ИНН или название фирмы"
       searchBar.sizeToFit()
       searchBar.isTranslucent = false
       searchBar.delegate = self
       navigationItem.titleView = searchBar
    }
    
    func newCompany(_ companies: [Suggestion]) {
        companyList.append(contentsOf: companies)
        tableView.reloadData()
    }

}

extension CompanyListViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let companyCoordsViewController = storyboard.instantiateViewController(withIdentifier: "CompanyCoordsVC") as? CompanyCoordsViewController else { return }
        
        companyCoordsViewController.company = companyList[indexPath.row]
//        entityDetailsViewController.modalPresentationStyle = .fullScreen
//        entityDetailsViewController.modalTransitionStyle = .flipHorizontal
        present(companyCoordsViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CompanyListViewController: UISearchBarDelegate {
    
    private func getListOfCompanies(with searchText: String) {
        NetworkManager.shared.fetchData(with: searchText) { [self] companies in
            guard let companies = companies else { return }
            self.companyList = companies
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        getListOfCompanies(with: textSearched)
        tableView.reloadData()
    }
    
}
