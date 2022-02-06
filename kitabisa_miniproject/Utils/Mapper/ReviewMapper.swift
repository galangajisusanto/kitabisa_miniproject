//
//  ReviewMapper.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

final class ReviewMapper {
    
    static func mapReviewResponseToDomain(
        input reviews: [Review]
    ) -> [ReviewModel] {
        return reviews.map { result in
            return ReviewModel(author: result.author, date: result.updatedAt.toDateTimeFormat(), content: result.content)
        }
    }
}
