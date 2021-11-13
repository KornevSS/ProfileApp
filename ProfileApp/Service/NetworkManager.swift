//
//  NetworkManagerV2.swift
//  NetworkManagerV2
//
//  Created by Сергей Корнев on 02.08.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(with query: String, completion: @escaping ([Suggestion]?) -> Void) {

        var urlComponents = URLComponents(string: Constants.baseAPIURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "count", value: "10")
        ]
        
        guard let url = urlComponents?.url else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(Constants.contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(Constants.accept, forHTTPHeaderField: "Accept")
        request.addValue("Token " + Constants.token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(DataResponse.self, from: data)

//        print(result)
//        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//        print(json)
                                
                DispatchQueue.main.async {
                    let companies = result.suggestions
                    guard let companiesCount = companies?.count else { return }
                    print(companiesCount)
                    completion(companiesCount != 0 ? companies : nil)
                }
                
            } catch let jsonError {
                print("Ошибка получения данных:", jsonError.localizedDescription)
                completion(nil)
            }
        }.resume()
        
    }
    
}
