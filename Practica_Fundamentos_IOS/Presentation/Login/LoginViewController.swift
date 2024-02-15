//
//  LoginViewController.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 6/11/23.
//

import UIKit


class LoginViewController: UIViewController {
    
    //MARK: - CONSTANTS -
    private let apiProvider = ApiProvider()
    private let keyChain = KeyChain()
    
    //MARK: - OULETS -
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginBotomOulet: UIButton!
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        checkToken()
        loginBotomOulet.isEnabled = true
    }
    
    //MARK: - ACTIONS -
    @IBAction func loginBotomAction(_ sender: Any) {
        botomLoginPress(
            email: emailField.text,
            password: passwordField.text)
    }
    
    //MARK: - FUNTIONS -
    
    func checkToken(){
        
        if let token = keyChain.getToken() {
            // Ya hay un token en el KeyChain
            DispatchQueue.main.async {
                let heroesTableViewController = HeroesTableViewController()
                self.navigationController?.pushViewController(heroesTableViewController, animated: true)
            }
        }
    }
    
    func botomLoginPress(email: String?, password: String?) {
        guard isValid(email: email) else {
            showAlert(title: "Error de correo", message: "El correo no está completo", LoginViewController: self)
            loginBotomOulet.isEnabled = true
            return
        }
        
        guard isValid(password: password) else {
            showAlert(title: "Error de contraseña", message: "El campo de contraseña está vacío o es demasiado corto", LoginViewController: self)
            return
        }
        // No hay token en el KeyChain, realiza el inicio de sesión
        apiProvider.login(for: email ?? "", with: password ?? "") {_ in
            // Manejar el resultado del inicio de sesión
            if let token = self.keyChain.getToken() {
                DispatchQueue.main.async {
                    let heroesTableViewController = HeroesTableViewController()
                    self.navigationController?.pushViewController(heroesTableViewController, animated: true)
                }
            }
        }
    }
    
    
    func isValid(email: String?) -> Bool {
        email?.isEmpty == false && (email?.contains("@") ?? false)
    }
    
    func isValid(password: String?) -> Bool {
        password?.isEmpty == false && (password?.count ?? 0) >= 4
    }
    
    func showAlert(title: String, message: String, LoginViewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(action)
        LoginViewController.present(alert, animated: true, completion: nil)
    }
}



