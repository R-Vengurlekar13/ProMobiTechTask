//
//  APIManager.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 31/08/21.
//

import Foundation

struct APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?,Error?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: responseData!)
                _=completionHandler(result, error)
            }
            catch let error{
                debugPrint("error occured while decoding = \(error)")
            }
            
            
        }.resume()
    }
    
}
