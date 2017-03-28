//
//  ViewController.swift
//  SampleConstraint
//
//  Created by Saraschandra on 07/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class ObjectiveVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var aCollectionView: UICollectionView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var transparentBtn: UIButton!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var popupXConstraint: NSLayoutConstraint!
    
    var indexPath: NSIndexPath!
    var cell = ObjectiveCell()
    
    var data = [ObjectVCCellModel]()
  
    var testTimer : Timer?

    //var countArr = ["1st Label","2nd Label","3rd Label","4th Label","5th Label","6th Label"]
    
    var anotherStr = "We as a company collaboratively provide strategic solution and Deliver Impeccable digital experience to fulfill business requirements."
    let arr : NSMutableArray = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //objectiveDict = ["1st Label" : str, "2nd Label" : str, "3rd Label" : str, "4th Label" : str, "5th Label" : str, "6th Label": str]
        
        let dict1 :NSDictionary = ["count":"1st Label" ,"another":anotherStr]
        let dict2 :NSDictionary = ["count":"2nd Label" ,"another":anotherStr]
        let dict3 :NSDictionary = ["count":"3rd Label" ,"another":anotherStr]
        let dict4 :NSDictionary = ["count":"4th Label" ,"another":anotherStr]
        let dict5 :NSDictionary = ["count":"5th Label" ,"another":anotherStr]
        let dict6 :NSDictionary = ["count":"6th Label" ,"another":anotherStr]
        
        arr.add(dict1)
        arr.add(dict2)
        arr.add(dict3)
        arr.add(dict4)
        arr.add(dict5)
        arr.add(dict6)
    
        print(arr)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ObjectiveVC.startTimer), name: NSNotification.Name(rawValue: "STARTTIMER"), object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(ObjectiveVC.stopTimer), name: NSNotification.Name(rawValue: "STOPTIMER"), object: nil);
        
        self.aCollectionView.showsHorizontalScrollIndicator = false
        self.aCollectionView.isPagingEnabled = true
        
        self.normalDataAction()
        
        //startTimer()
        
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        aCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
    }
    
    func normalDataAction()
    {
      for item in self.arr
      {
        if let ovccModel = ObjectVCCellModel(data: item as? [String: String])
        {
          self.data.append(ovccModel)
        }
      }
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
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MYCELL", for: indexPath) as! ObjectiveCell
        
        cell.configureWithItem(item: data[indexPath.item])
        
        //cell.countLabel?.text = countArr[indexPath.row] + "naveen@mobiwareinc.com ILabs Center"
        //cell.anotherLabel?.text = anotherStr
        
        cell.cancelBtn .addTarget(self, action: #selector(self.cancelButtonTapped(sender:)), for: .touchUpInside)
        cell.submitBtn .addTarget(self, action: #selector(self.submitButtonTapped(sender:)), for: .touchUpInside)
        
        cell.pageControl.currentPage = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if indexPath.row == data.count - 1
        {
            print("Last cell will appear")
            
            imageFadeIn(imageView: bgImageView)
            
        }
    }
    
    //UIScrollViewDelegate Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
       // print("Scroll")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        print("EndDecelerating")
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        print("EndDragging")
    }
    
    //UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width:aCollectionView.frame.width,height:aCollectionView.frame.height)
        
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
    
    
    func startTimer()
    {
       testTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true);
    }
    
    func stopTimer()
    {
        testTimer?.invalidate()
    }
    
    func scrollToNextCell()
    {
      //get cell size
      let cellSize = CGSize(width:cell.frame.width,height:cell.frame.height);
            
      //get current content Offset of the Collection view
      let contentOffSetValue : CGPoint?
      contentOffSetValue = aCollectionView.contentOffset
      
        //Move to next cell
      aCollectionView.scrollRectToVisible(CGRect(x:(contentOffSetValue?.x)! + cellSize.width, y:(contentOffSetValue?.y)!, width:cellSize.width, height:cellSize.height), animated: true);


    }
    
    //Orientation changed,this Method is called
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        
        aCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    //Cancel Button Action
    
    func cancelButtonTapped(sender: AnyObject)
    {
        if let button = sender as? UIButton
        {
            if let superview = button.superview
            {
                if let cell = superview.superview?.superview?.superview as? ObjectiveCell
                {
                    indexPath = aCollectionView.indexPath(for: cell) as NSIndexPath!
                    //print(indexPath.row+1 "(\cancel button)")
                    print("Cancel Button At \(indexPath.row+1) Row")
                   
                }
            }
        }
    }
    
    //submit Button Action
    
    func submitButtonTapped(sender: AnyObject)
    {
        popupXConstraint.constant = 0
        transparentBtn.alpha = 0.5
    }
    func imageFadeIn(imageView: UIImageView)
    {
        
        let secondBgImageView = UIImageView(image: UIImage(named: "bg02.png"))
        secondBgImageView.frame = view.frame
        secondBgImageView.alpha = 0.0
        
        view.insertSubview(secondBgImageView, aboveSubview: imageView)
        
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: {
            secondBgImageView.alpha = 1.0
        }, completion: {_ in
            imageView.image = secondBgImageView.image
            secondBgImageView.removeFromSuperview()
        })
        
    }

    @IBAction func transparentBtnAction(_ sender: Any)
    {
        popupXConstraint.constant = -1000
        transparentBtn.alpha = 0
    }
    
    deinit
    {
        
    }
    
}
