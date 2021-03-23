//
//  Builder.swift
//  ChatsView
//
//  Created by Goyal, Pratik on 20/03/21.
//

import UIKit
import Utility

public final class Builder {
    public static func build(completion : @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "ChatsView", bundle: Bundle.init(for: self))
        let view = ChatsViewController.instantiate(from: storyboard)
//        view.onBack = completion
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

