//
//  swiftCell.swift
//  SampleConstraint
//
//  Created by Saraschandra on 17/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class swiftCell: UICollectionViewCell
{
    
    @IBOutlet weak var transparentLayer: UIView!
    @IBOutlet weak var productCodeLabel: UILabel!
    @IBOutlet weak var productItemSizeLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        
        transparentLayer.layer.cornerRadius = 16
        transparentLayer.layer.shadowColor = UIColor.black.cgColor
        transparentLayer.layer.shadowOpacity = 1
        transparentLayer.layer.shadowOffset = CGSize.zero
        transparentLayer.layer.shadowRadius = 10
        
        
    }
    
    func configureWithItem(item: SwiftVCCellModel)
    {
        productCodeLabel?.text = item.code
        productItemSizeLabel?.text = item.size
       
    }
}
