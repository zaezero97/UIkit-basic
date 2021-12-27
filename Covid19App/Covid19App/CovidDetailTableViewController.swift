//
//  CovidDetailTableViewController.swift
//  Covid19App
//
//  Created by 재영신 on 2021/12/27.
//

import UIKit

class CovidDetailTableViewController: UITableViewController {

    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var regionalOutbreakCell: UITableViewCell!
    @IBOutlet weak var overseasInflowCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCell: UITableViewCell!
    @IBOutlet weak var deathCell: UITableViewCell!
    
    var covidModel: CovidModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }



  
    func configureView() {
        guard let covidModel = self.covidModel else { return }
        
        self.title = covidModel.countryName
        self.newCaseCell.detailTextLabel?.text = "\(covidModel.newCase)명"
        self.totalCaseCell.detailTextLabel?.text = "\(covidModel.totalCase)명"
        self.recoveredCell.detailTextLabel?.text = "\(covidModel.recovered)명"
        self.deathCell.detailTextLabel?.text = "\(covidModel.death)명"
        self.percentageCell.detailTextLabel?.text = "\(covidModel.percentage)%"
        self.overseasInflowCell.detailTextLabel?.text = "\(covidModel.newFcase)명"
        self.regionalOutbreakCell.detailTextLabel?.text = "\(covidModel.newCcase)명"
    }

}
