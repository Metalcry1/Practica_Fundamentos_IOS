//
//  KeyChain.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 6/11/23.
//

import Foundation
import KeychainSwift

public protocol KeychainProtocol{
    
    func save(token: String)
    func getToken() -> String?
}

final class KeyChain: KeychainProtocol {
    private let keychain = KeychainSwift()
    
    private enum Key {
        static let token = "KEY_KEYCHAIN_TOKEN"
    }
    
    func save(token: String) {
        keychain.set(token, forKey: Key.token)
    }
    
    func getToken() -> String? {
        keychain.get(Key.token)
        
    }
    
    func deleteToken(token: String) {
        keychain.delete(Key.token)
    }
}
