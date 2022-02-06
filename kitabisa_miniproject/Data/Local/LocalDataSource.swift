//
//  LocalDataSource.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

protocol LocalDataSource {
    //: ~ favorite
    func fetchFavoriteMovie(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func saveMovie(movie: MovieModel, completion: @escaping() -> Void)
    func deleteMovie(movie: MovieModel, completion: @escaping() -> Void)
    func isFavoritedMovie(_ id: Int, completion: @escaping(_ isFavorite: Bool) -> Void)
}
