//
//  ProfileViewController.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import UIKit

// Class to display personal information of user
class ProfileViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet weak var imgViwProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var tblViwPersonalInfo: UITableView!
    
    // MARK: Variables
    var profileDetails : ProfileDetails?
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tblViwPersonalInfo.register(UINib(nibName: CellIdentifier.ProfileInfoTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.ProfileInfoTableViewCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.getProfileInformation))
        
        getProfileInformation()
    }
    
    override func viewWillLayoutSubviews() {
        imgViwProfile.setCornerRadius(radius: imgViwProfile.frame.width/2)
    }
    
    // MARK: Cutom Methods
    @objc func getProfileInformation() {
        
        if !Network.reachability.isConnectedToNetwork { // No internet
            
            self.fetchOfflineData()
            return
        }
        
        self.showAlert()
        ProfileViewModel.shared.getProfileInformationAPI { (profileResults,error) in
            
            DispatchQueue.main.async {
                
                self.dismissAlert()
                
                if let _ = error {
                    
                    self.fetchOfflineData()
                }
                
                if let profileResults = profileResults {
                    
                    self.profileDetails = ProfileInfoManager.shared.convert(record: profileResults.results[0])
                    self.lblProfileName.text = self.profileDetails?.fullName
                    
                    // save data to offline storage
                    ProfileInfoManager.shared.deleteProfileInformation()
                    ProfileInfoManager.shared.create(record: profileResults.results[0])
                    
                    // assigning user profile image
                    self.imgViwProfile.sd_setImage(with: URL(string: self.profileDetails?.profileImgURL ?? ""), placeholderImage: UIImage(named: "user"))
                    
                    self.tblViwPersonalInfo.reloadData()
                }
                else {
                    self.fetchOfflineData()
                }
            }
        }
    }
    
    // get data from offline storage
    private func fetchOfflineData() {
        
        if let info = ProfileInfoManager.shared.getProfileInformation() {
            
            self.profileDetails = ProfileInfoManager.shared.convert(record: info)
            self.lblProfileName.text = self.profileDetails?.fullName
            self.imgViwProfile.sd_setImage(with: URL(string: self.profileDetails?.profileImgURL ?? ""), placeholderImage: UIImage(named: "user"))
        }
        else {
            self.showDataMissingAlert()
        }
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profileDetails == nil ? 0 : 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ProfileInfoTableViewCell, for: indexPath) as! ProfileInfoTableViewCell
        
        // assigning user information
        switch indexPath.row {
        case 0:
            cell.lblInfoType.text = "Gender:"
            cell.lblActualInfo.text = (profileDetails?.gender ?? "").capitalized
        case 1:
            cell.lblInfoType.text = "Age:"
            cell.lblActualInfo.text = "\(profileDetails?.age ?? 0)"
        case 2:
            cell.lblInfoType.text = "Date of Birth:"
            cell.lblActualInfo.text = profileDetails?.dob?.UTCToLocal(currentFormat: DateFormat.YYYYMMDDTHHMMSSSSSZ.rawValue, requiredFormat: DateFormat.DDMMMYYYYWithComma.rawValue)
        case 3:
            cell.lblInfoType.text = "Email:"
            cell.lblActualInfo.text = profileDetails?.email
        case 4:
            cell.lblInfoType.text = "Contact:"
            cell.lblActualInfo.text = profileDetails?.contact
        default:
            cell.lblInfoType.text = "Registered On:"
            cell.lblActualInfo.text = profileDetails?.dob?.UTCToLocal(currentFormat: DateFormat.YYYYMMDDTHHMMSSSSSZ.rawValue, requiredFormat: DateFormat.DDMMMYYYYWithComma.rawValue)
        }
        
        return cell
        
    }
    
}
