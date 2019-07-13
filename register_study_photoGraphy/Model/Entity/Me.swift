//
//  Me.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

final class Me {
    static func myUserInfo() -> User? {
        guard let data = UserDefaults.standard.object(forKey: CacheKey.myInfo) as? Data else {
            return nil
        }
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            return nil
        }
    }
}
