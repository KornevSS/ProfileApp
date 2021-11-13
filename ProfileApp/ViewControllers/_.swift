//
//  NewCompanyFindViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 01.03.2021.
//

import UIKit

class NewCompanyViewController: UIViewController {
    
    var delegate: NewCompanyViewControllerDelegate!
    
    @IBOutlet var companyInnTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyInnTextField.addTarget(
            self,
            action: #selector(companyInnTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    @objc private func companyInnTextFieldDidChanged() {
        guard let name = companyInnTextField.text else { return }
        addButton.isEnabled = !name.isEmpty ? true : false
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonPressed() {
        
        guard let textValue = companyInnTextField.text else { return }

        NetworkManager.shared.fetchData(with: textValue) { companies in
            if let companies = companies {
                self.delegate.newCompany(companies)
                self.companyInnTextField.textColor = .green
                self.successAlert() {
                    self.companyInnTextField.textColor = .black
                }
            } else {
                self.companyInnTextField.textColor = .red
                self.failedAlert() {
                    self.companyInnTextField.textColor = .black
                }
            }
        }
        
    }
    
}

extension NewCompanyViewController {

    private func alert(completionHandler: @escaping () -> Void, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            completionHandler()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func successAlert(completionHandler: @escaping () -> Void) {
        alert(completionHandler: completionHandler, title: "Успешная загрузка ✅", message: "Добавлено в историю поиска")
    }

    private func failedAlert(completionHandler: @escaping () -> Void) {
        alert(completionHandler: completionHandler, title: "Компания не найдена 🚫", message: "Введите корректный запрос")
    }

}
