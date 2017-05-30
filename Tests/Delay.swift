//
//  Delay.swift
//  Reach
//
//  Created by sergio on 22/05/2017.
//  Copyright © 2017 nc43tech. All rights reserved.
//

import Foundation

internal func delay(_ duration: TimeInterval, block: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
        block()
    })
}
