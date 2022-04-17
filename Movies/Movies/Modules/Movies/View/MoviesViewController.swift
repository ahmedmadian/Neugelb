//
//  MoviesViewController.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import UIKit

class MoviesViewController: BaseViewController {
    // MARK: - Constants

    enum Constants {
        static let FAVOURITE_CELL_HEIGHT: CGFloat = 150
        static let FAVOURITE_CELL_WIDTH: CGFloat = 100
        static let MOVIE_CELL_HEIGHT: CGFloat = 100
        static let SUPPlEMENTARY_HEADER_VIEW_HEIGHT: CGFloat = 100
        static let NEXT_BUTTON_HEIGHT: CGFloat = 45
    }

    // MARK: - Presenter

    var presenter: MoviesPresenterProtocol?

    // MARK: - Views

    private lazy var supplementaryHeaderItem: NSCollectionLayoutBoundarySupplementaryItem = {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .estimated(Constants.SUPPlEMENTARY_HEADER_VIEW_HEIGHT)),
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .top)
    }()

    private lazy var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout = {
        return UICollectionViewCompositionalLayout { (sectionNumber, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionType = MoviesSections(rawValue: sectionNumber) else { return nil }

            var item: NSCollectionLayoutItem
            var group: NSCollectionLayoutGroup
            var section: NSCollectionLayoutSection

            switch sectionType {
            case .favourites:
                item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .fractionalHeight(1)))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(Constants.FAVOURITE_CELL_WIDTH),
                                                                                              heightDimension: .absolute(Constants.FAVOURITE_CELL_HEIGHT)),
                                                           subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            case .watched, .toWatch:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(Constants.MOVIE_CELL_HEIGHT))
                item = NSCollectionLayoutItem(layoutSize: itemSize)
                group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                                                                         heightDimension: .estimated(1)),
                                                                      subitems: Array(repeating: group, count: 2))
                containerGroup.interItemSpacing = .fixed(.padding)
                section = NSCollectionLayoutSection(group: containerGroup)
                section.orthogonalScrollingBehavior = .groupPaging
            }

            section.interGroupSpacing = .padding
            section.contentInsets = NSDirectionalEdgeInsets(top: .padding, leading: .padding, bottom: .padding, trailing: .padding)
            section.supplementariesFollowContentInsets = false
            section.boundarySupplementaryItems = [self.supplementaryHeaderItem]

            return section
        }
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewCompositionalLayout)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(FavouriteMovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: FavouriteMovieCollectionViewCell.self))

        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))

        collectionView.register(MoviesCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MoviesCollectionReusableView.Constants.REUSE_IDENTIFIER)

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = CGFloat.cornerRadius
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = presenter?.shouldEnableNextButton() ?? false ? UIColor.Neugelb.Highlight.PRIMARY.cgColor : UIColor.Neugelb.Background.SURFACE.cgColor
        button.backgroundColor = UIColor.Neugelb.Background.SURFACE
        button.tintColor = UIColor.Neugelb.Highlight.PRIMARY
        button.isEnabled = presenter?.shouldEnableNextButton() ?? false
        button.addTarget(self,
                         action: #selector(didTapNextButton),
                         for: .touchUpInside)

        return button
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

    // MARK: - BaseViewController

    override func setupViewAppereance() {
        super.setupViewAppereance()

        title = "Movies"
    }

    override func setupViewLayout() {
        super.setupViewLayout()

        [collectionView, nextButton].forEach {
            view.addSubview($0, translatesAutoresizingMaskIntoConstraints: false)
        }

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -.paddingSmall),

            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            nextButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.NEXT_BUTTON_HEIGHT),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.padding),
        ])
    }

    // MARK: - Actions

    @objc private func didTapNextButton() {
        presenter?.didTapNextButton()
    }

    private func updateNextButtonStatus() {
        nextButton.isEnabled = presenter?.shouldEnableNextButton() ?? false
        nextButton.layer.borderColor = presenter?.shouldEnableNextButton() ?? false ? UIColor.Neugelb.Highlight.PRIMARY.cgColor : UIColor.Neugelb.Background.SURFACE.cgColor
    }
}

// MARK: - MoviesViewProtocol

extension MoviesViewController: MoviesViewProtocol {
    func updateView() {
        collectionView.reloadData()
        updateNextButtonStatus()
    }

    func scrollToItem(at indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath,
                                    at: .left,
                                    animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension MoviesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.getNumberOfSections() ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfMovies(at: section) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = MoviesSections(rawValue: indexPath.section) else { fatalError("undefined section")}

        var cell: MovieCollectionViewCell?

        switch section {
        case .favourites:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavouriteMovieCollectionViewCell.self),
                                                                  for: indexPath) as? FavouriteMovieCollectionViewCell
        case .watched, .toWatch:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self),
                                                      for: indexPath) as? MovieCollectionViewCell
        }

        if let viewModel = presenter?.getMovieViewModelForCell(at: indexPath) {
            cell?.configView(with: viewModel)
        }

        return cell ?? MovieCollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: MoviesCollectionReusableView.Constants.REUSE_IDENTIFIER,
                                                                       for: indexPath) as? MoviesCollectionReusableView
        else {
            fatalError("cannot cast `\(String(describing: UICollectionReusableView.self))` to `\(String(describing: MoviesCollectionReusableView.self))`")
        }

        view.configView(with: presenter?.getTitle(for: indexPath.section))

        return view
    }
}

// MARK: - UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

