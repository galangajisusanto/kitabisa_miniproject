//
//  ApiServiceImpl.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//
import Foundation

class APIServicesImpl: APIServices {
    
    private let apiKey = "685879971991147e4987803351e658d4"
    private let baseURL = "https://api.themoviedb.org/3/"
    
    func get(_ url: String, parameters: [String : String], completion: @escaping (Result<Data,Error>) -> Void) {
        var components = URLComponents(string: baseURL+url)!
        components.queryItems = parameters.map{
            return  URLQueryItem(name: $0, value: $1)
        }
        components.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if let error = error {
                completion(.failure(error))
                print("ERROR: \(error.localizedDescription)")
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        task.resume()
    }
}
