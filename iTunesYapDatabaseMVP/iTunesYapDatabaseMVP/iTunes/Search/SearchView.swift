//
//  SearchView.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 13.11.2025.
//

import Foundation
import UIKit
import SnapKit

final class SearchView: UIView {
    var onSearchChanged: ((String) -> Void)?

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search Albums"
        searchBar.sizeToFit()
        return searchBar
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: 130)
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private let noSearchResultsFoundView: NoSearchResultsFoundView = {
        let view = NoSearchResultsFoundView(
            title: "No results found",
            subtitle: "Try refining your search by checking the spelling or selecting from available options."
        )
        view.isHidden = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setResultsVisibility(showResults: Bool) {
        collectionView.isHidden = !showResults
        noSearchResultsFoundView.isHidden = showResults
    }

    private func configure() {
        configureUI()
        addSubviews()
        configureLayout()
    }

    private func configureUI() {
        backgroundColor = .systemGray6
    }

    private func addSubviews() {
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(noSearchResultsFoundView)
    }

    private func configureLayout() {
        collectionView.snp.makeConstraints { 
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }

        noSearchResultsFoundView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-80)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
        }
    }
}
