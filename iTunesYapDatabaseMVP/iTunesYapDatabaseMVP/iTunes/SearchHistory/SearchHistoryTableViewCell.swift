//
//  TransactionsTableViewCell.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 17.11.2025.
//

import UIKit
import SnapKit

final class SearchHistoryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }

    func configure(with viewModel: SearchHistoryCellKind.SearchHistoryViewModel) {
        textLabel?.text = viewModel.leftText
        detailTextLabel?.text = viewModel.rightText
    }

    private func configureUI() {
        textLabel?.font = .systemFont(ofSize: 16)
        detailTextLabel?.font = .systemFont(ofSize: 14)
    }
}
