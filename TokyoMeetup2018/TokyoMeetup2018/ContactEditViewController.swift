//
//  ContactEditViewController.swift
//  TokyoMeetup2018
//
//  Created by Jeffrey Bergier on 03/03/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController {

    typealias Completion = ((UIViewController, Contact?) -> Void)

    class func newVC(contact: Contact?,
                     completion: @escaping Completion) -> UIViewController
    {
        // create your vc however you want.
        let vc = ContactEditViewController()
        // configure your vc
        if let contact = contact {
            vc.title = "Edit Contact"
            vc.contact = contact
        } else {
            vc.title = "New Contact"
            vc.contact = Contact(name: nil)
        }
        vc.completionHandler = completion
        let navVC = UINavigationController(rootViewController: vc)
        return navVC
    }

    private var contact: Contact?
    private var completionHandler: Completion?
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.saveTapped(_:)))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelTapped(_:)))
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton

        self.view.addSubview(textField)
        self.view.addConstraints([
            self.textField.leadingAnchor.constraintEqualToSystemSpacingAfter(self.view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraintEqualToSystemSpacingAfter(textField.trailingAnchor, multiplier: 1),
            self.textField.topAnchor.constraintEqualToSystemSpacingBelow(self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
            ])

        self.textField.text = self.contact?.name
    }

    @objc private func saveTapped(_ sender: Any) {
        self.contact?.name = self.textField.text
        self.completionHandler?(self, self.contact)
    }

    @objc private func cancelTapped(_ sender: Any) {
        self.completionHandler?(self, nil)
    }
}
