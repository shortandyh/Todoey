////
////  SwipeGestureRecognizer.swift
////  Todoey
////
////  Created by stone_1 on 23/02/2020.
////  Copyright © 2020 stone1. All rights reserved.
////
//
//import Foundation
//import UIKit
//
////
////  UISwipeGestureRecognizer.h
////  UIKit
////
////  Copyright (c) 2009-2015 Apple Inc. All rights reserved.
////
//
//// Recognizes: when numberOfTouchesRequired have moved mostly in the specified direction, enough to be considered a swipe.
////             a slow swipe requires high directional precision but a small distance
////             a fast swipe requires low directional precision but a large distance
//
//// Touch Location Behaviors:
////     locationInView:         location where the swipe began. this is the centroid if more than one touch was involved
////     locationOfTouch:inView: location of a particular touch when the swipe began
//
//public struct UISwipeGestureRecognizerDirection : OptionSetType {
//    public init(rawValue: UInt)
//    
//    public static var Right: UISwipeGestureRecognizerDirection
//    public static var Left: UISwipeGestureRecognizerDirection
//    public static var Up: UISwipeGestureRecognizerDirection
//    public static var Down: UISwipeGestureRecognizerDirection
//}
//
//@available(iOS 3.2, *)
//public class UISwipeGestureRecognizer : UIGestureRecognizer {
//
//    public var numberOfTouchesRequired: Int = 0 // default is 1. the number of fingers that must swipe
//    public var direction: UISwipeGestureRecognizerDirection // default is UISwipeGestureRecognizerDirectionRight. the desired direction of the swipe. multiple directions may be specified if they will result in the same behavior (for example, UITableView swipe delete)
//}

