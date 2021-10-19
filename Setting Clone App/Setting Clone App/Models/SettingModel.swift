//
//  SettingModel.swift
//  Setting Clone App
//
//  Created by 재영신 on 2021/10/19.
//

import Foundation

struct SettingModel{
    var leftImageName : String = ""
    var menuTitle : String = ""
    var subTitle : String?
    var rightImageName : String? // cell의 오른쪽에 이미지가 없을 수도 있기 때문에 optional 변수로 선언
}
