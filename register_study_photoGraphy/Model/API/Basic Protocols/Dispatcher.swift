//
//  Dispatcher.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

public protocol Dispatcher {
    
    init(environment: Environment)
    
    func execute(request: Request) throws -> Promise<Response>
}
