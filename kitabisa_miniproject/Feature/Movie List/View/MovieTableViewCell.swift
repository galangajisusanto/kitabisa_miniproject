//
//  MovieTableViewCell.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import UIKit
import Combine

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    static let identifier = "MovieCellIdentifier"
    private var cancellable: AnyCancellable?
    
    
    var movie: MovieModel? {
        didSet {
            titleLabel.text = movie?.title
            releaseLabel.text = movie?.releaseDate
            overviewLabel.text = movie?.overview
            cancellable = loadImage(for: movie?.posterUrl ?? "").sink { [unowned self] image in self.showImage(image: image) }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        posterImage.addCorner(cornerRadius: .small, shadow: .none)
        containerView.addCorner(cornerRadius: .small, shadow: .medium)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        cancellable?.cancel()
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
