//
//  TabBarViewController.swift
//  ProMobiTechTask
//
//  Created by Contera Engg on 01/09/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK: - Variable declaration
    var navBankHolidayViewController : UINavigationController!
    var navProfileController : UINavigationController!
    var viwAdd : UIViewController!
    
    static let shared = TabBarViewController()
    var appD = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - user define mehtod
    /// This will instantiate all tab bar items and return its instance
    func initializeTabbar() -> TabBarViewController {
        
        // For Bank Holiday instantiate viewcontroller
        self.navBankHolidayViewController = UIStoryboard(name: StoryboardIdentifier.BankHoliday, bundle: nil).instantiateInitialViewController() as? UINavigationController
        
        // For Profile instantiate viewcontroller
        self.navProfileController = UIStoryboard(name: StoryboardIdentifier.Profile, bundle: nil).instantiateInitialViewController() as? UINavigationController
        
        
        // Finally add view controller array to tabbarview
        self.viewControllers = [self.navBankHolidayViewController, self.navProfileController]
        
        // Customisation of tabbar
        let tabBar: UITabBar? = self.tabBar
        
        let tabItemList: UITabBarItem? = (tabBar?.items?[0])
        let tabItemProfile: UITabBarItem? = (tabBar?.items?[1])
        
        
        tabItemList?.title = "List"
        tabItemList?.setTitleColor(color: .lightGray, forState: .normal)
        tabItemList?.setTitleColor(color: .systemBlue, forState: .selected)
        let list: UIImage? = UIImage(systemName: "square.grid.2x2.fill")?.withRenderingMode(.alwaysTemplate)
        let listSelected: UIImage? = UIImage(systemName:"square.grid.2x2.fill")?.withRenderingMode(.alwaysTemplate)
        tabItemList?.image = list
        tabItemList?.selectedImage = listSelected
        
        tabItemProfile?.title = "Profile"
        tabItemProfile?.setTitleColor(color: .lightGray, forState: .normal)
        tabItemProfile?.setTitleColor(color: .systemBlue, forState: .selected)
        let profile: UIImage? = UIImage(systemName:"person.fill")?.withRenderingMode(.alwaysTemplate)
        let profileSelected: UIImage? = UIImage(systemName:"person.fill")?.withRenderingMode(.alwaysTemplate)
        tabItemProfile?.image = profile
        tabItemProfile?.selectedImage = profileSelected
        
        return self
    }
}


extension UITabBarItem {
    /// Sets the color of the title color for a state.
    public func setTitleColor(color: UIColor, forState state: UIControl.State) {
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: state)
    }
}

extension TabBarViewController : UITabBarControllerDelegate {
 
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        if index == NSNotFound || index > 1 {
            tabBarController.moreNavigationController.popToRootViewController(animated: false)
            return
        }
        let navController = tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController
        navController?.popToRootViewController(animated: false)
    }
}

