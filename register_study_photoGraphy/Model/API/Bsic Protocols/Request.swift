//
//  Request.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

public enum DataType {
    case JSON
}

public protocol Request {
    var path: String { get }
    var method : HTTPMethod { get }
    var parameters : RequestParams { get }
    var headers : [String: Any]? { get }
    var dataType: DataType { get }
}


public enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum RequestParams {
    case none
    case body(_: [String:Any]?)
    case url(_:[String:Any]?)
    case multiPart(_ name:String, fileName: String, mimeType:String, data: Data)
}
