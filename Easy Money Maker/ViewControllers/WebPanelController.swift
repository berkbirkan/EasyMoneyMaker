//
//  WebPanelController.swift
//  Easy Money Maker
//
//  Created by berk birkan on 16.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class WebPanelController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var videonamearray = [String]()
    var videotextarray =  [String]()
    var videolinkarray = [String]()
    var videoimagearray = [String]()
    var indextitle = Int()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if videonamearray.count == 0{
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No video available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            return 0
            
        }
        return videonamearray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "videocell", for: indexPath) as! VideoCell
        cell.videoname.text = videonamearray[indexPath.row]
        cell.videotext.text = videotextarray[indexPath.row]
        cell.videolink.text = videolinkarray[indexPath.row]
        cell.videoimage.sd_setImage(with: URL(string: videoimagearray[indexPath.row]))
        
        return cell
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let second = segue.destination as! WebViewController
        second.link = videolinkarray[indextitle]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indextitle = indexPath.row
        performSegue(withIdentifier: "viewvideo", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        getdatafromFirebase()
       
    }
    
    func getdatafromFirebase(){
        let ref = Database.database().reference()
        ref.child("videos").observe(DataEventType.childAdded) { (snapshot) in
            let values = snapshot.value! as! NSDictionary
            let post = values["post"] as! NSDictionary
            let postID = post.allKeys
            
            for id in postID{
                let singlePost = post[id] as! NSDictionary
                let videoname = singlePost["name"] as! String
                let videotext = singlePost["text"] as! String
                let videolink = singlePost["url"] as! String
                let videoimage = singlePost["image"] as! String
                
                self.videonamearray.append(videoname)
                self.videotextarray.append(videotext)
                self.videolinkarray.append(videolink)
                self.videoimagearray.append(videoimage)
                
                
                
            }
            self.tableview.reloadData()
        }
    }
    


}
