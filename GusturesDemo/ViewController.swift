//
//  ViewController.swift
//  GusturesDemo
//
//  Created by Tal Spektor on 25/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var colors: [UIColor] = [.red, .blue, .blue, .systemPink, .green]
    
    private lazy var myView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.center = self.view.center
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(myView)
//        addPanGester()
        addPinchGesture()
        addTapGesture()
        addLongPressGesture()
        addRotateGesture()
        addSwipeGesture()
    }
    //MARK: - PanGesture
    private func addPanGester() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        myView.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let targetView = sender.view else { return }
        let translation = sender.translation(in: view)
        // Move the view
        targetView.center = CGPoint(x: targetView.center.x + translation.x, y: targetView.center.y + translation.y)
        sender.setTranslation(.zero, in: view)
        if sender.state == .failed || sender.state == .ended {
            targetView.center = view.center
        }
    }
    //MARK: - PinchGesture
    private func addPinchGesture() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        myView.addGestureRecognizer(pinch)
    }
    // Scale the view
    @objc private func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard let targetView = sender.view else { return }
        targetView.transform = targetView.transform.scaledBy(x: sender.scale, y: sender.scale)
        
        sender.scale = 1
    }
    //MARK: - TapGesture
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        myView.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let targetView = sender.view else { return }
        targetView.backgroundColor = colors.first
        colors.shuffle()
    }
    
    //MARK: - LongPress
    private func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPress.minimumPressDuration = 0.4
        myView.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        guard let _ = sender.view else { return }
        print("long press")
    }
    
    //MARK: - RotateGesture
    private func addRotateGesture() {
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        myView.addGestureRecognizer(rotate)
    }
    
    @objc private func handleRotate(_ sender: UIRotationGestureRecognizer) {
        guard let targetView = sender.view else { return }
        
        switch sender.state {
        case .began, .changed:
            targetView.transform = targetView.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        default:
            targetView.transform = .identity
        break
        }
    }
    
    //MARK: - SwipeGesture
    private func addSwipeGesture() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipe.direction = .down
        myView.addGestureRecognizer(swipe)
    }
    
    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        guard let _ = sender.view else { return }
        print(sender.direction.rawValue)
    }
}

