//
//  ChatsViewController.swift
//  ChatsView
//
//  Created by Goyal, Pratik on 20/03/21.
//

import UIKit
import Utility
import RxSwift
import RxCocoa
import FirebaseDatabase

protocol Presentation {
    typealias Input = (
        
    )
    
    typealias Output = (
        
    )
    
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input : Input { get }
    var output : Output { get }
}


class ChatsViewController: UIViewController {
    @IBOutlet weak var chatsTableView: UITableView!
    
    @IBOutlet weak var chatTableCell: UITableViewCell!
    
    private var presenter : Presentation!
    var presenterProducer : Presentation.Producer!
    
    private var loginObserver: NSObjectProtocol?
    
    private var users = [[String : String]]()
    private var results : BehaviorRelay<[User]> = BehaviorRelay(value: [])
    
    private var hasFetched = false
    
    private let disposeBag = DisposeBag()
    
    private var database : DatabaseManager! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        title = "Chats"
        
//        table.register(UserCell.self,
//                       forCellReuseIdentifier: UserCell.identifier)
        startListeningForUsers()
        
        loginObserver = NotificationCenter.default.addObserver(forName: .didLoginNotification, object: nil, queue: .main, using: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.startListeningForUsers()
        })
        
        database = DatabaseManager(reference: Database.database().reference())
        
        results.bind(to: chatsTableView.rx.items(cellIdentifier: "cell")){ row,model,cell in
            cell.textLabel?.text = "\(model.name), \(model.email)"
        }
    }
    
    private func startListeningForUsers() {
//        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
//            return
//        }
//
//        if let observer = loginObserver {
//            NotificationCenter.default.removeObserver(observer)
//        }
//
//        print("starting conversation fetch...")
//
//        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        
        getAllUsers()
        
    }
    
    func getAllUsers(){
        database.getAllUsers(completion: { [weak self] result in
            switch result{
            case .success(let usersCollection):
                self?.hasFetched = true
                self?.users = usersCollection
                self?.filterUsers()
                print("Fetched users : \(result)")
            case .failure(let error):
                print("Failed to get users : \(error)")
            }
        })
    }
    
    func filterUsers(){
        let result : [User] = users.compactMap({
            guard let email = $0["email"],
                  let name = $0["name"] else{
                    return nil
                  }
            return User(name: name, email: email)
        })
        self.results.accept(result)
    }
}

struct User {
    let name : String
    let email : String
}
