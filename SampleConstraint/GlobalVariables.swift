//
//  GlobalVariables.swift
//  SampleConstraint
//
//  Created by Saraschandra on 17/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class GlobalVariables: NSObject
{
    class var sharedManager: GlobalVariables
    {
        struct Singleton
        {
            static let instance = GlobalVariables()
        }
        return Singleton.instance
    }
}
