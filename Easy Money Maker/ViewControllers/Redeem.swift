//
//  Redeem.swift
//  Easy Money Maker
//
//  Created by berk birkan on 16.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Redeem: UIViewController {
    
    @IBOutlet weak var method: UISegmentedControl!
    
    @IBOutlet weak var amount: UITextField!
    
    
    @IBOutlet weak var paypalemail: UITextField!
    
    @IBOutlet weak var bankname: UITextField!
    
    @IBOutlet weak var ibannumber: UITextField!
    
    
    @IBOutlet weak var swiftnumber: UITextField!
    
    
    
    @IBAction func sendbutton(_ sender: UIButton) {
        let ref = Database.database().reference()
        let post = ["method":method.titleForSegment(at: method.selectedSegmentIndex),"amount":amount.text!,"paypal":paypalemail.text!,"bankname":bankname.text!,"ibannumber":ibannumber.text!,"swiftnumber":swiftnumber.text!,"uid":Auth.auth().currentUser?.uid]
        
        ref.child("redeem").child((Auth.auth().currentUser?.uid)!).setValue(post)
        
        let alert = UIAlertController(title: "Success", message: "Sent successfully!", preferredStyle: UIAlertController.Style.alert)
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okbutton)
        self.present(alert,animated: true,completion: nil)
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
