//
//  RemoteDataSourceImpl.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

class RemoteDataSourceImpl: RemoteDataSource {
    
    let apiServices: APIServices
    
    init(apiServices: APIServices) {
        self.apiServices = apiServices
    }
    
    func fetchPopularMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        self.apiServices.get("movie/popular", parameters: ["page": "\(page)"]){ result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(jsonData.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchUpcomingMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        self.apiServices.get("movie/upcoming", parameters: ["page": "\(page)"]){ result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(jsonData.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        self.apiServices.get("movie/top_rated", parameters: ["page": "\(page)"]){ result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(jsonData.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchNowPlayingMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        self.apiServices.get("movie/now_playing", parameters: ["page": "\(page)"]){ result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(jsonData.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchDetailMovie(id: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        self.apiServices.get("movie/\(id)", parameters: [:]){ result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchReviewMovie(id: Int, completion: @escaping (Result<[Review], Error>) -> Void) {
        self.apiServices.get("/movie/\(id)/reviews", parameters: [:]){ result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(ReviewResponse.self, from: data)
                    completion(.success(jsonData.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error))
            }
        }
    }
}
