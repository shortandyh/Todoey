//
//  PresentMenuAnimator.swift
//  SwipeSegue
//
//  Created by stone_1 on 08/03/2020.
//  Copyright © 2020 stone1. All rights reserved.
//

//import UIKit
//
//class PresentMenuAnimator : NSObject {
//    
//}
//
//extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.3
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        
//        let containerView = transitionContext.containerView
//        
//        guard
//            let fromVC  = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
//            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//        
//        else {
//                return
//        }
//        
//        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
//        let snapShot = fromVC.view.snapshotView(afterScreenUpdates: false)
//        snapShot?.tag = MenuHelper.snapShotNumber
//        snapShot?.isUserInteractionEnabled = false
//        snapShot?.layer.shadowOpacity = 0.7
//        containerView.insertSubview(snapShot!, aboveSubview: toVC.view)
//        fromVC.view.isHidden = true
//        
//        UIView.animate(
//            withDuration: transitionDuration(using: transitionContext),
//            animations: {
//                snapShot?.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
//            },
//            completion: { _ in
//                fromVC.view.isHidden = false
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            }
//        )
//    }
//}
