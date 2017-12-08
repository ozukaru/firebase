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
class ViewController: UIViewController {
   
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

