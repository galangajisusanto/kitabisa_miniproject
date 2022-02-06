//
//  MovieRepository.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

protocol MovieRepository {
    // ~ API
    func fetchPopularMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func fetchUpcomingMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func fetchTopRatedMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func fetchNowPlayingMovie(page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func fetchDetailMovie(id: Int, completion: @escaping (Result<MovieModel, Error>) -> Void)
    func fetchRevieswMovie(id: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void)
    
    // ~ CoreData
    func fetchFavoriteMovie(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func saveMovie(_ movie: MovieModel, completion: @escaping() -> Void)
    func deleteMovie(_ movie: MovieModel, completion: @escaping() -> Void)
    func isFavoritedMovie(_ id: Int, completion: @escaping(_ isFavorite: Bool) -> Void)
}
