//
//  FeedViewController.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit
import SnapKit
import Floaty

final class FeedViewController: UIViewController {
    private lazy var presenter = FeedPresenter(vc: self)
    private lazy var writeButton: Floaty = {
        let float = Floaty(size: 50.0)
        float.sticky = true
        float.handleFirstItemDirectly = true
        float.addItem(title: "") { [weak self] _ in
            self?.presenter.didTapWriteButton()
        }
        float.buttonImage = Icon.write.image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return float
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.register(
            FeedTableViewCell.self,
            forCellReuseIdentifier: FeedTableViewCell.identifier
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
}

extension FeedViewController: FeedProtocol {
    func setupView() {
        self.navigationItem.title = "Feed"
        [tableView, writeButton].forEach {
            self.view.addSubview($0)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        writeButton.paddingY = 100.0
    }
    
    func moveToTwithViewController(with twith: Twith) {
        let twithVC = TwithViewController(twith: twith)
        self.navigationController?.pushViewController(twithVC, animated: true)
    }
    
    func moveToWriteViewController() {
        let writeVC = UINavigationController(rootViewController: WriteViewController())
        writeVC.modalPresentationStyle = .fullScreen
        self.present(writeVC,animated: true,completion: nil)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
