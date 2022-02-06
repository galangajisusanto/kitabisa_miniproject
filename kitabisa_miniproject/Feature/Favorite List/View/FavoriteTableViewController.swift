//
//  FavoriteTableViewController.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    let injection = Injection()
    var movies = [MovieModel]()
    var favoriteViewModel: FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        bindToTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteMovies()
    }
    
    private func setupViewModel() {
        favoriteViewModel = injection.provideFavoritewModel()
    }
    
    private func bindToTableView() {
        title = "Favorite"
        let uiNib = UINib(nibName: "\(MovieTableViewCell.self)", bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    private func fetchFavoriteMovies() {
        startActivityIndicator()
        self.favoriteViewModel?.fetchFavoriteMovie { [self] result in
            switch result {
            case .success(let data):
                movies = data
                DispatchQueue.main.async {
                    tableView.reloadData()
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath)
        if let cell = reuseCell as? MovieTableViewCell {
            cell.movie = movie
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MovieDetailViewController()
        detailVC.movieId = movies[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
