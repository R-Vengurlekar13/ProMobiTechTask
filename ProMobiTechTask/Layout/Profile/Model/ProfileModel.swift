//
//  ProfileViewModel.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import Foundation

struct ProfileResultsModel: Decodable {
    
    let results : [ProfileModel]
}

struct ProfileModel: Decodable {
    
    let gender: String?
    let name : ProfileNameModel?
    let dob : ProfileDateAgeModel?
    let email : String?
    let cell: String?
    let registered : ProfileDateAgeModel?
    let picture: ProfilePictureModel?
}

struct ProfileNameModel: Decodable {
    let title: String?
    let first: String?
    let last: String?
}

struct ProfileDateAgeModel: Decodable {
    let date: String?
    let age: Int?
}

struct ProfilePictureModel: Decodable {
    let large : String?
}

struct ProfileDetails {
    
    let fullName: String?
    let gender: String?
    let dob : String?
    let age: Int?
    let email : String?
    let contact: String?
    let registered : String?
    let profileImgURL: String?
}
