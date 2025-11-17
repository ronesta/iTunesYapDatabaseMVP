//
//  SearchHistoryView.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 16.11.2025.
//

import Foundation
import UIKit
import SnapKit

final class SearchHistoryView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addSubview(tableView)
    }

    private func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
