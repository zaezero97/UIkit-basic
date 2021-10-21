//
//  DetailViewController.swift
//  MovieApp
//
//  Created by 재영신 on 2021/10/21.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {

    var movieResult : MovieResult?
    var player : AVPlayer?
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    @IBOutlet weak var movieContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let hasUrl = movieResult?.previewUrl{
                makePlayerAndPlay(urlString: hasUrl)
        }
    }
    @IBAction func play(_ sender: Any) {
        player?.play()
    }
    @IBAction func stop(_ sender: Any) {
        player?.pause()
    }
}
// MARK: - AVKit func
extension DetailViewController{
    func makePlayerAndPlay(urlString : String){
        if let hasUrl = URL(string: urlString){
             player = AVPlayer(url: hasUrl)
            let playerLayer = AVPlayerLayer(player: player)
            
            movieContainer.layer.addSublayer(playerLayer)
            playerLayer.frame = movieContainer.bounds
            
            player?.play()
        }
    }
}


