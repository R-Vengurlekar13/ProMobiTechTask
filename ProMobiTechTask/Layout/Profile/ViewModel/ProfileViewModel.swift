//
//  ProfileViewModel.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import Foundation

// class to fetch user information
class ProfileViewModel {
    
    static let shared = ProfileViewModel()
    private init() { }
    
    /// Parse Information
    /// - Parameter completion: Profile Information, Error
    func getProfileInformationAPI(completion:@escaping(ProfileResultsModel?,Error?)->()) {
        
        APIManager.shared.getApiData(requestUrl: URL(string: Endpoint.profileInfo)!, resultType: ProfileResultsModel.self) { (profileResultModel,error) in
            
            completion(profileResultModel,error)
        }
    }
    
    
}
