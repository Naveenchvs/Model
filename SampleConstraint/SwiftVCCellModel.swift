//
//  SwiftVCCellModel.swift
//  SampleConstraint
//
//  Created by Saraschandra on 24/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class SwiftVCCellModel: NSObject
{
    var code: String?
    var size: String?
    var quantity: String?
    
    init?(data: [String: String]?)
    {
        if let data = data, let code = data["ProductCode"], let size = data["ProductItemSize"], let quantity = data["Qty"]
        {
            self.code = code
            self.size = size
            self.quantity = quantity
        }
        else
        {
            return nil
        }
    }
}
