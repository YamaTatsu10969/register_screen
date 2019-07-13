//
//  AppEnviroment.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

final class AppEnviroment {
    static func appEnviroment() ->Environment {
        var em: Environment!
        #if DEBUG
        em = Environment("app_debug", host: "apiUrl")
        #else
        em = Environment("app_production", host: "apiUrl")
        #endif
        em.headers = [
            "Accept":"application/json",
            "Content-Type": "application/json"
        ]
        return em
    }
}
