//
//  MovieDetailViewController.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import UIKit
import Combine

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var reviewCollection: UICollectionView!
    var favoriteButton: UIBarButtonItem?
    var unfavoriteButton: UIBarButtonItem?
    
    var movieId: Int?
    var movie: MovieModel?
    let injection = Injection()
    var detailViewModel: DetailViewModel?
    private var cancellable: AnyCancellable?
    var reviews = [ReviewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupnavigation()
        setupCollectionView()
        fetchDetailMovies()
        fetchReviewMovie()
    }
    
    private func setupViewModel() {
        detailViewModel = injection.provideDetailViewModel()
    }
    
    private func setupnavigation() {
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain,
                                         target: self, action: #selector(favoriteTapped))
        unfavoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain,
                                           target: self, action: #selector(unfavoriteTapped))
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let width = (reviewCollection.bounds.width - 100)
        let height = 120.0
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let size = CGSize(width: width, height: height)
        layout.itemSize = size
        layout.scrollDirection = .horizontal
        reviewCollection.setCollectionViewLayout(layout, animated: true)
        reviewCollection.register(UINib(nibName: "\(ReviewCollectionViewCell.self )", bundle: nil), forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
        reviewCollection.dataSource = self
    }
    
    
    private func setMovieIntoUI(movie: MovieModel) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate
    }
    
    
    private func fetchDetailMovies() {
        guard let movieId = movieId else {
            return
        }
        
        startActivityIndicator()
        self.detailViewModel?.fetchDetailMovie(id: movieId) { [self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    stopActivityIndicator()
                }
                movie = data
                cancellable = loadImage(for: data.posterUrl).sink { [unowned self] image in self.showImage(image: image) }
                setMovieIntoUI(movie: data)
                checkIsFavorited(id: data.id)
            case .failure(let error):
                DispatchQueue.main.async {
                    stopActivityIndicator()
                    showAllert(title: "Error", subtitle: error.localizedDescription)
                }
                
            }
        }
    }
    
    private func fetchReviewMovie() {
        guard let movieId = movieId else {
            return
        }
        self.detailViewModel?.fetchReviewsMovie(id: movieId) {  [self] result in
            switch result {
            case .success(let data):
                reviews = data
                reviewCollection.reloadData()
            case .failure(let error):
                DispatchQueue.main.async {
                    showAllert(title: "Error", subtitle: error.localizedDescription)
                }
            }
        }
    }
    
    private func checkIsFavorited(id: Int) {
        
        detailViewModel?.isMovieFavorited(id) { isFavorited in
            DispatchQueue.main.async {
                if isFavorited {
                    self.navigationItem.setRightBarButton( self.unfavoriteButton, animated: true)
                } else {
                    self.navigationItem.setRightBarButton( self.favoriteButton, animated: true)
                }
            }
        }
        
    }
    
    @objc func favoriteTapped() {
        guard let movie = movie else {return}
        detailViewModel?.saveMovie(movie) {
            DispatchQueue.main.async {
                self.navigationItem.setRightBarButton( self.unfavoriteButton, animated: true)
            }
        }
    }
    @objc func unfavoriteTapped() {
        guard let movie = movie else {return}
        detailViewModel?.deleteMovie(movie) {
            DispatchQueue.main.async {
                self.navigationItem.setRightBarButton( self.favoriteButton, animated: true)
            }
        }
    }
    
    private func showImage(image: UIImage?) {
        posterImage.image = image
    }
    
    private func loadImage(for image: String) -> AnyPublisher<UIImage?, Never> {
        return Just(image)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: image)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let review = reviews[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell {
            cell.review = review
            return cell
        }
        return UICollectionViewCell()
    }
}
