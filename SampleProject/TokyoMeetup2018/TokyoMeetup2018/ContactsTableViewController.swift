//
//  ContactsTableViewController.swift
//  TokyoMeetup2018
//
//  Created by Jeffrey Bergier on 03/03/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    class func newVC() -> UIViewController {
        let vc = ContactsTableViewController()
        let navVC = UINavigationController(rootViewController: vc)
        return navVC
    }

    private var data: [Contact] = [
        Contact(name: "Bill"),
        Contact(name: "Bob"),
        Contact(name: "Adam"),
        Contact(name: "Joe"),
        Contact(name: "Mary"),
        Contact(name: "Beth"),
        Contact(name: "Melissa"),
        Contact(name: "Allison"),
        Contact(name: "Jessica"),
        Contact(name: "Paula"),
        Contact(name: "Sarah"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contacts"
        // we don't need this! we do it ourselves
        self.clearsSelectionOnViewWillAppear = false

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addTapped(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Simple"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            ?? UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        let contact = self.data[indexPath.row]
        cell.textLabel?.text = contact.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.data[indexPath.row]
        let vc = ContactEditViewController.newVC(contact: contact) { [unowned self] vc, contact in
            guard let contact = contact else {
                // if we don't have a new contact, we just need to deselect the selected row
                vc.dismiss(animated: true) {
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                return
            }
            // if we do, we need to update our data source
            self.data.remove(at: indexPath.row)
            self.data.insert(contact, at: indexPath.row)
            // and also reload the appropriate row
            vc.dismiss(animated: true) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }

    /*
     //
     // One More Thing, Advanced Deselection Animation
     //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.data[indexPath.row]
        let vc = ContactEditViewController.newVC(contact: contact) { [unowned self] vc, contact in
            guard let contact = contact else {
                // if we don't have a new contact, we just need to deselect the selected row
                vc.dismiss(animated: true)
                self.animateAlongSideTransitionIfPossible() { _ in
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                return
            }
            // if we do, we need to update our data source
            self.data.remove(at: indexPath.row)
            self.data.insert(contact, at: indexPath.row)
            // and also reload the appropriate row
            vc.dismiss(animated: true)
            self.animateAlongSideTransitionIfPossible() { _ in
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    */
    
    @objc private func addTapped(_ sender: Any) {
        let vc = ContactEditViewController.newVC(contact: nil) { [unowned self] vc, contact in
            guard let contact = contact else {
                // if we don't have a new contact, we just need to deselect the selected row
                vc.dismiss(animated: true)
                return
            }
            // if we do, we need to update our data source
            self.data += [contact]
            // and also reload the appropriate row
            vc.dismiss(animated: true) {
                self.tableView.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: .automatic)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }

    /*
    //
    // One More Thing, Advanced Add Reload Animation
    //
    @objc private func addTapped(_ sender: Any) {
        let vc = ContactEditViewController.newVC(contact: nil) { [unowned self] vc, contact in
            guard let contact = contact else {
                // if we don't have a new contact, we just need to deselect the selected row
                vc.dismiss(animated: true)
                return
            }
            // if we do, we need to update our data source
            self.data += [contact]
            // and also reload the appropriate row
            vc.dismiss(animated: true) {
                self.tableView.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: .automatic)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    */
}

