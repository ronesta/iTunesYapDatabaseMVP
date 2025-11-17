//
//  AlbumView.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 16.11.2025.
//

import Foundation
import UIKit
import SnapKit

final class AlbumView: UIView {
    private let albumImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()

    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()

    private let collectionPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemOrange
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func displayAlbumDetails(with viewModel: AlbumViewModel) {
        albumNameLabel.text = viewModel.collectionName
        artistNameLabel.text = viewModel.artistName
        collectionPriceLabel.text = "\(viewModel.collectionPrice) $"
        albumImageView.kf.setImage(with: URL(string: viewModel.artworkUrl100))
    }

    private func configure() {
        configureUI()
        addSubviews()
        configureLayout()
        configureActions()
    }

    private func configureUI() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(albumImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(collectionPriceLabel)
    }

    private func configureLayout() {
        albumImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(200)
        }

        albumNameLabel.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(albumImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }

        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(albumNameLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }

        collectionPriceLabel.snp.makeConstraints {
            $0.top.equalTo(artistNameLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
    }

    private func configureActions() {

    }
}
