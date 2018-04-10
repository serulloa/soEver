//
//  ReuseIdentifier.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 3/4/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import Foundation
import UIKit

public protocol ReuseIdentifierInterface : class {
    static var defaultIdentifier : String { get }
}

public extension ReuseIdentifierInterface where Self : UIView {
    static var defaultIdentifier : String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
