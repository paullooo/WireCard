//
//  OrderDetail.swift
//  WireCard
//
//  Created by Claro on 03/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation

public struct OrderDetail: Codable {
    let id, ownID, status, platform: String
    let createdAt, updatedAt: String
    let customer: CustomerDetail
    let amount: OrderDetailAmount
    let payments: [PaymentDetail]

    enum CodingKeys: String, CodingKey {
        case id, status, platform
        case ownID = "ownId"
        case createdAt, updatedAt
        case amount, customer
        case payments
    }

}

struct OrderDetailAmount: Codable {
    let paid, total, fees, refunds: Int
    let liquid, otherReceivers: Int
    let currency: String
    let subtotals: Subtotals
}

struct Subtotals: Codable {
    let shipping, addition, discount, items: Int
}

struct CustomerDetail: Codable {
    let id, ownID, fullname, createdAt: String
    let birthDate, email: String
    let phone: Phone
    let taxDocument: TaxDocument
    let addresses: [Address]?
    let shippingAddress: Address
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownID = "ownId"
        case addresses = "addresses"
        case fullname, createdAt, birthDate, email, phone, taxDocument, shippingAddress
    }
}

struct Phone: Codable {
    let countryCode, areaCode, number: String
}

struct TaxDocument: Codable {
    let type, number: String
}

struct Address: Codable {
    let streetNumber, street, city: String
    let complement: String?
    let district, zipCode, state: String
    let type: String?
    let country: String
}

struct PaymentDetail: Codable {
    let id, status: String
    let amount: PaymentAmount
    
    enum CodingKeys: String, CodingKey {
        case id, status
        case amount
    }
}

struct PaymentAmount: Codable {
    let total, gross, fees, refunds: Int
    let liquid: Int
    let currency: String
}


