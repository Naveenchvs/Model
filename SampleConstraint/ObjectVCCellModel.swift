//
//  ObjectVCCellModel.swift
//  SampleConstraint
//
//  Created by Saraschandra on 24/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class ObjectVCCellModel: NSObject
{
    var count: String?
    var another: String?
    
    init?(data: [String: String]?)
    {
        if let data = data, let count = data["count"], let another = data["another"]
        {
            self.count = count
            self.another = another

        }
        else
        {
            return nil
        }
    }

}
