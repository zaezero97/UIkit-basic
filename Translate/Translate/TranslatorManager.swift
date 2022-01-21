//
//  TranslateManager.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import Alamofire
import Foundation

struct TranslatorManager {
    
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(from text: String, completionHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        let requestModel = TranslateRequestModel(source: sourceLanguage.languageCode,
                                                 target: targetLanguage.languageCode,
                                                 text: text)
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "73pFEAiSP4iHmyy3yiMz",
            "X-Naver-Client-Secret": "mo3Ld13QMD"
        ]
        
        AF.request(url, method: .post, parameters: requestModel,headers: header).responseDecodable(of: TranslateResponseModel.self) { response in
            switch response.result {
            case let .success(result):
                completionHandler(result.translatedText)
                return
            case let .failure(error):
                print("error",error.localizedDescription)
                return
            }
        }.resume()
    }
}
