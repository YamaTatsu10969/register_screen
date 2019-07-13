//
//  Response.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

public enum Response {
    case json(_: Data)
    case error(_: APIError?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        guard response.r?.statusCode == 200 , response.error == nil else {
            if let data = response.data{
                let url = response.r?.url?.absoluteString ?? ""
                let log = (String(data: data, encoding: String.Encoding.utf8) ?? "") + url
                debugPrint(log)
                let apiError = APIError(response.r!.statusCode)
                self = .error(apiError)
            } else {
                self = .error(APIError.unexpecteedError)
            }
            return
        }
        
        guard let data = response.data else {
            self = .error(APIError.unexpecteedError)
            return
        }
        
        let url = response.r?.url?.absoluteString ?? ""
        let log = (String(data: data, encoding: String.Encoding.utf8) ?? "") + url
        debugPrint(log)
        
        switch request.dataType {
        case .JSON:
            self = .json(data)
        }
    }
}
