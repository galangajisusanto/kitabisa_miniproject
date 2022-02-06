//
//  MovieViewController.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var movieTable: UITableView!
    
    let injection = Injection()
    var movies = [MovieModel]()
    var movieViewModel: MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupNavigation()
        bindToTableView()
        fetchPopularMovies()
    }
    
    private func setupNavigation() {
        title = "The Movielytic"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteTapped))
    }
    
    @objc func favoriteTapped() {
        let favoriteVC = FavoriteTableViewController()
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    private func setupViewModel() {
        movieViewModel = injection.provideMovieViewModel()
    }
    
    private func bindToTableView() {
        movieTable.delegate = self
        movieTable.dataSource = self
        let uiNib = UINib(nibName: "\(MovieTableViewCell.self)", bundle: nil)
        movieTable.register(uiNib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    private func fetchPopularMovies() {
        startActivityIndicator()
        self.movieViewModel?.fetchPopularMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                movies = data
                DispatchQueue.main.async {
                    movieTable.reloadData()
                    stopActivityIndicator()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    stopActivityIndicator()
                    showAllert(title: "Error", subtitle: error.localizedDescription)
                }
                
            }
        }
    }
    
    private func fetchUpcomingMovies() {
        startActivityIndicator()
        self.movieViewModel?.fetchUpcomingMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                movies = data
                DispatchQueue.main.async {
                    movieTable.reloadData()
                    stopActivityIndicator()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    stopActivityIndicator()
                    showAllert(title: "Error", subtitle: error.localizedDescription)
                }
                
            }
        }
    }
    
    private func fetchTopRatedMovies() {
        startActivityIndicator()
        self.movieViewModel?.fetchTopRatedMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                movies = data
                DispatchQueue.main.async {
                    movieTable.reloadData()
                    stopActivityIndicator()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    stopActivityIndicator()
                    showAllert(title: "Error", subtitle: error.localizedDescription)
                }
                
            }
        }
    }
    
    private func fetchNowPlayingMovies() {
        startActivityIndicator()
        self.movieViewModel?.fetchNowPlayingMovie(page: 1) { [self] result in
            switch result {
            case .success(let data):
                movies = data
                DispatchQueue.main.async {
                    movieTable.reloadData()
                    stopActivityIndicator()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    stopActivityIndicator()
                    showAllert(title: "Error", subtitle: error.localizedDescription)
                }
                
            }
        }
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Category", preferredStyle: .actionSheet)
        
        let popularAction = UIAlertAction(title: "Popular", style: .default, handler:{ [self] _ in
            fetchPopularMovies()
        })
        let upcomingAction = UIAlertAction(title: "Upcoming", style: .default, handler:{ _ in
            self.fetchUpcomingMovies()
        })
        let topRatedAction = UIAlertAction(title: "Top Rated", style: .default, handler:{ _ in
            self.fetchTopRatedMovies()
        })
        let nowPlayingAction = UIAlertAction(title: "Now Playing", style: .default, handler:{ _ in
            self.fetchNowPlayingMovies()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(popularAction)
        optionMenu.addAction(upcomingAction)
        optionMenu.addAction(topRatedAction)
        optionMenu.addAction(nowPlayingAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath)
        if let cell = reuseCell as? MovieTableViewCell {
            cell.movie = movie
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MovieDetailViewController()
        detailVC.movieId = movies[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
