//
//  User.swift
//  kumparan test
//
//  Created by Maurice Tin on 12/02/22.
//

import Foundation

class User: Codable{
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

class Address: Codable{
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

class Geo: Codable{
    let lat: String
    let lng: String
}

class Company: Codable{
    let name: String
    let catchPhrase: String
    let bs: String
}



