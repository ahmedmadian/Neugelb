//
//  FavouriteMovieCollectionViewCell.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import UIKit

class FavouriteMovieCollectionViewCell: MovieCollectionViewCell {
    // MARK: - MovieCollectionViewCell

    override func setupViewAppearance() {
        super.setupViewAppearance()

        thumbnailImageView.layer.cornerRadius = Constants.MOVIE_IMAGE_HEIGHT / 2
        titleLabel.textAlignment = .center
        titleLabel.font = .LABEL_SMALL
    }

    // MARK: - MovieCollectionViewCell

    override func layoutContainerViewSubviews() {
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                    constant: .paddingTiny),
            thumbnailImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor,
                                            constant: .paddingSmall),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                constant: .paddingTiny),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                 constant: -.paddingTiny),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                               constant: -.paddingTiny),
        ])
    }
}
