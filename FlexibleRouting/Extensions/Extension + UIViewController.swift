//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 07.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit
import SwiftUI

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    private struct  Preview: UIViewControllerRepresentable {
            
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        
    }
    
    func showPreview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
    
}

//@nonobjc extension UIViewController {
//    func add(_ child: UIViewController, frame: CGRect? = nil) {
//        addChild(child)
//
//        if let frame = frame {
//            child.view.frame = frame
//        }
//
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//    }
//
//    func remove() {
//        willMove(toParent: nil)
//        view.removeFromSuperview()
//        removeFromParent()
//    }
//}
