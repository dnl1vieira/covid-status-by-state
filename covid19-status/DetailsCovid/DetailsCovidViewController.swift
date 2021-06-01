//
//  DetailsCovidViewController.swift
//  covid19-status
//
//  Created by Daniel Vieira on 31/01/21.
//

import UIKit

class DetailsCovidViewController: UIViewController {
    
    var covidInformations: CovidByState!
    
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCases: UILabel!
    @IBOutlet weak var lblSuspects: UILabel!
    @IBOutlet weak var lblDeaths: UILabel!
    @IBOutlet weak var lblLastUpdated: UILabel!
    
    var textCases = "Cases: "
    var textSuspects = "Suspects: "
    var textDeaths = "Deaths: "
    var textDate = "Date: "
    
    override func viewDidLoad() {
        fillTitle(with: covidInformations.state)
        fillInformations(with: covidInformations)
    }
    
    init(with covidData: CovidByState) {
        covidInformations = covidData
        super.init(nibName: "DetailsCovidViewController", bundle: nil)
    }
    
    func fillInformations(with covidData: CovidByState){
        lblCases.text = "\(textCases)\(covidData.cases)"
        lblSuspects.text = "\(textSuspects)\(covidData.suspects)"
        lblDeaths.text = "\(textDeaths)\(covidData.deaths)"
        lblLastUpdated.text = "\(textDate)\(convert(date: covidData.date))"
    }
    
    func fillTitle(with state: String){
        lblState.text = state
    }
    
    func convert(date: String) -> String{
        let isoDate = ISO8601DateFormatter()
        isoDate.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let validDate = isoDate.date(from: date) else { return "Please, send me a date."}
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: validDate)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
