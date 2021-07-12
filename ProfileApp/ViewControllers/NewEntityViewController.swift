//
//  OrganizationFindViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 01.03.2021.
//

import UIKit


class NewEntityViewController: UIViewController {
    
    var delegate: NewEntityViewControllerDelegate!
    
    @IBOutlet var entityInnTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entityInnTextField.addTarget(
            self,
            action: #selector(entityInnTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    @objc private func entityInnTextFieldDidChanged() {
        guard let name = entityInnTextField.text else { return }
        addButton.isEnabled = !name.isEmpty ? true : false
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonPressed() {
        
        guard let textValue = entityInnTextField.text else { return }
        let urlString = "https://www.rusprofile.ru/ajax.php?&query=\(textValue)&action=search"

        NetworkManager.shared.fetchData(jsonURL: urlString) { entities in
            if let entities = entities {
                self.delegate.newEntity(entities)
                self.entityInnTextField.textColor = .green
                self.successAlert() {
                    self.entityInnTextField.textColor = .black
                }
            } else {
                self.entityInnTextField.textColor = .red
                self.failedAlert() {
                    self.entityInnTextField.textColor = .black
                }
            }
        }
        
    }
    
}

extension NewEntityViewController {
    
    private func successAlert(completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "Успешная загрузка ✅",
                                      message: "Добавлено в историю поиска",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Продолжить", style: .default) {_ in
            completionHandler()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    private func failedAlert(completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "ИНН не найден 🚫",
                                      message: "Введите корректный ИНН",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Исправить", style: .default) {_ in
            completionHandler()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
