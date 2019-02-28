//
//  ViewController.swift
//  Easy Money Maker
//
//  Created by berk birkan on 16.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit
import Firebase
import SideMenu


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADRewardBasedVideoAdDelegate {
    
    
    @IBAction func refreshbutton(_ sender: UIBarButtonItem) {
        checkamount()
    }
    
    
    @IBOutlet weak var point: UIBarButtonItem!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let webpanelcell = tableView.dequeueReusableCell(withIdentifier: "webpanelcell", for: indexPath) as! webpanelcell
            return webpanelcell
        }else if indexPath.row == 1{
            let webpanelcell = tableView.dequeueReusableCell(withIdentifier: "admobcell", for: indexPath) as! admobTableViewCell
            return webpanelcell
            
        }else if indexPath.row == 2{
            let webpanelcell = tableView.dequeueReusableCell(withIdentifier: "startappcell", for: indexPath) as! startappTableViewCell
            return webpanelcell
        }else if indexPath.row == 3{
            let webpanelcell = tableView.dequeueReusableCell(withIdentifier: "redeemcell", for: indexPath) as! redeemTableViewCell
            return webpanelcell
        }
        
        let webpanelcell = tableView.dequeueReusableCell(withIdentifier: "aboutuscell", for: indexPath) as! aboutusTableViewCell
        return webpanelcell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "towebpanel", sender: nil)
        }else if indexPath.row == 1{
            //admob
            print("loading admob...")
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            }else{
                let alert = UIAlertController(title: "Error", message: "Admob ads not ready! Please try again later", preferredStyle: UIAlertController.Style.alert)
                let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okbutton)
                self.present(alert,animated: true,completion: nil)
            }
            
        }else if indexPath.row == 2{
            //startapp
            print("startapp")
        }else if indexPath.row == 3 {
            performSegue(withIdentifier: "toredeem", sender: nil)
        }else if indexPath.row == 4{
            performSegue(withIdentifier: "toaboutus", sender: nil)
        }else{
            print("error")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        checkamount()
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
        
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        let db_ref = Database.database().reference()
        
        db_ref.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userpoint = value?["point"] as? Double
            let newpoint = userpoint! + reward.amount.doubleValue
            
            db_ref.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["point":newpoint])
            
        }
        
        
        
        
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
        
        
        
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        checkamount()
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
    
    func checkamount(){
        let db_ref = Database.database().reference()
        
        db_ref.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userpoint = value?["point"] as? Double
            
            let pointstring = String(format: "%.2f", userpoint!)
            
            self.point.title = "Point: " + pointstring
            
            
            
        }
        
    }


}

