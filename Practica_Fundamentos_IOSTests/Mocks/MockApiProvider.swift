//
//  MockApiProvider.swift
//  Practica_Fundamentos_IOSTests
//
//  Created by Daniel Serrano on 11/11/23.
//

import Foundation
import Practica_Fundamentos_IOS

//func login(for user: String, with password: String, completion: @escaping () -> Void)
//func getHeroes(by name: String?, token: String, completion: ((Heroes) -> Void)?)
//func getTransformations(by hero: Hero, token: String, completion: ((Transformations) -> Void)?)


class MockApiService {
    
    private let responseToken: String = "token"
    private let responseDataHeroes: [[String: Any]] = [
        [
            "id": "D13A40E5-4418-4223-9CE6-D2F9A28EBE94",
            "name": "Goku",
            "description": "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
            "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
            "favorite": false
        ],
        [
            "id": "6E1B907C-EB3A-45BA-AE03-44FA251F64E9",
            "name": "Vegeta",
            "description": "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.",
            "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
            "favorite": false
        ]
    ]
    
    private let responseDataTransformations: [[String: Any]] = [
        [
            "id": "17824501-1106-4815-BC7A-BFDCCEE43CC9",
            "name": "1. Oozaru – Gran Mono",
            "description": "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru",
            "hero": [
                "id": "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
            ],
            "photo": "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp"
        ]
    ]
    
    required init(keyChain: Practica_Fundamentos_IOS.KeychainProtocol) {}
    
    
    func login(for user: String, with password: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Simular el proceso de inicio de sesión
        print("Simulating login for user: \(user)")

    
        if user == "d.jardon@gmail.com" && password == "120485" {
            let accessToken = "mockAccessToken"
            completion(.success(accessToken))
        } else {
            // Credenciales inválidas
            let error = NSError(domain: "com.example.MockApiService", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
            completion(.failure(error))
        }
    }

    
    func getHeroes(by name: String?, token: String, completion: ((Practica_Fundamentos_IOS.Heroes) -> Void)?) {
        do {
            let data = try JSONSerialization.data(withJSONObject: responseDataHeroes)
            let heroes = try? JSONDecoder().decode([Hero].self,
                                                   from: data)
            
            if let name {
                completion?(heroes?.filter { $0.name == name } ?? [])
            } else {
                completion?(heroes ?? [])
            }
        } catch {
            completion?([])
        }
    }
    
    func getTransformations(by hero: Hero, token: String, completion: ((Practica_Fundamentos_IOS.Transformations) -> Void)?) {
        do {
            let data = try JSONSerialization.data(withJSONObject: responseDataTransformations)
            let transformations = try JSONDecoder().decode([Transformation].self, from: data)

            if let heroId = hero.id {
                let filteredTransformations = transformations.filter { $0.hero?.id == heroId }
                completion?(filteredTransformations)
            } else {
                completion?(transformations)
            }
        } catch {
            completion?([])
        }
    }


    

}
