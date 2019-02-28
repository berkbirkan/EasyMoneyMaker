//
//  Register.swift
//  Easy Money Maker
//
//  Created by berk birkan on 16.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class Register: UIViewController {
    
    @IBOutlet weak var fullname: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func register(_ sender: UIButton) {
        
        if fullname.text! != "" && email.text! != "" && password.text! != "" {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (userdata, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okbutton)
                    self.present(alert,animated: true,completion: nil)
                }else{
                    let dbref = Database.database().reference()
                    
                    let post = ["fullname":self.fullname.text!,"email":self.email.text!,"password":self.password.text!,"point": 0,"uid":Auth.auth().currentUser?.uid] as! [String:Any]
                    
                    dbref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(post)
                    
                    UserDefaults.standard.set(userdata?.user.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberUser()
                }
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "Textbox cannot be empty", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okbutton)
            self.present(alert,animated: true,completion: nil)
        }
        
        
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    

}
