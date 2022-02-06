//
//  MovieRepositoryImpl.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//


class MovieRepositoryImpl: MovieRepository {
    
    let remoteDataSource: RemoteDataSource
    
    let localDataSource: LocalDataSource
    
    init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchPopularMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        remoteDataSource.fetchPopularMovie(page: page) { result in
            switch result {
            case .success(let data):
                let movies = MovieMapper.mapMovieResponseToDomain(input: data)
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUpcomingMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        remoteDataSource.fetchUpcomingMovie(page: page) { result in
            switch result {
            case .success(let data):
                let movies = MovieMapper.mapMovieResponseToDomain(input: data)
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        remoteDataSource.fetchTopRatedMovie(page: page) { result in
            switch result {
            case .success(let data):
                let movies = MovieMapper.mapMovieResponseToDomain(input: data)
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchNowPlayingMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        remoteDataSource.fetchNowPlayingMovie(page: page) { result in
            switch result {
            case .success(let data):
                let movies = MovieMapper.mapMovieResponseToDomain(input: data)
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDetailMovie(id: Int, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        remoteDataSource.fetchDetailMovie(id: id) { result in
            switch result {
            case .success(let data):
                let movie = MovieMapper.mapMovieDetailResponseToDomain(input: data)
                completion(.success(movie))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchRevieswMovie(id: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void) {
        remoteDataSource.fetchReviewMovie(id: id) { result in
            switch result {
            case .success(let data):
                let reviews = ReviewMapper.mapReviewResponseToDomain(input: data)
                completion(.success(reviews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchFavoriteMovie(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        localDataSource.fetchFavoriteMovie { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveMovie(_ movie: MovieModel, completion: @escaping () -> Void) {
        localDataSource.saveMovie(movie: movie) {
            completion()
        }
    }
    
    func deleteMovie(_ movie: MovieModel, completion: @escaping () -> Void) {
        localDataSource.deleteMovie(movie: movie) {
            completion()
        }
    }
    
    func isFavoritedMovie(_ id: Int, completion: @escaping (Bool) -> Void) {
        localDataSource.isFavoritedMovie(id) { isFavorited in
            completion(isFavorited)
        }
    }
    
}
