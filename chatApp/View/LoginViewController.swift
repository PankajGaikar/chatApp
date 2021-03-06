//
//  LoginViewController.swift
//  chatApp
//
//  Created by Krrish  on 05/11/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    var userArray = [users]()
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func loginClicked(_ sender: Any) {
        let email = txtEmail.text
        let passkey = txtPassword.text
        if email != nil && passkey != nil {
            Auth.auth().signIn(withEmail: email!, password: passkey!) { (result,error) in
                if error != nil{
                    print("login error")
                }
                else{
                    let activeVC = self.storyboard?.instantiateViewController(withIdentifier: "contactsVC")as! ActiveContactTableViewController
                    self.navigationController?.pushViewController(activeVC, animated: true)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = UIImage(named: "logoImg")
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 255/255, alpha: 0.7)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
