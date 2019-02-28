//
//  WebViewController.swift
//  Easy Money Maker
//
//  Created by berk birkan on 16.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WebViewController: UIViewController {
    
    var count = 30
    var link = String()
    var timer = Timer()
    
    
    @IBOutlet weak var webview: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: link)
        
        let requestObj = URLRequest(url: url! as URL)
        webview.loadRequest(requestObj)
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        
    }
    
    @objc func timerAction() {
        count -= 1
        self.title = "\(count)"
        
        if count == 0{
            timer.invalidate()
            //+25 point
            let db_ref = Database.database().reference()
            
            db_ref.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let userpoint = value?["point"] as? Int
                let newpoint = userpoint! + 25
                
                db_ref.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["point":newpoint])
                
            }
            
            navigationController?.popViewController(animated: true)
            
            let alert = UIAlertController(title: "Success!", message: "You make +25 Point!", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okbutton)
            self.present(alert,animated: true,completion: nil)
            
            
        }
    }
    

    

}
