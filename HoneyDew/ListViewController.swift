//
//  ViewController.swift
//  HoneyDew
//
//  Created by Crystal Jade Allen-Washington on 5/22/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

@objc(HoneyDewViewController)
class HoneyDewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, InviteDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addToDoButton: UIButton!
    var ref: DatabaseReference!
    var toDoList: [DataSnapshot]! = []
    fileprivate var _refHandle: DatabaseHandle?
    
    var storageRef: StorageReference!
    var remoteConfig: RemoteConfig!
    
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTable.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        
        configureDatabase()
        configureStorage()
        configureRemoteConfig()
        fetchConfig()
        logViewLoaded()
    }
    
    deinit {
        if let refHandle = _refHandle {
            self.ref.child("toDos").removeObserver(withHandle: refHandle)
        }
    }
    
    func configureDatabase() {
        ref = Database.database().reference()
        _refHandle = self.ref.child("toDos").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.toDoList.append(snapshot)
            strongSelf.listTable.insertRows(at: [IndexPath(row: strongSelf.toDoList.count-1, section: 0)], with: .automatic)
        })
    }
    
    func configureStorage() {
        storageRef = Storage.storage().reference()
    }
    
    func configureRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
    }
    
    func fetchConfig() {
        var expirationDuration: Double = 3600
        if self.remoteConfig.configSettings.isDeveloperModeEnabled {
            expirationDuration = 0
        }
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { [weak self] (status, error) in
            if status == .success {
                print("Config fetched!")
                guard let strongSelf = self else { return }
                strongSelf.remoteConfig.activateFetched()
            } else {
                print("Config not fetched")
                if let error = error {
                    print("Error \(error)")
                }
            }
        }
    }
    // NOTE TO SELF: This is where you will connect your `Share` button.
    func shareTapped(_ sender: AnyObject) {
        if let share = Invites.inviteDialog() {
            share.setInviteDelegate(self)
            share.setMessage("Check out my to-do list!\n -\(Auth.auth().currentUser?.displayName ?? "")")
            share.setTitle("HoneyDew")
            share.setDeepLink("app_url")
            share.setCallToActionText("Install!")
            share.setCustomImage("https://upload.wikimedia.org/wikipedia/commons/f/f5/Honeydew.jpg")
            share.open()
        }
    }
    
    func logViewLoaded() {
        FirebaseCrashMessage("View loaded")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.listTable .dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let toDoListSnapshot: DataSnapshot! = self.toDoList[indexPath.row]
        guard let toDoList = toDoListSnapshot.value as? [String: String] else { return cell }
        
        return cell
    }
}
