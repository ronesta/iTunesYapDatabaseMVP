//
//  NoSearchResultsFoundView.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 18.11.2025.
//

import UIKit
import SnapKit

/// View for displaying no search results information to user
final class NoSearchResultsFoundView: UIView {

    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()

    private let magnifyingGlassImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: config)
        let imgView = UIImageView(image: image)
        imgView.tintColor = .secondaryLabel
        return imgView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No results found"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please try a different name."
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: Init

    init(
        title: String = "No results found",
        subtitle: String = "Please try a different name."
    ) {
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        setupView()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension NoSearchResultsFoundView {

    func setupView() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(magnifyingGlassImageView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }

    func setupLayout() {
        verticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        magnifyingGlassImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
}

// MARK: - Public API

extension NoSearchResultsFoundView {
    func setTitle(_ text: String) {
        titleLabel.text = text
    }

    func setSubtitle(_ text: String) {
        subtitleLabel.text = text
    }

    func set(title: String?, subtitle: String?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
