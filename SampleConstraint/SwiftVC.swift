//
//  SecondVC.swift
//  SampleConstraint
//
//  Created by Saraschandra on 09/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit
import CoreData

class SwiftVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var bCollectionView: UICollectionView!
    
    var cell = swiftCell()
   
    var data = [SwiftVCCellModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SwiftVC.jsonDataAction), name: NSNotification.Name(rawValue: "JSONDATA"), object: nil)
        
        self.bCollectionView.showsVerticalScrollIndicator = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        bCollectionView.collectionViewLayout.invalidateLayout()
        
        self.view.makeToastActivity(position: "Center" as AnyObject , message: "Loading...")
        
        WebServices.sharedManager.requestData()

    }

    //UICollectionView Data Source Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MYCELL", for: indexPath) as! swiftCell
        
        cell.configureWithItem(item: data[indexPath.item])
        
        return cell
    
    }
    
    //UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width:bCollectionView.frame.width,height:100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        
        bCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func jsonDataAction(response:NSNotification)
    {
        if let responseArr = response.object as? NSArray
        {
            for item in responseArr
            {
              if let svccModel = SwiftVCCellModel(data: item as? [String: String])
              {
                self.data.append(svccModel)
                
              }
            }
            DispatchQueue.main.async
            {
                self.bCollectionView.reloadData()
                self.view.hideToastActivity()
            }
        }
    }
    
}
