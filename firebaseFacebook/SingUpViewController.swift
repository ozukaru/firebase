//
//  SingUpViewController.swift
//  firebaseFacebook
//
//  Created by MacBook Pro Retina  on 07/12/17.
//  Copyright © 2017 Oz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SingUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrarmeBtn: UIButton!
    
     var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        registrarmeBtn.layer.cornerRadius = 12
        
        
    }

    @IBAction func createAccountAction(_ sender: AnyObject) {
        
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Error", message: "Faltan datos por ingresar", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    print("You have successfully signed up")
                    self.ref.child("users").child((user?.uid)!).setValue(["email": self.emailTextField.text,
                                                                          "password": self.passwordTextField.text])
                    UserDefaults.standard.setValue(self.emailTextField.text!, forKey:"email")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile1")
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
