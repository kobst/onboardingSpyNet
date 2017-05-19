//
//  ViewController.swift
//  SpyNetOnboarding
//
//  Created by Edward Han on 5/12/17.
//  Copyright © 2017 Edward Han. All rights reserved.
//

import UIKit

enum StoryboardSegue: String {
    case viewControllerToLogInController = "ViewController_to_LogInController"
    case viewControllerToSignUpController = "ViewController_to_SignUpController"
}

extension UIViewController {
    func performSegue(with segue: StoryboardSegue, sender: Any = self) {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

class PercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
    var presenting = false
}

class ViewControllerToSecondInteractiveTransition : PercentDrivenInteractiveTransition { }

extension ViewControllerToSecondInteractiveTransition : UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        ()
        
        
        guard let secondViewController = transitionContext.viewController(forKey: .to) as? SecondViewController else {
            fatalError()
        }
        
        secondViewController.view.backgroundColor = .red
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    var viewControllerToSecond = ViewControllerToSecondInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case StoryboardSegue.viewControllerToLogInController.rawValue:
            segue.destination.transitioningDelegate = self
        default:
            ()
        }
    }
    
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        switch sender {
        case logInButton:
            performSegue(with: .viewControllerToLogInController)
        default:
            ()
        }
    }
    
}

extension ViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        viewControllerToSecond.presenting = true
        return viewControllerToSecond
    }
}

class SecondViewController: UIViewController {
    
}
