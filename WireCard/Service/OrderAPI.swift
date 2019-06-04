//
//  OrderAPI.swift
//  WireCard
//
//  Created by Claro on 01/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import Moya


enum OrderAPI {
    case getOrders
    case getOrderDetail(id: String)
}

extension OrderAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://sandbox.moip.com.br/v2/")!
    }
    
    var path: String {
        switch self {
        case .getOrders:
            return "orders"
        case .getOrderDetail(let id):
            return "orders/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getOrders:
            return .get
        case .getOrderDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getOrders:
            return .requestParameters(parameters: ["":""], encoding: URLEncoding.default)
        case .getOrderDetail:
            return .requestParameters(parameters: ["":""], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = UserDefaults.standard.object(forKey: "access_token") as? String ?? ""
        return ["Authorization":"OAuth \(accessToken)"]
    }
}
