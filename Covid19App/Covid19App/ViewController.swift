//
//  ViewController.swift
//  Covid19App
//
//  Created by 재영신 on 2021/12/27.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.indicatorView.startAnimating()
        
        CovidAPIService.fetchCovidOverView { [weak self] result in
            guard let self = self else { return }
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.pieChartView.isHidden = false
            self.labelStackView.isHidden = false
            switch result {
            case let .success(result):
                debugPrint("success \(result)")
                self.configureStackView(koreaCovidModel: result.korea)
                let covidCityList = self.makeCovidList(cityCovieModel: result)
                self.configureChatView(covidList: covidCityList)
            case let .failure(error):
                debugPrint("error \(error)")
            }
        }
    }

    func configureStackView(koreaCovidModel: CovidModel) {
        self.totalCaseLabel.text = "\(koreaCovidModel.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidModel.newCase)"
    }
    
    func makeCovidList(cityCovieModel: CityCovidModel) -> [CovidModel] {
        return [
            cityCovieModel.seoul,
            cityCovieModel.busan,
            cityCovieModel.chungbuk,
            cityCovieModel.chungnam,
            cityCovieModel.daegu,
            cityCovieModel.daejeon,
            cityCovieModel.gangwon,
            cityCovieModel.gwangju,
            cityCovieModel.gyeongbuk,
            cityCovieModel.gyeonggi,
            cityCovieModel.incheon,
            cityCovieModel.jeju,
            cityCovieModel.jeonbuk,
            cityCovieModel.sejong,
            cityCovieModel.ulsan,
        ]
    }
    
    func configureChatView(covidList: [CovidModel]) {
        self.pieChartView.delegate = self
        let entries = covidList.compactMap{ [weak self] city -> PieChartDataEntry? in
            guard let self = self else { return nil }
            return PieChartDataEntry(value: self.removeFormatString(string: city.newCase), label: city.countryName, data: city)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        dataSet.valueTextColor = .black
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.material() +
        ChartColorTemplates.pastel()
        self.pieChartView.data =  PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
    }
    
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailVC  = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailTableViewController") as? CovidDetailTableViewController else { return }
        guard let covidModel = entry.data as? CovidModel else { return }
        
        covidDetailVC.covidModel = covidModel
        
        covidDetailVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(covidDetailVC, animated: true)
    }
}
