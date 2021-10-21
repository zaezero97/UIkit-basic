//
//  NetworkLayer.swift
//  MovieApp
//
//  Created by 재영신 on 2021/10/21.
//

import Foundation

enum RequestType{
    case justURL(urlString : String)
    case searchMovie(queryItems : [URLQueryItem])
}
enum RequestError : Error{
    case badURL
}
class NetworkLayer {
    //only url
    // url+param
    typealias NetworkCompletion = (_ data: Data?, _ response : URLResponse?, _ error: Error?) -> Void
    func request(type: RequestType, completion : @escaping NetworkCompletion){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do{
            let request = try buildRequest(type: type)
            session.dataTask(with: request) { data, response, error in
                print((response as! HTTPURLResponse).statusCode)
                completion(data,response,error)
            }.resume()
            session.finishTasksAndInvalidate()
        }catch{
            print(error)
        }
    }
    func buildRequest(type: RequestType) throws -> URLRequest{
        switch type {
        case .justURL(urlString: let urlString):
            guard let hasURL = URL(string: urlString) else{ throw RequestError.badURL }
                var request = URLRequest(url: hasURL)
                request.httpMethod = "GET"
                return request
            
        case .searchMovie(queryItems: let queryItems):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = queryItems
            guard let hasURL = components?.url else { throw RequestError.badURL }
                var request = URLRequest(url: hasURL)
                request.httpMethod = "GET"
                return request
        }
    }
}
