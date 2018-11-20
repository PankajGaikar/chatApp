//
//  ActiveContactTableViewController.swift
//  chatApp
//
//  Created by Krrish  on 05/11/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ActiveContactTableViewController: UITableViewController {
    var user : users!
    var userName : String!
   // var usersArray = [Any]()
    var msgArray = [message]()
    
    @IBAction func newChatClicked(_ sender: Any) {
        
    }
    @IBAction func logoutClicked(_ sender: Any) {
        handleLogout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(3)
        self.navigationItem.title = Auth.auth().currentUser?.displayName
      
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
        }
        
        if Auth.auth().currentUser?.displayName == nil {
            print("This VC current user is nil")
        }
        else if userName == nil{
            print("user name from previous also found nil")
        }
        fetchMessages()
        userListener()
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    func userListener(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print(user!)
            print(user?.displayName)
        }
    }
    func fetchMessages(){
    Database.database().reference().child("messeges").observe(.childAdded, with: { (snapshot) in
           // print(snapshot)
            if let dict = snapshot.value as? [String:AnyObject]{
                let msgObject = message()
                msgObject.text = dict["text"]as! String
                msgObject.fromId = dict["fromId"]as! String
                msgObject.toId = dict["toId"]as! String
               // msgObject.timestamp = dict["timeStamp"]as! NSNumber
               self.msgArray.append(msgObject)
        }
        
        }, withCancel: nil)
    }
    func handleLogout(){
        do{
            try Auth.auth().signOut()
        }
        catch let logoutError{
            print(logoutError)
        }
        print("logout succeded")
        /*catch var logoutError : Error!{
         print(logoutError)
         }*/
        let vc = storyboard?.instantiateViewController(withIdentifier: "vc")as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return msgArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        let msg = message()
        /*if let toId = msg.toId{
            let ref = Database.database().reference().child("users").child(toId)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject]{
                    print(snapshot)
                    cell.textLabel?.text = dictionary["name"]as? String
                }
            }, withCancel: nil)*/
    
            cell.textLabel?.text = msg.text
        
        return cell
    }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
