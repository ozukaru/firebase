//
//  HomeViewController.swift
//  firebaseFacebook
//
//  Created by MacBook Pro Retina  on 07/12/17.
//  Copyright © 2017 Oz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Salir", style: .plain, target:self,action:#selector(Logout))
    }

    
    @objc func Logout(){
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
                present(vc, animated: true, completion: nil)
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.synchronize()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
 
}
