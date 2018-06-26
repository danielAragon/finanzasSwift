//
//  User.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/11/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation

class User{
    private static var _sharedInstance = User()
    
    static var sharedInstance: User{
        return _sharedInstance
    }
    var bonos: [Bono] = []
    
}
