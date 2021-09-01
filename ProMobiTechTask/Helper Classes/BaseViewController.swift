//
//  BaseViewController.swift
//  ProMobiTechTask
//
//  Created by Contera Engg on 01/09/21.
//

import UIKit
import SDWebImage

// Parent class of every controller
class BaseViewController: UIViewController {

    // MARK: Variable Initialization
    var alert : UIAlertController?
    var progressView : UIActivityIndicatorView?
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // method to display alert with activity indicator
    func showAlert() {
        
        alert  = UIAlertController(title: "\n", message: "", preferredStyle: .alert)
        progressView = UIActivityIndicatorView(frame: CGRect(x: 120, y: 20, width: 30, height: 30))
        progressView?.hidesWhenStopped = true
        progressView?.startAnimating()
        progressView?.style = .large
        alert?.view.addSubview(progressView!)
        self.present(alert!, animated: true, completion: nil)
    }
    
    // method to data not found alert
    func showDataMissingAlert() {
        
        let alert = UIAlertController(title: "Error 404", message: "Data not found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func dismissAlert() {
        progressView?.stopAnimating()
        alert?.dismiss(animated: true, completion: nil)
        progressView = nil
        alert = nil
    }
}
