//
//  AppDelegate.swift
//  TokyoMeetup2018
//
//  Created by Jeffrey Bergier on 03/03/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let vc = ContactsTableViewController.newVC()

        let window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.backgroundColor = .white
        window.rootViewController = vc
        window.makeKeyAndVisible()

        return true
    }
}

