//
//  ViewController.swift
//  Pangesture
//
//  Created by Vicky on 18/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ironman: UIImageView!
    private var panGesture : UIPanGestureRecognizer!
    private var animatior : UIDynamicAnimator!
    private var repositioningBehavior : UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatior = UIDynamicAnimator(referenceView: view)
        repositioningBehavior = UISnapBehavior(item: ironman, snapTo: view.center)
        animatior.addBehavior(repositioningBehavior)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
        ironman.isUserInteractionEnabled = true
        ironman.addGestureRecognizer(panGesture)
    }
    
    @objc func draggedView(_ sender : UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            animatior.removeBehavior(repositioningBehavior)
        case .changed:
            let translation = sender.translation(in: view)
            ironman.center = CGPoint(x: ironman.center.x + translation.x, y: ironman.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended , .cancelled , .failed:
            animatior.addBehavior(repositioningBehavior)
        default:
            break
        }
    
    }
}

