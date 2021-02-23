//
//  SignUpViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        emailTextField.layer.borderColor = UIColor(named: K.GREY)!.cgColor
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        signUpButton.backgroundColor = UIColor(named: K.GREY)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text {
            Auth.auth().createUser(withEmail: email, password: K.PSW) { authResult, error in
                if let error = error, let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    case .invalidEmail:
                        let alert = UIAlertController(title: K.ERROR, message: K.BADLY_FORMATTED, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:  K.OK_LABEL_BUTTON, style: .default, handler: nil))
                        self.present(alert, animated: true)
                        return
                    case .emailAlreadyInUse:
                        let alert = UIAlertController(title: K.ERROR, message: K.ALREADY_USES, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:  K.OK_LABEL_BUTTON, style: .default, handler: nil))
                        self.present(alert, animated: true)
                        return
                    default:
                        print(errorCode)
                    }
                } else {
                    let alert = UIAlertController(title: K.SUCCESSFULL_TITLE, message: K.SUCCESSFULL_MESSAGE, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:  K.OK_LABEL_BUTTON, style: .default, handler: { (_) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            textField.layer.borderColor = UIColor(named: K.BLUE)!.cgColor
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(named: K.BLUE)
        } else {
            textField.layer.borderColor = UIColor(named: K.GREY)!.cgColor
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(named: K.GREY)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
