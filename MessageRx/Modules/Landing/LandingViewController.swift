//
//  LandingViewController.swift
//  Landing
//
//  Created by Goyal, Pratik on 17/03/21.
//

import UIKit

class LandingViewController: UIViewController {

    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var onStart: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func onStartTapped(_ sender: Any) {
        onStart?()
    }
}

private extension LandingViewController {
    func setupUI() {
        logoImageView.image = UIImage(named: "logo", in: Bundle(for: LandingViewController.self), with: nil)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        let startButtonImage = UIImage(systemName: "play.circle.fill", withConfiguration: largeConfig)
        startButton.setImage(startButtonImage, for: .normal)
    }
}
