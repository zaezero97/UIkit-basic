//
//  MovieModel.swift
//  MovieApp
//
//  Created by 재영신 on 2021/10/21.
//

import Foundation

struct MovieModel : Codable{
    let resultCount: Int
    let results: [Result]
    
}
struct Result : Codable{
    let trackName : String?
    let previewUrl : String?
    let image : String?
    let shortDescription : String?
    let longDescription : String?
    let trackPrice : Double?
    let currency : String?
    let releaseDate : String
    enum CodingKeys : String, CodingKey{
        case image = "artworkUrl100"
        case trackName
        case previewUrl
        case shortDescription
        case longDescription
        case trackPrice
        case currency
        case releaseDate
    }
}

