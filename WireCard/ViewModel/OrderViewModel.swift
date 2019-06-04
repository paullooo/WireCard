//
//  OrderViewModel.swift
//  WireCard
//
//  Created by Claro on 02/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import UIKit

struct SummaryUI {
    let summary: Summary?
}

enum OrderStatus: String {
    case reverted = "REVERTED"
    case waiting = "WAITING"
    case paid = "PAID"
    
    var formated: String {
        switch self {
        case .reverted:
            return "NÃO PAGO"
        case .waiting:
            return "AGUARDANDO"
        case .paid:
            return "PAGO"
        }
    }
    
    var color: UIColor {
        switch self {
        case .reverted:
            return UIColor.init(red: 255/255, green: 82/255, blue: 82/255, alpha: 1)
        case .waiting:
            return UIColor.init(red: 225/255, green: 214/255, blue: 0/255, alpha: 1)
        case .paid:
            return UIColor.init(red: 0/255, green: 200/255, blue: 83/255, alpha: 1)
        }
    }
}

class OrderViewModel {
    private let orderBusiness: OrderBusiness = OrderBusiness()
    var completion: (OrderState) -> Void = { _ in }
    var orders: [OrderElement] = []
    var orderDetail: OrderDetail?
    
    enum OrderState {
        case failure(Error)
        case success
        case detailSuccess
    }
    
    func listOrders() {
        orderBusiness.getOrders { [weak self] result in
            if let ordersResult = result.data?.orders {
                ordersResult.forEach({ order in
                    self?.orders.append(order)
                })
                self?.completion(.success)
            } else {
                self?.completion(.failure(result.error!))
            }
        }
    }
    
    func orderDetail(id: String) {
        orderBusiness.orderDetail(id: id) { [weak self] result in
            if let detail = result.data {
                self?.orderDetail = detail
                self?.completion(.detailSuccess)
            } else {
                self?.completion(.failure(result.error!))
            }

        }
    }
}
