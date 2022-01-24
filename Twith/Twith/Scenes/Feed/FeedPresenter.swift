//
//  FeedPresenter.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit

protocol FeedProtocol: AnyObject {
    func setupView()
}

final class FeedPresenter: NSObject {
    private weak var vc: FeedProtocol?
    
    init(vc: FeedProtocol) {
        self.vc = vc
    }
    
    func viewDidLoad() {
        vc?.setupView()
    }
}

extension FeedPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell
        else { return UITableViewCell() }
        
        let twith = Twith(user: User.shared, content: "안녕하세요")
        cell.setup(twith: twith)
        return cell
    }
    
    
}

extension FeedPresenter: UITableViewDelegate {}
