//
//  LocationInformationViewController.swift
//  FindCVS
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa
import CoreLocation

class LocationInformationViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let locationManager = CLLocationManager()
    let viewModel = LocationInformationViewModel()
    let detailListBackgroundView = DetailListBackgroundView()
    
    lazy var mapView: MTMapView = {
        let map = MTMapView()
        map.currentLocationTrackingMode = .onWithHeadingWithoutMapMoving
        map.delegate = self
        return map
    }()
    
    lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "location.fill")
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        button.configuration = config
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var detailList: UITableView = {
        let tableView = UITableView()
        tableView.register(DetailListCell.self, forCellReuseIdentifier: DetailListCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bind(self.viewModel)
    }
    private func bind(_ viewModel: LocationInformationViewModel) {
        detailListBackgroundView.bind(viewModel.detailListBackgroundViewModel)
        
        viewModel.setMapCenter
            .emit(to: self.mapView.rx.setMapCenterPoint)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.presentAlert)
            .disposed(by: disposeBag)
        viewModel.detailListCellData
            .drive(detailList.rx.items) {
                tv, row, data in
                let cell = tv.dequeueReusableCell(withIdentifier: "DetailListCell", for: IndexPath(row: row, section: 0)) as! DetailListCell
                
                cell.setData(data)
                return cell
            }.disposed(by: disposeBag)
        
        viewModel.detailListCellData
            .map {
                $0.compactMap{ $0.point }
            }
            .drive(self.rx.addPOIItems)
            .disposed(by: disposeBag)
        
        detailList.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.detailListItemSelected)
            .disposed(by: disposeBag)
        currentLocationButton.rx.tap
            .bind(to: viewModel.currentLocationButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.scrollToSelectedLocation
            .emit(to: self.rx.showSelectedLocation)
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        [mapView, currentLocationButton, detailList].forEach {
            self.view.addSubview($0)
        }
        locationManager.delegate = self
        //navigation
        self.navigationItem.title = "내 주변 편의점 찾기"
        self.view.backgroundColor = .white
        
        setConstraints()
    }
    
    private func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(self.view.snp.centerY).offset(100)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(detailList.snp.top).offset(-12)
            make.leading.equalToSuperview().offset(12)
            make.width.height.equalTo(40)
        }
        
        detailList.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(mapView.snp.bottom)
        }
    }
}

extension LocationInformationViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            return
        default:
            viewModel.mapViewError.accept(MTMapViewError.locationAuthrizationDenied.errorDescription)
            return
        }
    }
}

extension LocationInformationViewController: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        #if DEBUG
        viewModel.currentLocation.accept(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.394225, longitude: 127.110341)))
        #else
         viewModel.currentLocation.accept(loaction)
        #endif
    }
    
    func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) {
        viewModel.mapCenterPoint.accept(mapCenterPoint)
        
    }
    
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        viewModel.selectPOIItem.accept(poiItem)
        return false
    }
    func mapView(_ mapView: MTMapView!, failedUpdatingCurrentLocationWithError error: Error!) {
        viewModel.mapViewError.accept(error.localizedDescription)
        
    }
}


extension Reactive where Base: MTMapView {
    var setMapCenterPoint: Binder<MTMapPoint> {
        return Binder(base) {
            base,point in
            base.setMapCenter(point, animated: true)
        }
    }
}

extension Reactive where Base: LocationInformationViewController {
    var presentAlert: Binder<String> {
        return Binder(base) {
            base, message in
            let alertController = UIAlertController(title: "문제가 발생했어요", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alertController.addAction(action)
            
            base.present(alertController, animated: true, completion: nil)
        }
    }
    
    var showSelectedLocation: Binder<Int> {
        return Binder(base) {
            base, row in
            let indexPath = IndexPath(row: row, section: 0)
            base.detailList.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }
    }
    
    var addPOIItems: Binder<[MTMapPoint]> {
        return Binder(base) { base, points in
            let items = points
                .enumerated()
                .map { offset, point -> MTMapPOIItem in
                    let mapPOIItem = MTMapPOIItem()
                    mapPOIItem.itemName = "테스트"
                    mapPOIItem.mapPoint = point
                    mapPOIItem.markerType = .redPin
                    mapPOIItem.showAnimationType = .springFromGround
                    mapPOIItem.tag = offset
                    
                    return mapPOIItem
                }
            
            base.mapView.removeAllPOIItems()
            print("items!!!",items)
            base.mapView.addPOIItems(items)
            print(base.mapView.poiItems)
        }
    }
}
