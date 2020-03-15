//
//  DismissMenuAnimator.swift
//  SwipeSegue
//
//  Created by stone_1 on 09/03/2020.
//  Copyright © 2020 stone1. All rights reserved.
//

//import UIKit
//
//class DismissMenuAnimator: NSObject {
//    
//}
//
//extension DismissMenuAnimator: UIViewControllerAnimatedTransitioning {
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.3
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//        guard
//            let fromVC  = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
//            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//            else {
//                return
//        }
//        
//        let snapShot = containerView.viewWithTag(MenuHelper.snapShotNumber)
//        
//        UIView.animate(
//            withDuration: transitionDuration(using: transitionContext),
//            animations: {
//                snapShot?.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
//        },
//            completion: { _ in
//                let didTransitionComplete = !transitionContext.transitionWasCancelled
//                if didTransitionComplete {
//                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
//                    snapShot?.removeFromSuperview()
//                }
//                transitionContext.completeTransition(didTransitionComplete)
//            })
//    }
//}
