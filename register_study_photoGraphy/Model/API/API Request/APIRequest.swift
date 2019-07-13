//
//  APIRequest.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//


enum APIRequest: Request {
    
    case signUp(name: String, gender: Int, area: String, age: String, bio: String?)

    public var path: String {
        switch self {
        case .signUp:
            return "v1/sign_up"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .signUp(let name, let gender, let area, let age, let bio):
            var params = [String:Any]()
            var userAttributes = [String:Any]()
            userAttributes["name"] = name
            userAttributes["gender"] = gender
            userAttributes["area"] = area
            userAttributes["age"] = age
            userAttributes["bio"] = bio
            params["user"] = userAttributes
            return .body(params)
        }
    }
    
    var headers: [String : Any]? {
        switch self {
        case .signUp:
            return nil
        }
    }
    
    var dataType: DataType {
        switch self {
        case .signUp:
            return .JSON
        }
    }
    
    
    
}
