//
//  HeroesTableViewController.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 6/11/23.
//

import UIKit

class HeroesTableViewController: UIViewController {
    //MARK: - CONSTANTS -
    let apiProvider = ApiProvider()
    let keyChain = KeyChain()
    
    //MARK: - VARIABLES -
    private var heroes: Heroes = []
    var heroesCount: Int {heroes.count}
    
    //MARK: - OUTLETS -
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        
        tableView.register(
            UINib(nibName: HeroesViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HeroesViewCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        onViewAppear()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }
    
    //MARK: - FUNTIONS -
    @objc func logout() {
        print("LOGOUT")
        if Constants().removeLocal() != nil{
            goToLogin()
        }
    }
    
    func onViewAppear() {
        guard let token = keyChain.getToken() else {
            print("No se encuentra token en el keyChain")
            return
        }
        
        self.apiProvider.getHeroes(by: nil, token: token) { heroes in
            self.heroes = heroes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func heroBy(index: Int) -> Hero? {
        if index >= 0 && index < heroesCount {
            return heroes[index]
        } else {
            return nil
        }
    }
    
    func goToLogin(){
        
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    
}
//MARK: - EXTENSIONS -
extension HeroesTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroesViewCell.identifier, for: indexPath) as? HeroesViewCell else {
            return UITableViewCell()
        }
        
        if let hero = heroBy(index: indexPath.row) {
            cell.updateView(
                id: hero.id,
                name: hero.name,
                photo: hero.photo,
                description: hero.description
                
            )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        HeroesViewCell.sizeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = heroes[indexPath.row]
        let detailViewController = DetailViewController(hero: hero)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
