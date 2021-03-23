//
//  ChatLoginViewController.swift
//  ChatLogin
//
//  Created by Goyal, Pratik on 17/03/21.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleSignIn
import Firebase
import Utility


protocol Presentation {
    typealias Input = (
        username : Driver<String>,
        password : Driver<String>
    )
    
    typealias Output = (
        enableLogin : Driver<Bool>, ()
    )
    
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input : Input { get }
    var output : Output { get }
}

class ChatLoginViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    private var presenter : Presentation!
    var presenterProducer : Presentation.Producer!
    
    private let disposeBag = DisposeBag()
    
    var onBack: ((String) -> Void)?
    
    var onGoogleSign: (() -> Void)?
    
    private let googleLoginButton = GIDSignInButton()
    
    private var loginObserver : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = presenterProducer((
            username: usernameTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver()
        ))
        
        setupUI()
        setupBinding()
        
        loginObserver = NotificationCenter.default.addObserver(forName: .didLoginNotification, object: nil, queue: .main, using: { [weak self] _ in
            guard let strongSelf = self else{
                return
            }
//            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
//            strongSelf.onGoogleSign?()
            strongSelf.onBack?("ChatsView")
        })
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self

        GIDSignIn.sharedInstance().presentingViewController = self
        
        view.addSubview(googleLoginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        googleLoginButton.frame = CGRect(x: 50, y: titleLabel.bottom+30, width: view.width-100, height: 60)
        googleLoginButton.style = GIDSignInButtonStyle.wide
        googleLoginButton.colorScheme = GIDSignInButtonColorScheme.dark
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        onBack?("Landing")
    }
    
    deinit {
        if let observer = loginObserver{
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else{
            if let error = error{
                print("Failed to sign in with Google : \(error)")
            }
            
            return
        }
        guard let user = user else {
            return
        }
        print("Did sign in with Google : \(user)")
        
        guard let email = user.profile.email,
              let firstName = user.profile.givenName,
              let lastName = user.profile.familyName else{
            return
        }
        
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set("\(firstName) \(lastName)",forKey: "name")
        guard let authentication = user.authentication else {
            print("Missing auth object of Google user")
            return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authResult,error in
            guard authResult != nil, error == nil else{
                print("Failed to login with Google credentials")
                return
            }
            print("Successfully signed in with Google credentials")
            NotificationCenter.default.post(name: .didLoginNotification, object: nil)
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Google User was disconnected")
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
}

private extension ChatLoginViewController {
    func setupUI() {
        avatarImageView.image = UIImage(named: "logo", in: Bundle(for: ChatLoginViewController.self), with: nil)
        let loginImage = UIImage(named: "enter", in: Bundle(for: ChatLoginViewController.self), with: nil)
        loginButton.setImage(loginImage, for: .normal)
        
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let backButtonImage = UIImage(systemName: "chevron.left", withConfiguration: largeConfig)
        backButton.setImage(backButtonImage, for: .normal)
        
    }
    
    func setupBinding() {
        presenter.output.enableLogin
            .debug("Enable login Driver",trimOutput: false)
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
