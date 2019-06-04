//
//  Order.swift
//  WireCard
//
//  Created by Claro on 01/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation

public struct Order: Codable {
    let summary: Summary
    let orders: [OrderElement]
}

// MARK: - OrderElement
struct OrderElement: Codable {
    let id, ownID, status: String
    let blocked: Bool
    let amount: Amount
    let receivers: [Receiver]
    let customer: Customer
    let items: [Item]
    let payments: [Payment]
    let events: [Event]
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownID = "ownId"
        case status, blocked, amount, receivers, customer, items, payments
        case events = "events"
        case createdAt
    }
}

// MARK: - Amount
struct Amount: Codable {
    let total, addition, fees, deduction: Int
    let otherReceivers: Int
    let currency: String
}

// MARK: - Customer
struct Customer: Codable {
    let fullname, email: String
}

// MARK: - Event
struct Event: Codable {
    let type: String
    let createdAt: String
}

// MARK: - Item
struct Item: Codable {
    let product: JSONNull?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: SelfClass
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "_links"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
}

// MARK: - Payment
struct Payment: Codable {
    let id: String
    let installmentCount: Int
    let fundingInstrument: FundingInstrument
}

// MARK: - FundingInstrument
struct FundingInstrument: Codable {
    let method, brand: String?
}

// MARK: - Receiver
struct Receiver: Codable {
    let type: String
    let moipAccount: MoipAccount
}

// MARK: - Summary
struct Summary: Codable {
    let count, amount: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
