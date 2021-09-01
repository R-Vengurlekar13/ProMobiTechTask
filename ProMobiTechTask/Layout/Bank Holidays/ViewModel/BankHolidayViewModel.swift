//
//  BankHolidayViewModel.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 31/08/21.
//

import Foundation


class BankHolidayViewModel {
    
    static let shared = BankHolidayViewModel()
    private init() { }
    
    func getBankHolidayListAPI(completion:@escaping(BankHolidayModel?,Error?)->()) {
        
        APIManager.shared.getApiData(requestUrl: URL(string: Endpoint.bankHoliday)!, resultType: BankHolidayModel.self) { (bankHolidayModel,error) in
            
            completion(bankHolidayModel,error)
        }
    }
    
    
    
    
}
