//
//  ReviewCollectionViewCell.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    static let identifier = "ReviewCellIdentifier"
    
    var review: ReviewModel? {
        didSet {
            authorLabel.text = review?.author
            contentLabel.text = review?.content
            dateLabel.text = review?.date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addCorner(cornerRadius: .small, shadow: .medium)
    }

}
