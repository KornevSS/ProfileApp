//
//  NetworkManager.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(jsonURL: String, _ completion: @escaping ([Entity]?) -> Void) {
        
        guard let url = URL(string: jsonURL) else { return }
                
        URLSession.shared.dataTask(with: url) { (data, _, error) in
       
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let webSiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)

                DispatchQueue.main.async {
                    let entities = webSiteDescription.ul
                    completion(entities)
                }
                
            } catch let jsonError {
                print("Ошибка получения данных:", jsonError)
            }
        }.resume()
    }
    
}
