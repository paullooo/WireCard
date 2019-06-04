//
//  LoginBusiness.swift
//  WireCard
//
//  Created by Claro on 01/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import Moya

public class LoginBusiness {
    private let provider = MoyaProvider<SignInAPI>()
    public init() {}
    
    public func login(username: String, password: String, callback: @escaping (Callback<[Any]>) -> Void) {
        provider.request(SignInAPI.login(username: username, password: password)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try response.map(Login.self, using: JSONDecoder(), failsOnEmptyData: false)
                    let accessToken = result.accessToken
                    let clientId = UserDefaults.standard.object(forKey: "client_id") as? String

                    UserDefaults.standard.set(accessToken, forKey: "access_token")
                    if clientId?.isEmpty ?? true {
                        let clientId = result.moipAccount.id
                        UserDefaults.standard.set(clientId, forKey: "client_id")
                    }
                    UserDefaults.standard.synchronize()
                    callback(Callback(result: result))
                } catch let error {
                callback(Callback(error: error))
                }
            case let .failure(error):
                callback(Callback(error: error))
            }
        }
    }

    
}
