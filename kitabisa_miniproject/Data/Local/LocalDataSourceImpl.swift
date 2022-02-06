//
//  LocalDataSourceImpl.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

class LocalDataSourceImpl: LocalDataSource {
    
    private let coreDataProvider: CoreDataProvider
    init(coreDataProvider: CoreDataProvider) {
        self.coreDataProvider = coreDataProvider
    }
    
    func fetchFavoriteMovie(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        coreDataProvider.getFavoriteMovies { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func saveMovie(movie: MovieModel, completion: @escaping () -> Void) {
        coreDataProvider.addMovie(movie) {
            completion()
        }
    }
    
    func deleteMovie(movie: MovieModel, completion: @escaping () -> Void) {
        coreDataProvider.deleteMovie(movie.id) {
            completion()
        }
    }
    
    func isFavoritedMovie(_ id: Int, completion: @escaping (Bool) -> Void) {
        coreDataProvider.isFavoritedMovie(id) { isFavorited in
            completion(isFavorited)
        }
    }
}
