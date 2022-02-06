//
//  Controller+Ext.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import UIKit

extension UIViewController {
    var activityIndicatorTag: Int { return 999999 }
    
    func startActivityIndicator(style: UIActivityIndicatorView.Style = .large, location: CGPoint? = nil) {
        let loc = location ?? self.view.center
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                //Create the activity indicator
                let activityIndicator = UIActivityIndicatorView(style: style)
                activityIndicator.tag = self.activityIndicatorTag
                activityIndicator.center = loc
                activityIndicator.hidesWhenStopped = true
                activityIndicator.color = .black
                activityIndicator.startAnimating()
                self.view.addSubview(activityIndicator)            }
        }
        
    }
    
    func stopActivityIndicator() {
        //Here we find the `UIActivityIndicatorView` and remove it from the view
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                if let activityIndicator = self.view.subviews.filter(
                    { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
            }
        }
    }
    
    
    func showAllert(title: String, subtitle:String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            case .default:
                print("default")
            @unknown default:
                print("unknown default")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
