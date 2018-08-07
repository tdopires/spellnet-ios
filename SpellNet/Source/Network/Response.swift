//
//  Response.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 06/08/18.
//  Copyright © 2018 Spellnet. All rights reserved.
//

import Foundation

enum Response<T> {
    case error(Error)
    case value(T)
}
