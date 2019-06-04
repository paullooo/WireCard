//
//  WireCardAPI.swift
//  WireCard
//
//  Created by Paulo Pereira on 28/05/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import Moya

enum SignInAPI {
    case login(username: String, password: String)
}

extension SignInAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://connect-sandbox.moip.com.br/")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "oauth/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["client_id":"APP-H1DR0RPHV7SP",
                                                   "client_secret":"05acb6e128bc48b2999582cd9a2b9787",
                                                   "grant_type":"password",
                                                   "username":username,
                                                   "password":password,
                                                   "device_id":UIDevice.current.identifierForVendor!.uuidString,
                                                   "scope":"APP_ADMIN"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
