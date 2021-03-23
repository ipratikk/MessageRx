//
//  Presenter.swift
//  Landing
//
//  Created by Goyal, Pratik on 17/03/21.
//
import UIKit
import Utility

public final class Builder {
    public static func build(completion : @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Landing", bundle: Bundle.init(for: self))
        let view = LandingViewController.instantiate(from: storyboard)
        view.onStart = completion
        return view
    }
}
