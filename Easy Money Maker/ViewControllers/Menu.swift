//
//  Menu.swift
//  Easy Money Maker
//
//  Created by berk birkan on 17.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Menu: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var useremail = String()
        let db_ref = Database.database().reference()
        
        db_ref.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            useremail = value?["email"] as! String
            self.title = useremail
            
        }
        
        print("USER EMAİL İS " + useremail)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menucell = self.tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! LeftMenuCell
        
        if indexPath.row == 0 {
            menucell.menuimage.image = UIImage(named: "share2")
            menucell.menutext.text = "Share this app"
        }else if indexPath.row == 1{
            menucell.menuimage.image = UIImage(named: "rate2")
            menucell.menutext.text = "Rate this app"
        }else if indexPath.row == 2{
            menucell.menutext.text = "Privacy Policy"
            menucell.menuimage.image = UIImage(named: "lock2")
        }else if indexPath.row == 3{
            menucell.menuimage.image = UIImage(named: "contact2")
            menucell.menutext.text = "Contact us"
        }
        
        return menucell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let appurl = "https://play.google.com/store/apps/details?id=com.tengrisoft.easymoney"
            let activityVC = UIActivityViewController(activityItems: ["You can make money easily with this app ! " + appurl], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }else if indexPath.row == 1{
            rateApp(appId: "1453299037") { (success) in
                print(success)
            }
        }else if indexPath.row == 2{
            if let url = URL(string: "http://berkbirkan.com/gizlilik-politikasi/") {
                UIApplication.shared.open(url, options: [:])
            }
        }else if indexPath.row == 3{
            if let url = URL(string: "http://berkbirkan.com") {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
