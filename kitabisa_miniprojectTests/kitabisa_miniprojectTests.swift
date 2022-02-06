//
//  kitabisa_miniprojectTests.swift
//  kitabisa_miniprojectTests
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import XCTest
@testable import kitabisa_miniproject

class kitabisa_miniprojectTests: XCTestCase {
    
    var remoteDataSource: RemoteDataSource?
    var localDataSource: LocalDataSource?
    var reviews: [Review]?
    var popularMovie: [Movie]?
    var nowPlayingMovie: [Movie]?
    var topRatedMovie: [Movie]?
    var upcommingMovie: [Movie]?
    var detailMovie: MovieDetailResponse?
    var favoriteMovies: [MovieModel]?
    var isSaveSuccess = false
    var isDeleteSuccess = false
    var checkFavorite: Bool?
    
    
    override func setUpWithError() throws {
        remoteDataSource = RemoteDataSourceImpl(apiServices: APIServicesImpl())
        localDataSource = LocalDataSourceImpl(coreDataProvider: CoreDataProvider())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConvertDateTime() throws {
        let date = "2022-01-07T05:17:55.010Z"
        let dateString = "07 Januari 2022"
        let dateStringResult = date.toDateTimeFormat()
        XCTAssertEqual(dateString, dateStringResult)
    }
    
    func testConvertDate() throws {
        let date = "2021-02-02"
        let dateString = "02 Februari 2021"
        let dateStringResult = date.toDateFormat()
        XCTAssertEqual(dateString, dateStringResult)
    }
    
    func testMapReviewToDomain() throws {
        let reviewsResponse = [
            Review(author: "Galang Aji",
                   authorDetails: AuthorDetails(name: "Galang Aji", username: "galang_as", avatarPath: nil, rating: nil),
                   content: "Waw bagus banget",
                   createdAt: "2022-01-07T05:17:55.010Z",
                   id: "12112",
                   updatedAt: "2022-01-07T05:17:55.010Z",
                   url: "url"
                  )
        ]
        
        let reviewsResult = ReviewMapper.mapReviewResponseToDomain(input: reviewsResponse)
        
        let reviewResultExpetation = [
            ReviewModel(author: "Galang Aji", date: "07 Januari 2022", content: "Waw bagus banget")
        ]
        
        XCTAssertNotEqual(reviewsResult, [])
        XCTAssertEqual(reviewsResult, reviewResultExpetation)
    }
    
    func testMapDetailToDomain() throws {
        let detailResponse = MovieDetailResponse(adult: true, backdropPath: "backdropString", budget: 10000, genres: [], homepage: "homepage", id: 1234, imdbID: "121212", originalLanguage: "US", originalTitle: "Spiderman No Way Home", overview: "Takut spoiler ahhh", popularity: 100.0, posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", productionCompanies: nil, productionCountries: nil, releaseDate: "2022-01-07", revenue: 1000000, runtime: 1, spokenLanguages: nil, status: "status", tagline: "tagline", title: "Spiderman no way home", video: true, voteAverage: 4.5, voteCount: 10)
        
        let movieDetailResult = MovieMapper.mapMovieDetailResponseToDomain(input: detailResponse)
        let movieDetailExpetation = MovieModel(id: 1234, releaseDate: "07 Januari 2022", title: "Spiderman No Way Home", overview: "Takut spoiler ahhh", posterUrl: "https://image.tmdb.org/t/p/w500//1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
        XCTAssertEqual(movieDetailResult, movieDetailExpetation)
    }
    
    func testMapMovieToDomain() throws {
        let movieResponse = [
            Movie(adult: true, backdropPath: "backdropPath", genreIDS: [], id: 1234, originalLanguage: "US", originalTitle: "Spiderman No Way Home", overview: "Helikoper helikopter", popularity: 2.0, posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", releaseDate: "2022-01-07", title: "Spiderman", video: true, voteAverage: 10.0, voteCount: 10),
            Movie(adult: true, backdropPath: "backdropPath", genreIDS: [], id: 234, originalLanguage: "US", originalTitle: "The Ethernal", overview: "Ethernal is ethernal", popularity: 2.0, posterPath: "/1g0dhYtq4irTY1GPXvasaft6k4YLjmddd.jpg", releaseDate: "2022-02-08", title: "Ethernal", video: true, voteAverage: 10.0, voteCount: 10)
        ]
        
        let movieResult = MovieMapper.mapMovieResponseToDomain(input: movieResponse)
        let movieExpetation = [
            MovieModel(id: 1234, releaseDate: "07 Januari 2022", title: "Spiderman No Way Home", overview: "Helikoper helikopter", posterUrl: "https://image.tmdb.org/t/p/w500//1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"),
            MovieModel(id: 234, releaseDate: "08 Februari 2022", title: "The Ethernal", overview: "Ethernal is ethernal", posterUrl: "https://image.tmdb.org/t/p/w500//1g0dhYtq4irTY1GPXvasaft6k4YLjmddd.jpg"),
        ]
        XCTAssertEqual(movieResult, movieExpetation)
        XCTAssertNotEqual([], movieExpetation)
    }
    
    func testFetchReview() throws {
        let expectation = self.expectation(description: "review")
        remoteDataSource?.fetchReviewMovie(id: 634649) { [self] result in
            switch result {
            case .success(let data):
                self.reviews = data
                XCTAssertNotNil(reviews)
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(reviews)
    }
    
    func testPopularMovie() throws {
        let expectation = self.expectation(description: "popularmovie")
        remoteDataSource?.fetchPopularMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                self.popularMovie = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(popularMovie)
    }
    
    func testFetchNowPlayingMovie() throws {
        let expectation = self.expectation(description: "nowplayingmovie")
        remoteDataSource?.fetchNowPlayingMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                self.nowPlayingMovie = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(nowPlayingMovie)
    }
    
    func testFetchTopRatedMovie() throws {
        let expectation = self.expectation(description: "toprated")
        remoteDataSource?.fetchTopRatedMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                self.topRatedMovie = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(topRatedMovie)
    }
    
    func testFetchUpcommingdMovie() throws {
        let expectation = self.expectation(description: "upcommingmovie")
        remoteDataSource?.fetchUpcomingMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                self.upcommingMovie = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 8, handler: nil)
        XCTAssertNotNil(upcommingMovie)
    }
    
    func testFetchDetailMovie() throws {
        let expectation = self.expectation(description: "detailmovie")
        
        remoteDataSource?.fetchDetailMovie(id: 634649) { [self] result in
            switch result {
            case .success(let data):
                self.detailMovie = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(detailMovie)
    }
    
    func testFetchFavoriteMovie() throws {
        let expectation = self.expectation(description: "favoritemovie")
        
        localDataSource?.fetchFavoriteMovie { [self] result in
            switch result {
            case .success(let data):
                self.favoriteMovies = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(favoriteMovies)
    }
    
    func testCheckFavoritedMovie() throws {
        let expectation = self.expectation(description: "favoritedmovie")
        
        localDataSource?.isFavoritedMovie(634649) { [self] result in
            self.checkFavorite = result
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(checkFavorite)
    }
    
    func testSaveMovie() throws {
        let expectation = self.expectation(description: "savemovie")
        
        let movie = MovieModel(id: 1234, releaseDate: "07 Januari 2022", title: "Spiderman No Way Home", overview: "Takut spoiler ahhh", posterUrl: "https://image.tmdb.org/t/p/w500//1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
        
        localDataSource?.saveMovie(movie: movie) {
            self.isSaveSuccess = true
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(isSaveSuccess)
    }
    
    func testDeleteMovie() throws {
        let expectation = self.expectation(description: "deleteMovie")
        
        let movie = MovieModel(id: 1234, releaseDate: "07 Januari 2022", title: "Spiderman No Way Home", overview: "Takut spoiler ahhh", posterUrl: "https://image.tmdb.org/t/p/w500//1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
        
        localDataSource?.deleteMovie(movie: movie) {
            self.isDeleteSuccess = true
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(isDeleteSuccess)
    }
}
