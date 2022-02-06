//
//  MovieMapper.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

final class MovieMapper {
    
    static func mapMovieResponseToDomain(
        input movies: [Movie]
    ) -> [MovieModel] {
        return movies.map { result in
            
            let posterUrl = "https://image.tmdb.org/t/p/w500/\(result.posterPath)"
            return MovieModel(
                id: result.id,
                releaseDate: result.releaseDate.toDateFormat(),
                title: result.originalTitle,
                overview: result.overview,
                posterUrl: posterUrl
            )
        }
    }
    
    static func mapMovieDetailResponseToDomain(
        input movie: MovieDetailResponse
    ) -> MovieModel {
        let posterUrl = "https://image.tmdb.org/t/p/w500/\(movie.posterPath)"
        return MovieModel(
            id: movie.id,
            releaseDate: movie.releaseDate.toDateFormat(),
            title: movie.originalTitle,
            overview: movie.overview,
            posterUrl: posterUrl
        )
    }
    
}

