//
//  MovieViewModel.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

class MovieViewModel {
    private let repository: MovieRepository
    init(repository: MovieRepository) {
        self.repository = repository
    }
    func fetchPopularMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        self.repository.fetchPopularMovie(page: page){ result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchUpcomingMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        self.repository.fetchUpcomingMovie(page: page){ result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        self.repository.fetchTopRatedMovie(page: page){ result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchNowPlayingMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        self.repository.fetchNowPlayingMovie(page: page){ result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
}
