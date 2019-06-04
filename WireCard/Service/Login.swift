//
//  Login.swift
//  WireCard
//
//  Created by Claro on 01/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation

struct Login: Decodable {
    let accessToken, loginAccessToken, expiresIn, refreshToken: String
    let loginRefreshToken, scope: String
    let moipAccount: MoipAccount
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case loginAccessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken
        case loginRefreshToken = "refresh_token"
        case scope, moipAccount
    }
}

struct MoipAccount: Codable {
    let id: String
}

