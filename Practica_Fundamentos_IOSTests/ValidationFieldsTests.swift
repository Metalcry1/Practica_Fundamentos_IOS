//
//  ValidationFieldsTests.swift
//  Practica_Fundamentos_IOSTests
//
//  Created by Daniel Serrano on 11/11/23.
//

import XCTest
@testable import Practica_Fundamentos_IOS

final class ValidationFieldsTests: XCTestCase {
    
    //SUT
    private var sut: LoginViewController!

    
    override  func setUp() {
        let secureData = KeyChain()
        sut = LoginViewController()
    }


    func test_givenValidEmail_whenIsValid_thenTrue() throws {
        let validEmail = "email@ejemplo.com"
        let isEmailValid = sut.isValid(email: validEmail)

        XCTAssertTrue(isEmailValid)
    }

    func test_givenValidEmail_whenNotValid_thenFalse() throws {
        let invalidEmail = "emailejemplo.com"
        let isEmailValid = sut.isValid(email: invalidEmail)

        XCTAssertFalse(isEmailValid)
    }
}
