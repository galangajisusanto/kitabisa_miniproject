//
//  RemoteDataSource.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

protocol RemoteDataSource {
    func fetchPopularMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchUpcomingMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchTopRatedMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchNowPlayingMovie(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchDetailMovie(id: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
    func fetchReviewMovie(id: Int, completion: @escaping (Result<[Review], Error>) -> Void)
}
