//
//  MoviesCollectionViewSectionHeader.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import UIKit

class MoviesCollectionReusableView: UICollectionReusableView {
    enum Constants {
        static let REUSE_IDENTIFIER: String = String(describing: MoviesCollectionReusableView.self)
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Neugelb.Text.TEXT_PRIMARY
        label.font = UIFont.LABEL.bold()
        label.text = "Watch"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        addSubview(label, translatesAutoresizingMaskIntoConstraints: false)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    init(text: String?) {
        super.init(frame: .zero)

        addSubview(label, translatesAutoresizingMaskIntoConstraints: false)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configView(with text: String?) {
        label.text = text
    }
}
