//
//  BankHolidayEventManager.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import Foundation

// Class to manage operations of ProfileInformation Entity
class ProfileInfoManager {
    
    private init() { }
    static let shared = ProfileInfoManager()
    
    /// Add new entries
    /// Parameter record: Profile model object
    func create(record: ProfileModel) {
        
        let profileInfo = ProfileInformation(context: PersistentStorage.shared.context)
        profileInfo.fullName = "\(record.name?.title ?? "") \(record.name?.first ?? "") \(record.name?.last ?? "")"
        profileInfo.gender = record.gender
        profileInfo.age = Int64(record.dob?.age ?? 0)
        profileInfo.dateOfBirth = record.dob?.date
        profileInfo.email = record.email
        profileInfo.contact = record.cell
        profileInfo.registeredOn = record.registered?.date
        
        PersistentStorage.shared.saveContext()
    }
    
    // fetch information
    func getProfileInformation() -> ProfileInformation? {
        
        let profileList = PersistentStorage.shared.fetchManagedObject(managedObject: ProfileInformation.self)
        if (profileList ?? []).count > 0 {
            return profileList![0]
        }
        else {
            return nil
        }
        
    }
    
    // delete information
    func deleteProfileInformation() {
        
        guard let profileInfo = self.getProfileInformation() else {  return  }
        PersistentStorage.shared.context.delete(profileInfo)
        PersistentStorage.shared.saveContext()
    }
}

extension ProfileInfoManager {
    
    /// Conversion of Core Data object model
    /// Parameter record: Profile information managed object
    func convert(record:ProfileInformation)-> ProfileDetails {
        
        return ProfileDetails(fullName: record.fullName, gender: record.gender, dob: record.dateOfBirth, age: Int(record.age), email: record.email, contact: record.contact, registered: record.registeredOn, profileImgURL: record.profileImgURL)
    }
    
    /// conversion of API response model
    /// Parameter record: Profile information decodable model
    func convert(record: ProfileModel) -> ProfileDetails {
        
        let fullName = "\(record.name?.title ?? "") \(record.name?.first ?? "") \(record.name?.last ?? "")"
        return ProfileDetails(fullName: fullName, gender: record.gender, dob: record.dob?.date, age: record.dob?.age, email: record.email, contact: record.cell, registered: record.registered?.date, profileImgURL: record.picture?.large)
    }
}
