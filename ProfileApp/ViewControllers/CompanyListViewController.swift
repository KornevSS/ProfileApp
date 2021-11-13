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
       searchBar.searchBarStyle = UISearchBar.Style.default
       searchBar.placeholder = "ИНН или название фирмы"
       searchBar.sizeToFit()
       searchBar.isTranslucent = false
       searchBar.delegate = self
       navigationItem.titleView = searchBar
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
        guard let companyCoordsViewController = storyboard.instantiateViewController(withIdentifier: "CompanyCoordsVC") as? CompanyDetailsViewController else { return }
        
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
