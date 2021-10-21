//
//  ViewController.swift
//  MovieApp
//
//  Created by 재영신 on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    var movieModel : MovieModel?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        
        requestMovieAPI()
    }
    func loadImage(urlString : String, completion: @escaping (UIImage?)-> Void){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        if let hasURL = URL(string: urlString){
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            
            session.dataTask(with: request) { data, response, error in
                print((response as! HTTPURLResponse).statusCode)
                if let hasData = data{
                    completion(UIImage(data: hasData))
                    return
                }
            }.resume()
            session.finishTasksAndInvalidate()
        }
        completion(nil)
    }
}

// MARK: - TableView DataSource
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel?.results.count ?? 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.titleLabel.text = self.movieModel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription
        
        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        let price = self.movieModel?.results[indexPath.row].trackPrice?.description ?? ""
        
        cell.priceLabel.text = currency + price
        self.loadImage(urlString: self.movieModel?.results[indexPath.row].image ?? "", completion: { image in
            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        })
        if let dateString = self.movieModel?.results[indexPath.row].releaseDate{
            let formatter = ISO8601DateFormatter()
            if let isoDate = formatter.date(from: dateString){
                let myFormmater = DateFormatter()
                myFormmater.dateFormat = "yyyy-MM-dd"
                let dateStr = myFormmater.string(from: isoDate)
                cell.dateLabel.text = dateStr
            }
        }
        
        return cell
    }
    
}
// MARK: - TableView Delegate
extension ViewController : UITableViewDelegate{
    
}
// MARK: - Search Bar Delegate
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
// MARK: - Movie api call function
extension ViewController{
    func requestMovieAPI(){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        let term = URLQueryItem(name: "term", value: "marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        
        components?.queryItems = [term,media]
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            print((response as! HTTPURLResponse).statusCode)
            if let hasData = data{
                do{
                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    print(self.movieModel ?? "no data")
                    
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                }catch{
                    print(error)
                }
            }
            
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
