//
//  UIViewController-extension.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import UIKit

extension UIViewController {
    static public func instanceWithDefaultNib() -> Self {
        let className = NSStringFromClass(self as AnyClass).components(separatedBy: ".").last
        return self.init(nibName: className, bundle: Bundle.main)
    }
    
    func presentServiceError(error: FTServiceError, retry: @escaping () -> Void) {
        let title = "Error"
        var message = ""
        
        switch error {
        case .apiError(_, let data):
            if let error = FTServiceApiError(data: data) {
                message = error.message
            }
        default:
            message = "Something happened"
        }
        
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { action in
            retry()
        }
        
        self.presentAlert(title: title, message: message, actions: [retryAction])
    }
    
    func presentAlert(title: String, message: String, actions: [UIAlertAction] = [], showCloseAction: Bool = true) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            for action in actions {
                alert.addAction(action)
            }
            
            if showCloseAction {
                let cancelAction = UIAlertAction(title:  "Close", style: .cancel)
                alert.addAction(cancelAction)
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
