//
//  DetailViewController.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 9/11/23.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - CONSTANTS -
    let apiProvider = ApiProvider()
    let keyChain = KeyChain()
    
    //MARK: - VARIABLES -
    private var hero: Hero?
    private var transformation: Transformation?
    private var transformationCheck: Transformations = []
    
    //MARK: - INIT -
    init(hero: Hero) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OUTLETS -
    @IBOutlet weak var heroPhoto: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var butomTransformations: UIButton!
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detalle"
        checkHeroTransformations()
        onViewAppear()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }
    
    //MARK: - ACTIONS -
    @IBAction func dipButomTransformations(_ sender: Any) {
        DispatchQueue.main.async {
            guard  self.hero != nil else {return}
            if self.keyChain.getToken() != nil {
                let transformationsViewController = TransformationsViewController(hero: self.hero)
                self.navigationController?.pushViewController(transformationsViewController, animated: true)
            }
        }
    }
    //MARK: - FUNTIONS -
    
    @objc func logout() {
        print("LOGOUT")
        if Constants().removeLocal() != nil{
            goToLogin()
        }
    }
    
    func goToLogin(){
        
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func onViewAppear() {
        guard keyChain.getToken() != nil else {
            print("No se encuentra token en el keyChain")
            return
        }
        
        updateViews(hero: hero)
    }
    
    func updateViews(hero: Hero?) {
        heroPhoto.kf.setImage(with: URL(string: hero?.photo ?? ""))
        heroName.text = hero?.name
        heroDescription.text = hero?.description
        butomTransformations.isHidden = true
    }
    
    func checkHeroTransformations() {
        guard let token = keyChain.getToken(), let hero = hero else {
            print("No se encuentra token en el keyChain o Hero es nil")
            return
        }
        
        self.apiProvider.getTransformations(by: hero, token: token) { transformations in
            self.transformationCheck = transformations
            
            DispatchQueue.main.async {
                if !self.transformationCheck.isEmpty{
                    self.butomTransformations.isHidden = false
                }
            }
        }
    }
}
