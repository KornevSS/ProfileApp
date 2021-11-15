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
        setupSearchBar()
        navigationItem.titleView = searchBar
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "ИНН или название фирмы"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
    }
    
    private func getListOfCompanies(with searchText: String) {
        NetworkManager.shared.fetchData(with: searchText) { [self] companies in
            guard let companies = companies else { return }
            self.companyList = companies
        }
    }

    
// MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetailsVC" else { return }
        guard let destination = segue.destination as? CompanyDetailsViewController else { return }
        guard let selectedItemIndex = tableView.indexPathForSelectedRow?.row else { return }
        destination.company = companyList[selectedItemIndex]
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        companyCoordsViewController.company = companyList[indexPath.row]
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
}

// MARK: - SearchBar

extension CompanyListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        getListOfCompanies(with: textSearched)
        tableView.reloadData()
    }
    
}


// MARK: - Alert

//extension NewCompanyViewController {
//
//    private func alert(completionHandler: @escaping () -> Void, title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default) {_ in
//            completionHandler()
//        }
//        alert.addAction(action)
//        present(alert, animated: true)
//    }
//
//    private func successAlert(completionHandler: @escaping () -> Void) {
//        alert(completionHandler: completionHandler, title: "Успешная загрузка ✅", message: "Добавлено в историю поиска")
//    }
//
//    private func failedAlert(completionHandler: @escaping () -> Void) {
//        alert(completionHandler: completionHandler, title: "Компания не найдена 🚫", message: "Введите корректный запрос")
//    }
//
//}
