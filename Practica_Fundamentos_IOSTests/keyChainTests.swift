//
//  SecureDataProvideTests.swift
//  Practica_Fundamentos_IOSTests
//
//  Created by Daniel Serrano on 11/11/23.
//

import XCTest
@testable import Practica_Fundamentos_IOS

final class KeyChainTests: XCTestCase {
    private var sut: KeychainProtocol!

    override func setUp() {
        sut = KeyChain()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_givenKeyChain_whenLoadToken_thenGetStoredToken() throws {
        let token = "123456abcde"
        sut.save(token: token)
        let tokenLoaded = sut.getToken()
        XCTAssertEqual(token, tokenLoaded)

        XCTAssertEqual(token, tokenLoaded)
    }
}

