//
//  Logout.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 11/11/23.
//

import Foundation

class Constants{
    let keyChain = KeyChain()
    
    func removeLocal (){
        
        if var token = keyChain.getToken(), !token.isEmpty {
            // El token existe y no está vacío
            print("Hay token en LogOutButom \(token)")
            keyChain.deleteToken(token: token)
            
            token = ""
            print("Borro token  \(token)")
            
            
        } else {
            // El token no existe o está vacío
            print("No hay token en LogOutButom")

        }
    }
    
    
    
    
    
    
}
