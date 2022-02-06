//
//  FavoriteViewModel.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

class FavoriteViewModel {
    private let repository: MovieRepository
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func fetchFavoriteMovie(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        self.repository.fetchFavoriteMovie { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
