//
//  ConversationViewController.swift
//  chatApp
//
//  Created by Krrish  on 16/11/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ConversationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    var userDetails : users!
    var userName : String!
    var messageArray = [message]()
    
    @IBOutlet weak var txtSendMsg: UITextField!
    @IBAction func sendClicked(_ sender: Any) {
        let user = Auth.auth().currentUser
        let ref = Database.database().reference()
        let toId = userDetails.userId
        print("User Id : \(toId!)")
        let fromId = Auth.auth().currentUser?.uid.description
        print("from Id : \(String(describing: fromId!))")
        let timestamp = NSDate().timeIntervalSince1970
        let values = ["text":txtSendMsg.text!,"toId":toId!,"fromId":fromId!,"timestamp":timestamp] as [String : Any]
        ref.child("messeges").childByAutoId().setValue(values) { (error, databaseReference) in
            if (error != nil) {
                print("Error occurred")
            }
            print(databaseReference)
            self.table.delegate = self
            self.table.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMesseges()
        
        self.navigationItem.title = userDetails.name
    }
    func loadMesseges(){
        let ref = Database.database().reference().child("messeges")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject]{
                let m = message()
                m.text = dict["text"]as? String
                m.fromId = dict["fromId"]as? String
                m.toId = dict["toId"]as? String
                m.timestamp = dict["timestamp"]as? NSNumber
                self.messageArray.append(m)
            }
            
        }, withCancel: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")as! Conversation_Cell
        let messege = messageArray[indexPath.row]
        cell.messageFromYou.text = messege.text
        return cell
        self.table.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
