//
//  BankHolidayModel.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 31/08/21.
//

import Foundation

struct BankHolidayModel : Decodable {
    
    let englishAndWales : DivisionAndEventModel?
    
    private enum CodingKeys : String, CodingKey {
        case englishAndWales = "england-and-wales"
    }
}

struct DivisionAndEventModel : Decodable{
    let events : [EventModel]?
}

struct EventModel : Decodable {
    
    let title : String?
    let date : String?
    let notes : String?
    let bunting : Bool?
    var isExpanded : Bool?
}
