//
//  OrganizationListViewController.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import UIKit

protocol NewEntityViewControllerDelegate {
    func newEntity(_ entities: [Entity])
}

class EntityListViewController: UIViewController, NewEntityViewControllerDelegate {
   
    func newEntity(_ entities: [Entity]) {
        entityList.append(contentsOf: entities)
        tableView.reloadData()
    }
    

    @IBOutlet var tableView: UITableView!
    
    var entityList: [Entity] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newEntityVC = segue.destination as! NewEntityViewController
        newEntityVC.delegate = self
    }
    
}

extension EntityListViewController: UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
        var content = cell.defaultContentConfiguration()
        content.text = entityList[indexPath.row].name
        content.secondaryText = entityList[indexPath.row].formattedINN
        
        cell.contentConfiguration = content

        return cell
    }
}

extension EntityListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let entityDetailsViewController = storyboard.instantiateViewController(identifier: "EntityDetailsVC") as? EntityDetailsViewController else { return }
        
        entityDetailsViewController.entity = entityList[indexPath.row]
//        entityDetailsViewController.modalPresentationStyle = .fullScreen
        entityDetailsViewController.modalTransitionStyle = .flipHorizontal
        present(entityDetailsViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
