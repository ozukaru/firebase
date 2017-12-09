//
//  ViewController.swift
//  firebaseFacebook
//
//  Created by MacBook Pro Retina  on 07/12/17.
//  Copyright © 2017 Oz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
class ViewController: UIViewController {
   
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var ingresarBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        ingresarBtn.layer.cornerRadius = 12
        facebookBtn.layer.cornerRadius = 12
        email.layer.cornerRadius = 12
        password.layer.cornerRadius = 12


    
    }

   
    @IBAction func login(_ sender: Any) {
        if (self.email.text?.isEmpty)!  || (self.password.text?.isEmpty)! {
            
            let alertController = UIAlertController(title: "Error", message: "Faltan datos por ingresar", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    UserDefaults.standard.setValue(self.email.text!, forKey:"email")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                } else {
               
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func loginFacebook(_ sender: Any) {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email","user_friends"], from: self) { (result, error) in
            if let error = error {print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
       
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                // User is signed in
                UserDefaults.standard.setValue(self.email.text!, forKey:"email")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
                self.present(vc!, animated: true, completion: nil)
                
            }
        }
            
            
}
        
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

