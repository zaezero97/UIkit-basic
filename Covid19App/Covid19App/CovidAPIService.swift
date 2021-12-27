//
//  CovidAPIService.swift
//  Covid19App
//
//  Created by 재영신 on 2021/12/27.
//

import Foundation
import Alamofire

class CovidAPIService {
    static func fetchCovidOverView( completionHandler: @escaping (Result<CityCovidModel, Error>) -> Void)  {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey" : "OQCbAYE5B1kIwy8h4PultZWXc732FqM9i"
        ]
        
        AF.request(url, method: .get, parameters: param).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidModel.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case let.failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
