//
//  APIError.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case badRequest
    case unexpecteedError
    
    init(_ errorCode: Int) {
        if errorCode == 400 {
            self = .badRequest
        } else {
            self = .unexpecteedError
        }
    }
}

struct ErrorMessage {
    let errorMessage: String
    
    init(error: Error) {
        if case APIError.badRequest = error {
            errorMessage = "不正なリクエストです"
        } else if case APIError.unexpecteedError = error {
            errorMessage = "サーバーエラーです"
        } else {
            errorMessage = "サーバーエラーです"
        }
    }
}
