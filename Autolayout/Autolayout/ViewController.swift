//
//  ViewController.swift
//  Autolayout
//
//  Created by robot on 2/24/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //dismissing the keyboard on tap
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        loginField.delegate = self; //delegating the keyboard dismissal on return
        passwordField.delegate = self; //delegating the keyboard dismissal on return
        updateUI();
    }
    
    var loggedInUser: User? {
        didSet {
            updateUI();
        }
    }
    var secure = false {
        didSet {
            updateUI();
        }
    }
    
    private func updateUI() {
        passwordField.isSecureTextEntry = secure;
        passwordLabel.text = secure ? "Secured Password" : "Password";
        nameLabel.text = loggedInUser?.name;
        companyLabel.text = loggedInUser?.company;
    }
    
    
    @IBAction func login() {
         loggedInUser = User.login(login: loginField.text ?? "", password: passwordField.text ?? "");
        if loggedInUser == nil {
            nameLabel.text = "Error";
            companyLabel.text = "This user is not found";
        }
           
    }
    @IBAction func toggleSecurity() {
        secure = !secure;
    }
    //hiding the keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == loginField {
         textField.resignFirstResponder()
         passwordField.becomeFirstResponder()
      } else {
        textField.resignFirstResponder();
        login();
        }
     return true
    }
}
