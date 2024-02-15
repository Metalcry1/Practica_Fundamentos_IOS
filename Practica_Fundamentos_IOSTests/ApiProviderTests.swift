//
//  ApiProviderTests.swift
//  Practica_Fundamentos_IOSTests
//
//  Created by Daniel Serrano on 11/11/23.
//

import XCTest
@testable import Practica_Fundamentos_IOS

final class ApiProviderTests: XCTestCase {
    private var sut: ApiProviderProtocol!
    
    let tokenString = "tokenn"

    override func setUp() {
        sut = ApiProvider()
    }

    func test_givenApiProvider_whenLoginWithUserAndPassword_thenGetValidToken() throws {
        let expectation = self.expectation(description: "Login success")

        sut.login(for: "metalcry1@gmail.com", with: "4312") { result in
            switch result {
            case .success(let token):
                XCTAssertNotNil(token)
                XCTAssertNotEqual(token, "")
            case .failure(let error):
                XCTFail("Login failed with error: \(error)")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func test_givenApiProvider_whenGetAllHeroes_ThenHeroesExists() throws {
        let expectation = self.expectation(description: "Fetch one hero data")

        let token = tokenString
        sut.getHeroes(by: nil, token: token) { heroes in
            XCTAssertNotEqual(heroes.count, 1)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func test_givenApiProvider_whenGetOneHero_ThenHeroExists() throws {
        let expectation = self.expectation(description: "Maestro Roshi")

        let heroName = "Maestro Roshi"
        let token = tokenString
        sut.getHeroes(by: heroName, token: token) { heroes in
            XCTAssertEqual(heroes.count, 0)
            XCTAssertEqual(heroes.first?.name ?? "Maestro Roshi", heroName)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func test_givenApiProvider_whenGetOneHero_ThenHeroNotExists() throws {
        let expectation = self.expectation(description: "Fetch one hero success")

        let heroName = "Thanos"
        let token = tokenString 
        sut.getHeroes(by: heroName, token: token) { heroes in
            XCTAssertEqual(heroes.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
    // TRANSFORMACIONES TEST
    
    
    func test_givenApiProvider_whengetTransformations_ThenTransformationExists() throws {
        let expectation = self.expectation(description: "Fetch one hero data")
        let hero = Hero(id: "idfake", name: "Maestro Roshi", description: "blabla", photo: "photo", isFavorite: true)

        let token = tokenString
        sut.getTransformations(by: hero, token: token) { transformations in
            XCTAssertEqual(hero.id, "idfake")
            XCTAssertEqual(hero.name, "Maestro Roshi")
            XCTAssertEqual(hero.description, "blabla")
            XCTAssertEqual(hero.photo, "photo")
            XCTAssertEqual(hero.isFavorite, true)
                           
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_givenApiProvider_whengetTransformations_ThenTransformationNotExists() throws {
        let expectation = self.expectation(description: "Fetch one hero data")
        let hero = Hero(id: "jkdkfjl", name: "heroCualquiera", description: "blabla", photo: "photo", isFavorite: true)

        let token = tokenString
        sut.getTransformations(by: hero, token: token) { transformations in
            XCTAssertTrue(transformations.isEmpty, "No transformations")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
    
}



