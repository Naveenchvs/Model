//
//  CustomCell.swift
//  SampleConstraint
//
//  Created by Saraschandra on 08/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class ObjectiveCell: UICollectionViewCell
{
    
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTransparentView: UIView!
    
    @IBOutlet weak var countLabel: UILabel?
    @IBOutlet weak var anotherLabel: UILabel?
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //var vc = ViewController()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        
        aContainerView.backgroundColor = UIColor.clear
        
        //aTransparentView white background with alpha 0.4,done in stoaryboard.
        aTransparentView.layer.cornerRadius = 16
        aTransparentView.layer.shadowColor = UIColor.black.cgColor
        aTransparentView.layer.shadowOpacity = 1
        aTransparentView.layer.shadowOffset = CGSize.zero
        aTransparentView.layer.shadowRadius = 10
    }
    
    func configureWithItem(item: ObjectVCCellModel)
    {
        countLabel?.text = item.count
        anotherLabel?.text = item.another
        
    }
    
}
