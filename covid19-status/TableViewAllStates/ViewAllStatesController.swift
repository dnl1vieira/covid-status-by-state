//
//  ViewAllStatesController.swift
//  covid19-status
//
//  Created by Daniel Vieira on 03/06/21.
//

import Foundation
import UIKit
import Alamofire

struct CellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class ViewAllStatesController: UIViewController{

    var req = BaseRequests()
    
    @IBOutlet weak var tableViewStates: UITableView!
    var tableViewData = [CellData]()
    var allCases = [CovidByState](){
        didSet{
            for i in self.allCases {
                let cellData = CellData(opened: false, title: i.state, sectionData: ["    Cases: \(i.cases)", "    Suspects: \(i.suspects)"])
                self.tableViewData.append(cellData)
            }
            
            self.tableViewStates.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        req.requestToGetCovidAllCountry(onSuccess: {covidData in
            self.allCases = covidData
        })
        tableViewStates.dataSource = self
        tableViewStates.delegate = self
        tableViewStates.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
   
    
}


extension ViewAllStatesController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.accessoryType = .detailButton
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else {
                tableViewData[indexPath.section].opened  = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }else {
            searchCovidStatusInStateSelected(state: self.allCases[indexPath.section].uf)
        }
    }
    
    func searchCovidStatusInStateSelected(state: String){
        req.requestToGetCovidByState(by: state, onSuccess: {covidData in
            self.navigationController?.pushViewController(DetailsCovidViewController(with: covidData), animated: true)
        })
    }
    
}
