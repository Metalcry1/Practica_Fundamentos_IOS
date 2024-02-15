//
//  ApiProvider.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 6/11/23.
//

import UIKit
public protocol ApiProviderProtocol {

    func login(for user: String, with password: String, completion: @escaping (Result<String, Error>) -> Void)
    func getHeroes(by name: String?, token: String, completion: ((Heroes) -> Void)?)
    func getTransformations(by hero: Hero, token: String, completion: ((Transformations) -> Void)?)
    
}

final class ApiProvider: ApiProviderProtocol {

    // MARK: - CONSTANTS -
    private let keyChain = KeyChain()
    static private let apiBaseURL = "https://dragonball.keepcoding.education/api"
    private enum Endpoint {
        static let login = "/auth/login"
        static let heroes = "/heros/all"
        static let transformations = "/heros/tranformations"
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidCredentials
        case invalidResponse
        case invalidToken
    }
    
    //MARK: - VARIABLES -
    var token: String? = "TOKEN"
    
    
    //MARK: - LOGIN -
    func login(for user: String, with password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(ApiProvider.apiBaseURL)\(Endpoint.login)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        guard let loginData = String(format: "%@:%@",
                                     user, password).data(using: .utf8)?.base64EncodedString() else {
            completion(.failure(NetworkError.invalidCredentials))            
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(loginData)",
                            forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let data,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let token = String(data: data, encoding: .utf8) else {
                completion(.failure(NetworkError.invalidToken))
                return
            }
                
            self.token = token
//            print("API RESPONSE - GET TOKEN: \(token)")
            self.keyChain.save(token: token)
            completion(.success(token))
        }.resume()
    }
    
    //MARK: - GET HEROES -
    func getHeroes(by name: String?, token: String, completion: ((Heroes) -> Void)?) {
        guard let url = URL(string: "\(ApiProvider.apiBaseURL)\(Endpoint.heroes)") else {
            // TODO: Enviar notificación indicando el error
            return
        }

        let jsonData: [String: Any] = ["name": name ?? ""]
        let jsonParameters = try? JSONSerialization.data(withJSONObject: jsonData)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json; charset=utf-8",
                            forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)",
                            forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = jsonParameters

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion?([])
                return
            }

            guard let data,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                // TODO: Enviar notificación indicando response error
                completion?([])
                return
            }

            guard let heroes = try? JSONDecoder().decode(Heroes.self, from: data) else {
                // TODO: Enviar notificación indicando response error
                completion?([])
                return
            }

//            print("API RESPONSE - GET HEROES: \(heroes)")
            completion?(heroes)
        }.resume()
    }
    
    //MARK: - GET TRANSFORMATIONS -
    func getTransformations(by hero: Hero, token: String, completion: ((Transformations) -> Void)?) {
        guard let url = URL(string: "\(ApiProvider.apiBaseURL)\(Endpoint.transformations)") else {
            // TODO: Enviar notificación indicando el error
            return
        }

        let jsonData: [String: Any] = ["id": hero.id ?? ""]
        let jsonParameters = try? JSONSerialization.data(withJSONObject: jsonData)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json; charset=utf-8",
                            forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)",
                            forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = jsonParameters

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                // TODO: Enviar notificación indicando el error
                completion?([])
                return
            }

            guard let data,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                // TODO: Enviar notificación indicando response error
                completion?([])
                return
            }

            guard let transformations = try? JSONDecoder().decode(Transformations.self, from: data) else {
                // TODO: Enviar notificación indicando response error
                completion?([])
                return
            }

//            print("API RESPONSE - GET TRANSFORMATIONS: \(transformations)")
            completion?(transformations)
        }.resume()
    }
    

}
