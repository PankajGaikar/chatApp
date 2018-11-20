//
//  NewContactTableViewController.swift
//  chatApp
//
//  Created by Krrish  on 11/11/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class NewContactTableViewController: UITableViewController {
    var userArray = [users]()
  //  var userDict = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    func fetchUsers(){
    Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
        
            if let dict = snapshot.value as? [String:AnyObject]{
                let userObject = users()
                userObject.userId = snapshot.key
               // print(dict)
                userObject.name = dict["name"] as! String
               // print(userObject.name)
                userObject.email = dict["email"] as! String
                self.userArray.append(userObject)
                
                //self.userDict = dict as! [String : String]
               // print(self.userDict)
            }
        }, withCancel: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.userArray.count)
        return self.userArray.count
      /*  print(userDict.count)
        return userDict.count*/
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        let indexObject = self.userArray[indexPath.row]
        cell.textLabel?.text = indexObject.name
        cell.detailTextLabel?.text = indexObject.email
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = storyboard?.instantiateViewController(withIdentifier: "conversation")as! ConversationViewController
        let ref = Auth.auth().currentUser?.displayName
        print(ref)
       // conversation.userName =
        conversation.userDetails = self.userArray[indexPath.row]
        self.navigationController?.pushViewController(conversation, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
