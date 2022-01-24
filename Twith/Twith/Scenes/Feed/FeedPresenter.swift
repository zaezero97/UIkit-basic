//
//  FeedPresenter.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit

protocol FeedProtocol: AnyObject {
    func setupView()
    func moveToTwithViewController(with twith: Twith)
    func moveToWriteViewController()
    func reloadData()
}

final class FeedPresenter: NSObject {
    private weak var vc: FeedProtocol?
    private var twiths: [Twith] = []
    private let manager: UserDefaultsManagerProtocol
    init(
        vc: FeedProtocol,
        manager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.vc = vc
        self.manager = manager
    }
    
    func viewDidLoad() {
        self.twiths = manager.getTwith()
        self.vc?.setupView()
    }
    
    func viewWillAppear() {
        self.twiths = manager.getTwith()
        self.vc?.reloadData()
    }
    
    func didTapWriteButton() {
        self.vc?.moveToWriteViewController()
    }
}

extension FeedPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.twiths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell
        else { return UITableViewCell() }
        
        let twith = self.twiths[indexPath.row]
        cell.setup(twith: twith)
        return cell
    }
    
    
}

extension FeedPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let twith = self.twiths[indexPath.row]
        vc?.moveToTwithViewController(with: twith)
    }
}
