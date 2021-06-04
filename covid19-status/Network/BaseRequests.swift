//
//  BaseRequests.swift
//  covid19-status
//
//  Created by Daniel Vieira on 03/06/21.
//

import Foundation
import Alamofire

class BaseRequests{
    
    let baseURL: String = "https://covid19-brazil-api.now.sh/api/report/v1/"

    func requestToGetCovidByState(by state: String, onSuccess: @escaping (CovidByState) -> Void){
        let PARAMETER_TO_GET_COVID_STATUS_BY_STATE = "brazil/uf/" + state
        AF.request(baseURL + PARAMETER_TO_GET_COVID_STATUS_BY_STATE)
            .validate()
            .responseDecodable(of: CovidByState.self) { (response) in
                guard let covidResponse = response.value else { return }
                onSuccess(covidResponse)
                return
            }
    }
    
    func requestToGetCovidAllCountry(onSuccess: @escaping ([CovidByState]) -> Void){
        AF.request(baseURL)
            .validate()
            .responseDecodable(of: AllCases.self) { (response) in
                guard let responseCovid = response.value?.all else {return}
                onSuccess(responseCovid)
                return
            }
    }
    
}

