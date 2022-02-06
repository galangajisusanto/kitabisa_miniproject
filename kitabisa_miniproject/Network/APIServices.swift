//
//  APIService.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

protocol APIServices {
    func get(_ url: String, parameters: [String: String], completion: @escaping (Result<Data, Error>) -> Void)
}
