//
//  Operation.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/12.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

protocol Operation {
    associatedtype Output
    
    var request: Request { get }
    
    func execute(in dispatcher: Dispatcher) -> Promise<Output>
}
