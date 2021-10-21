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
        // Do any additional setup after loading the view.
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        
        requestMovieAPI()
    }
}

// MARK: - TableView DataSource
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
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
                    print(self.movieModel)
                }catch{
                    print(error)
                }
            }
            
            
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
