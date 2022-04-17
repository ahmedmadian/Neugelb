//
//  MovieDetailInfoItemCell.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import UIKit

class MovieDetailInfoItemCell: UITableViewCell {
    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Neugelb.Highlight.PRIMARY
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View

    private func setupViewLayout() {
        [titleLabel, valueLabel].forEach {
            contentView.addSubview($0, translatesAutoresizingMaskIntoConstraints: false)
        }

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),

            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .paddingSmall),
            valueLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    // MARK: - Config

    func configView(with viewModel: MovieDetailInfoItemViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
