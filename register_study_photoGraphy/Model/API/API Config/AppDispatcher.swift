//
//  AppDispatcher.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

final class AppDispatcher {
    static func appDispatcher() ->Dispatcher {
        let dispatcher = NetworkDispatcher(environment: AppEnviroment.appEnviroment())
        return dispatcher
    }
}
