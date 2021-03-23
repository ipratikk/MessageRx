//
//  Builder.swift
//  ChatLogin
//
//  Created by Goyal, Pratik on 17/03/21.
//

import UIKit
import Utility

public final class Builder {
    public static func build(completion : @escaping (String) -> Void) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "ChatLogin", bundle: Bundle.init(for: self))
        let view = ChatLoginViewController.instantiate(from: storyboard)
        view.onBack = completion
//        view.onGoogleSign = completion
        let router = Router(viewController: view)
        view.presenterProducer = {
            Presenter(
                input: $0,
                router: router,
                useCases: ()
            )
        }
        return view
    }
}
