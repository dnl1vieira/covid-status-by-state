//
//  ViewController.swift
//  covid19-status
//
//  Created by Daniel Vieira on 31/01/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
   
    @IBOutlet weak var buttonSearch: UIButton?
    @IBOutlet weak var pickerViewState: UIPickerView?
    
    var states: [String] = ["AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO"]
    var selectedState = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewState?.dataSource = self
        pickerViewState?.delegate = self
    }
    
    
    @IBAction func openAnotherVisualStyle() {
        self.navigationController?.pushViewController(ViewAllStatesController(), animated: false)
    }
    
    func searchCovidStatusInStateSelected(state: String){
        requestToGetCovid(by: state, onSuccess: {covidData in
            self.navigationController?.pushViewController(DetailsCovidViewController(with: covidData), animated: true)
        })
    }
    
    func requestToGetCovid(by state: String, onSuccess: @escaping (CovidByState) -> Void){
        AF.request("https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/\(state)")
            .validate()
            .responseDecodable(of: CovidByState.self) { (response) in
                guard let covidResponse = response.value else { return }
                onSuccess(covidResponse)
                return
            }
    }
    
    @IBAction func searchCovid(_ sender: Any) {
        searchCovidStatusInStateSelected(state: selectedState.lowercased())
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedState = states[row]
    }
}

