//
//  OrderBusiness.swift
//  WireCard
//
//  Created by Claro on 01/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import Moya

public class OrderBusiness {
    private let provider = MoyaProvider<OrderAPI>()
    public init() {}
    
    public func getOrders(callback: @escaping (Callback<Order>) -> Void) {
        provider.request(OrderAPI.getOrders) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try response.map(Order.self, using: JSONDecoder(), failsOnEmptyData: false)
                    callback(Callback(result: result))
                } catch let error {
                    if response.statusCode == 401 {
                        if let bundleID = Bundle.main.bundleIdentifier {
                            UserDefaults.standard.removePersistentDomain(forName: bundleID)
                        }
                        Router.login()
                    }
                    callback(Callback(error: error))
                }
            case let .failure(error):
                callback(Callback(error: error))
            }
        }
    }
    
    public func orderDetail(id: String, callback: @escaping (Callback<OrderDetail>) -> Void) {
        provider.request(OrderAPI.getOrderDetail(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try response.map(OrderDetail.self, using: JSONDecoder(), failsOnEmptyData: false)
                    callback(Callback(result: result))
                } catch let error {
                    if response.statusCode == 401 {
                        if let bundleID = Bundle.main.bundleIdentifier {
                            UserDefaults.standard.removePersistentDomain(forName: bundleID)
                        }
                        Router.login()
                    }
                    callback(Callback(error: error))
                }
            case .failure(_):
                break
            }
        }
    }
}
