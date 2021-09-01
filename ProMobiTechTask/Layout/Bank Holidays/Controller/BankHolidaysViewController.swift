//
//  BankHolidaysViewController.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 31/08/21.
//

import UIKit

// Class to show listing of bank holiday events
class BankHolidaysViewController: BaseViewController {

    // MARK: IBOutlet
    @IBOutlet weak var tblViwBankHolidays: UITableView!
    
    // MARK: Variable Declaration
    var allEventList = [EventModel]()
    var searchedEventList = [EventModel]()
    var timer : Timer?
    var searchedText = String()
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavigationSearchBar()
        
        self.tblViwBankHolidays.register(UINib(nibName: CellIdentifier.BankHolidayTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.BankHolidayTableViewCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getHolidayEventList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.searchedText = ""
        self.view.endEditing(true)
    }
    
    // MARK: Custom Methods
    // Adding search bar to navigation controller
    private func setUpNavigationSearchBar() {
        
        let searchController = UISearchController(searchResultsController:  nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    // get data of holiday events list
    private func getHolidayEventList() {
        
        if !Network.reachability.isConnectedToNetwork { // no internet connection
            
            self.getOfflineData()
            return
        }
        
        self.showAlert()
        BankHolidayViewModel.shared.getBankHolidayListAPI { (response,error)  in
            
            DispatchQueue.main.async {
                
                self.dismissAlert()
                
                if let _ = error {
                    self.getOfflineData()
                }
                if let events = response?.englishAndWales?.events {
                    self.allEventList = events
                    self.searchedEventList = events
                    
                    // Adding entry to offline storage
                    BankHolidayEventManager.shared.deleteAll()
                    BankHolidayEventManager.shared.create(recordList: events)
                    
                    self.tblViwBankHolidays.reloadData()
                }
                else {
                    self.getOfflineData()
                }
            }
        }
    }
    
    // Load data from offline storage
    private func getOfflineData() {
        
        if let localEventList = BankHolidayEventManager.shared.getAll() {
            
            let convertedEventList = BankHolidayEventManager.shared.convert(eventList: localEventList)
            self.allEventList = convertedEventList
            self.searchedEventList = convertedEventList
            self.tblViwBankHolidays.reloadData()
        }
        else {
            self.showDataMissingAlert()
        }
    }
   
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension BankHolidaysViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viwHeader = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 25))
        viwHeader.backgroundColor = .systemGray5
        let lblHeader = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width, height: 25))
        lblHeader.font = UIFont.systemFont(ofSize: 15)
        lblHeader.text = "ENGLAND AND WALES"
        viwHeader.addSubview(lblHeader)
        return viwHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.BankHolidayTableViewCell, for: indexPath) as! BankHolidayTableViewCell
        
        cell.lblDate.text = (searchedEventList[indexPath.row].date ?? "").UTCToLocal(currentFormat: DateFormat.YYYYMMDD.rawValue, requiredFormat: DateFormat.DDMMMYYYYWithComma.rawValue)
        cell.lblTitle.text = searchedEventList[indexPath.row].title
        cell.lblNotes.text = "Notes: " + (searchedEventList[indexPath.row].notes ?? "Empty")
        cell.lblBunting.text = "Bunting: " + "\(searchedEventList[indexPath.row].bunting ?? false)"
        cell.lblNotes.isHidden = !(searchedEventList[indexPath.row].isExpanded ?? false)
        cell.lblBunting.isHidden = !(searchedEventList[indexPath.row].isExpanded ?? false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchedEventList[indexPath.row].isExpanded = !(searchedEventList[indexPath.row].isExpanded ?? false)
        tableView.reloadData()
    }
    
}

// MARK: UISearchBarDelegate, UISearchControllerDelegate
extension BankHolidaysViewController : UISearchBarDelegate, UISearchControllerDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedText = searchText
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getHints), userInfo: nil, repeats: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.getHints()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchBar.text = searchedText
    }
    
    // called after every 0.5 seconds to get searched data
    @objc func getHints() {
        
        if searchedText.isEmpty {
            
            searchedEventList = allEventList
        }
        else {
            searchedEventList = allEventList.compactMap { (event) -> EventModel? in
                return (event.title?.lowercased().contains((self.searchedText).lowercased()) ?? false) ? event : nil
            }
        }
        tblViwBankHolidays.reloadData()
    }
}

