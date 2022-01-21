//
//  NetworkStub.swift
//  FindCVSTests
//
//  Created by 재영신 on 2022/01/21.
//

import Foundation
import RxSwift
import Stubber

@testable import FindCVS

class stub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        Stubber.invoke(getLocation, args: mapPoint)
    }
}
