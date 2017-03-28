//
//  ContainerVC.swift
//  SampleConstraint
//
//  Created by Saraschandra on 14/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController
{
   @IBOutlet weak var aSegmentController: UISegmentedControl!
   @IBOutlet weak var containerView: UIView!
    
   var oVC : ObjectiveVC?
   var sVC : SwiftVC?
    
   override func viewDidLoad()
   {
       super.viewDidLoad()

       // load Storyboard
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

       // Instantiate View Controller
       oVC = storyboard.instantiateViewController(withIdentifier: "ObjectiveViewController") as? ObjectiveVC
       sVC = storyboard.instantiateViewController(withIdentifier: "SwiftViewController") as? SwiftVC
    
       setUpView()
    
   }
    
   override func viewWillAppear(_ animated: Bool)
   {
        super.viewWillAppear(animated)
    
        self.view.layoutIfNeeded()
   }

   func setUpView()
   {
        setUpSegmentController()
        updateView()
   }
    
   func setUpSegmentController()
   {
        aSegmentController.removeAllSegments()
        aSegmentController.insertSegment(withTitle : "Objective-c", at: 0, animated: false)
        aSegmentController.insertSegment(withTitle: "Swift", at: 1, animated: false)
        aSegmentController.addTarget(self, action:#selector(selectionDidChange(_:)) , for: .valueChanged)
        
        aSegmentController.selectedSegmentIndex = 0
    }
    
    func selectionDidChange(_ sender : UISegmentedControl)
    {
        updateView()
    }
    
     func updateView()
     {
       if aSegmentController.selectedSegmentIndex == 0
       {
          remove(removeAsChildVC: sVC!)
          add(addAsChildVC: oVC!)
        }
        else
        {
           remove(removeAsChildVC: oVC!)
           add(addAsChildVC: sVC!)
        }
      }
    

    func add(addAsChildVC viewController: UIViewController?)
    {
        
        // Add Child View as subview
        self.containerView.addSubview((viewController?.view)!)
        
        // set through constraints
        viewController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.setupConstraintsForChildViewController(viewController!)
        
        // Add Child View Controller
        addChildViewController(viewController!)
        
        // Notify Child View Controlelr
        viewController?.didMove(toParentViewController: self)
        
        // Post Notification as StartTimer
        if viewController == oVC
        {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "STARTTIMER"), object: nil)
        }
    }
    
    func remove(removeAsChildVC viewController: UIViewController)
    {
       
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
        
        // Post Notification as StopTimer
        if viewController == oVC
        {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "STOPTIMER"), object: nil)
        }
        
    }
    
    func setupConstraintsForChildViewController(_ child : UIViewController)
    {
        let topConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: child.view , attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: child.view, attribute: .leading, multiplier: 1, constant: 0)
        
        let trallingConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: child.view, attribute: .trailing, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: child.view, attribute: .bottom, multiplier: 1 , constant: 0)
        
        NSLayoutConstraint.activate([topConstraint,leadingConstraint,trallingConstraint,bottomConstraint])
        
        
        child.view.layoutIfNeeded()
    }
    
    
    
    
    
    
//    lazy var objective : ObjectiveVC =
//        {
//            // load Storyboard
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            
//            // Instantiate View Controller
//            var oVC = storyboard.instantiateViewController(withIdentifier: "ObjectiveViewController") as! ObjectiveVC
//            
//            // Add View Controller as Child View Controller
//            self.add(addAsChildVC: oVC)
//            
//            return oVC
//    }()
//    
//    
//    lazy var swift : SwiftVC =
//        {
//            // Load Storyboard
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            
//            // Instantiate View Controller
//            var sVC = storyboard.instantiateViewController(withIdentifier: "SwiftViewController") as! SwiftVC
//            
//            // Add View Controller as Child View Controller
//            self.add(addAsChildVC: sVC)
//            
//            return sVC
//    }()
    
//    func updateView()
//    {
//        if aSegmentController.selectedSegmentIndex == 0
//        {
//            remove(removeAsChildVC: swift)
//            add(addAsChildVC: objective)
//        }
//        else
//        {
//            remove(removeAsChildVC: objective)
//            add(addAsChildVC: swift)
//        }
//    }


   
}
