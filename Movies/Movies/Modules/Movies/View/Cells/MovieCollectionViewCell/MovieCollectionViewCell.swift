//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let MOVIE_IMAGE_HEIGHT: CGFloat = 75
        static let MOVIE_IMAGE_WIDTH: CGFloat = MOVIE_IMAGE_HEIGHT
        static let CONTAINER_VIEW_BORDER_WIDTH: CGFloat = 1
    }

    // MARK: - Views

    private(set) lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = .mediumCornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .LABEL
        label.textColor = UIColor.Neugelb.Text.TEXT_PRIMARY
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private(set) lazy var containerView: UIView = {
        let view = UIView()
        // check
        view.layer.borderWidth = Constants.CONTAINER_VIEW_BORDER_WIDTH
        view.backgroundColor = UIColor.Neugelb.Background.SURFACE
        view.layer.cornerRadius = .cornerRadius
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViewAppearance()
        setupViewLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View

    func setupViewAppearance() {
        contentView.backgroundColor = UIColor.Neugelb.Background.PRIMARY
    }

    func setupViewLayout() {
        contentView.addSubview(containerView, translatesAutoresizingMaskIntoConstraints: false)
        
        [thumbnailImageView, titleLabel].forEach {
            containerView.addSubview($0, translatesAutoresizingMaskIntoConstraints: false)
        }

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            thumbnailImageView.widthAnchor.constraint(equalToConstant: Constants.MOVIE_IMAGE_WIDTH),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor),
        ])

        layoutContainerViewSubviews()
    }

    func layoutContainerViewSubviews() {
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                        constant: .paddingSmall),

            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor,
                                                constant: .paddingSmall),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                 constant: -.paddingSmall),
            titleLabel.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
        ])
    }

    

    // MARK: - config

    func configView(with viewModel: MovieViewModel) {
        containerView.layer.borderColor = viewModel.isSelected ? UIColor.systemBlue.cgColor : UIColor.Neugelb.Background.SURFACE.cgColor
        titleLabel.text = viewModel.title
        guard let imageURL = viewModel.imageURL else { return }

        thumbnailImageView.loadImageFromUrl(url: imageURL)
    }
}
