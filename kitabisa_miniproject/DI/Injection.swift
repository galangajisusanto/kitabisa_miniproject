//
//  Injection.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

final class Injection: NSObject {
    
    private func provideAPIServices() -> APIServices {
        return APIServicesImpl()
    }
    
    private func provideRemoteDataSource() -> RemoteDataSource {
        return RemoteDataSourceImpl(apiServices: provideAPIServices())
    }
    
    private func provideLocalDataSource() -> LocalDataSource {
        return LocalDataSourceImpl(coreDataProvider: CoreDataProvider())
    }
    
    private func provideMovieRepository() -> MovieRepository {
        return  MovieRepositoryImpl(
            remoteDataSource: provideRemoteDataSource(),
            localDataSource: provideLocalDataSource()
        )
    }
    
    func provideMovieViewModel() -> MovieViewModel {
        return  MovieViewModel(repository: provideMovieRepository())
    }
    
    func provideDetailViewModel() -> DetailViewModel {
        return  DetailViewModel(repository: provideMovieRepository())
    }
    
    func provideFavoritewModel() -> FavoriteViewModel {
        return  FavoriteViewModel(repository: provideMovieRepository())
    }
}
