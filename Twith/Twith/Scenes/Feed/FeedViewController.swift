//
//  FeedViewController.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
    private lazy var presenter = FeedPresenter(vc: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        tableView.register(
            FeedTableViewCell.self,
            forCellReuseIdentifier: FeedTableViewCell.identifier
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
}

extension FeedViewController: FeedProtocol {
    func setupView() {
        navigationItem.title = "Feed"
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
