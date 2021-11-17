//
//  CompanyListViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import UIKit

class CompanyListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var companyList: [Suggestion] = []
    private lazy var searchBar: UISearchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        navigationItem.titleView = searchBar
    }

// MARK: - Navigation
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetailsVC" else { return }
        guard let destination = segue.destination as? CompanyDetailsViewController else { return }
        guard let selectedItemIndex = tableView.indexPathForSelectedRow?.row else { return }
        destination.company = companyList[selectedItemIndex]
    }
    
// MARK: - Private methods
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Введите ИНН или название"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
    }
    
    private func getListOfCompanies(with searchText: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(with: searchText) { [unowned self] companies in
            guard let companies = companies else { return }
            self.companyList = companies
            completion()
        }
    }

}

// MARK: - TableView

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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - SearchBar & work with keyboard

extension CompanyListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        getListOfCompanies(with: textSearched) {
            self.tableView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
