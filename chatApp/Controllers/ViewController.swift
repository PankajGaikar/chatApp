//
//  ViewController.swift
//  chatApp
//
//  Created by Krrish  on 05/11/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class ViewController: UIViewController {
     var ref : DatabaseReference!
    @IBOutlet weak var usernameTextbox: UITextField!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var emailTextbox: UITextField!
    @IBOutlet weak var passwordTextbox: UITextField!
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTextbox.text, let passkey = passwordTextbox.text, let uname = usernameTextbox.text else{
            print("form is not valid")
            return
        }
        Auth.auth().createUser(withEmail: email, password: passkey) { (result, err) in
            if err != nil{
                print("error")
                return
            }
        }
        var refer : DatabaseReference!
        refer = Database.database().reference()
        let values = ["name":uname,"email":email]
        let user = Auth.auth().currentUser
        refer.child("users").child((user?.uid)!).setValue(values) { (err, DBRefer) in
            if err != nil{
                print("error")
            }
        }
        let tableVC = storyboard?.instantiateViewController(withIdentifier: "contactsVC")as! ActiveContactTableViewController
        tableVC.userName = Auth.auth().currentUser?.displayName
        self.navigationController?.pushViewController(tableVC, animated: true)
        }
        
        /*let ref = Database.database().reference(fromURL: "https://chatapp-526f0.firebaseio.com/")
        let userRef = ref.child("users")
        let value = ["name":uname,"email":email]
        ref.updateChildValues(value) { (err, ref) in
            if err != nil{
                print(err)
            }
        }*/
        @IBAction func logInClicked(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // var ref : DatabaseReference!
      //  ref = Database.database().reference(fromURL: "https://chatapp-526f0.firebaseio.com/")
       // self.title = "firechat"
        logo.image = UIImage(named: "logoImg")
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 255/255, alpha: 0.7)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

