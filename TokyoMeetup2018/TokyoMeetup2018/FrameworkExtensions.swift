//
//  FrameworkExtensions.swift
//  TokyoMeetup2018
//
//  Created by Jeffrey Bergier on 03/03/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

import UIKit

extension UIViewController {

    typealias ContextClosure = (UIViewControllerTransitionCoordinatorContext?) -> Void

    func animateAlongSideTransitionIfPossible(_ animate: @escaping ContextClosure) {
        self.animateAlongSideTransitionIfPossible(animate, completion: nil)
    }

    func animateAlongSideTransitionIfPossible(_ animate: @escaping ContextClosure,
                                              completion: ContextClosure?)
    {
        if let tc = self.transitionCoordinator {
            tc.animate(alongsideTransition: animate, completion: completion)
        } else {
            animate(nil)
            completion?(nil)
        }
    }
}
