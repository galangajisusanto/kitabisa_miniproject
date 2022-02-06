//
//  DetailViewModel.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

class DetailViewModel {
    private let repository: MovieRepository
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func fetchDetailMovie(id: Int, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        self.repository.fetchDetailMovie(id: id){ result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchReviewsMovie(id: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void) {
        self.repository.fetchRevieswMovie(id: id) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func saveMovie(_ movie: MovieModel, completion: @escaping() -> Void) {
        self.repository.saveMovie(movie) {
            completion()
        }
    }
    func deleteMovie(_ movie: MovieModel, completion: @escaping() -> Void) {
        self.repository.deleteMovie(movie){
            completion()
        }
    }
    func isMovieFavorited(_ id: Int, completion: @escaping(_ isFavorite: Bool) -> Void) {
        self.repository.isFavoritedMovie(id){ isFavorited in
            completion(isFavorited)
        }
    }
}
