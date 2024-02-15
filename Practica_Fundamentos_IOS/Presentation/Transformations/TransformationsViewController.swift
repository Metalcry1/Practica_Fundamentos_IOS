//
//  TransformationsViewController.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 10/11/23.
//

import UIKit

class TransformationsViewController: UIViewController {
    //MARK: - CONSTANTS -
    let apiProvider = ApiProvider()
    let keyChain = KeyChain()
    
    //MARK: - VARIABLES -
    private var hero: Hero?
    private var transformations: Transformations = []
    var transformationsCount: Int {
        transformations.count
    }
    //MARK: - INIT -
    init(hero: Hero?) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OUTLETS -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Transformaciones"

        tableView?.register(
            UINib(nibName: TransformationsViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: TransformationsViewCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self

        onViewAppear()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
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
        guard let token = keyChain.getToken() else {
            print("No se encuentra token en el keyChain")
            return
        }
        
        guard let hero = hero else {
            print("Error: Hero is nil")
            return
        }
        
        self.apiProvider.getTransformations(by: hero, token: token) { transformations in
            self.transformations = transformations
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func transformationBy(index: Int) -> Transformation? {
        if index >= 0 && index < transformationsCount {
            return transformations[index]
        } else {
            return nil
        }
    }
}

//MARK: - EXTENSIONS -
extension TransformationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransformationsViewCell.identifier, for: indexPath) as? TransformationsViewCell else {
            return UITableViewCell()
        }
        
        if let transformation = transformationBy(index: indexPath.row) {
            cell.updateView(
                name: transformation.name,
                photo: transformation.photo,
                description: transformation.description
            )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        TransformationsViewCell.sizeCell
    }
}
