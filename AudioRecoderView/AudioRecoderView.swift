//
//  AudioRecoderView.swift
//  AudioRecoderView
//
//  Created by Максим Спиридонов on 13.04.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol AudioRecoderViewDelegate: class {
    func activeView()
    func defaultView()
}

final class AudioRecoderView: UIView {
    
    
    weak var delegate: AudioRecoderViewDelegate?
    
    var timer = Timer()
    
    
    fileprivate let deleteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.3)
        label.textAlignment = .left
        label.text = "Delete"
        label.isHidden = true
        return label
    }()
    
    fileprivate let recordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.text = "0:0"
        label.isHidden = true
        return label
    }()
    
    
    lazy var chevronLeft: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.left")
        view.tintColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.3)
        view.isHidden = true
        return view
    }()
    
    
    
    lazy var recordPoint: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1, green: 0.286, blue: 0.447, alpha: 1)
        view.layer.cornerRadius = 5
        view.isHidden = true
        return view
    }()
    
    lazy var topBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor(red: 0.012, green: 0.063, blue: 0.18, alpha: 0.1).cgColor
        view.isHidden = true
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    fileprivate let micButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "mic"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        return button
    }()
    
    
    
    
    @objc func tap(gestureReconizer: UILongPressGestureRecognizer) {
        switch gestureReconizer.state {
        case .began:
            activeView()
            activeButton()
            activeUI()
        case .ended:
            defaultView()
            defaultButton()
            defaultUI()
        case .changed:
            print("changed")
        default:
            break
        }
    }
    
    
    
    
    fileprivate func activeView() {
        self.frame.origin.x = UIScreen.main.bounds.width - 50
        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .width {
                UIView.animate(withDuration: 0.0) {
                    constraint.constant = UIScreen.main.bounds.width
                    self.frame.size.width = UIScreen.main.bounds.width
                    self.frame.origin.x = UIScreen.main.bounds.width - 50
                }
            }
        }
        
    }
    
    
    lazy var pulseAnimation: PulseAnimation = {
        let pulse = PulseAnimation(numberOfPulse: Float.infinity, radius: 50, postion: CGPoint(x: 25, y: 25))
        pulse.animationDuration = 1.2
        pulse.backgroundColor = UIColor.systemBlue.cgColor
        return pulse
    }()
    
    fileprivate func activeButton() {
        
        
        UIView.setAnimationsEnabled(false)
        micButton.layer.insertSublayer(pulseAnimation, below: micButton.layer)
        pulseAnimation.setupAnimationGroup()
        UIView.setAnimationsEnabled(true)
        
        
        UIView.animate(withDuration: 0.15) {
            self.micButton.tintColor = .white
            self.micButton.backgroundColor = .systemBlue
            self.micButton.layer.cornerRadius = self.micButton.frame.width / 2
        }
    }
    
    
    fileprivate func defaultButton() {
        
        
        UIView.setAnimationsEnabled(false)
        pulseAnimation.stopAnimation()
        UIView.setAnimationsEnabled(true)
        
        UIView.animate(withDuration: 0.15) {
            self.micButton.tintColor = .black
            self.micButton.backgroundColor = .white
            self.micButton.layer.cornerRadius = 0
        }
    }
    
    
    fileprivate func defaultView() {
        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .width {
                UIView.animate(withDuration: 0) {
                    constraint.constant = 50
                    self.frame.size.width = 50
                }
            }
        }
    }
    
    
    fileprivate func activeUI() {
        UIView.animate(withDuration: 0.25) {
            self.topBorder.isHidden = false
            self.chevronLeft.isHidden = false
            self.deleteLabel.isHidden = false
            self.recordLabel.isHidden = false
            self.recordPoint.isHidden = false
        }
    }
    
    fileprivate func defaultUI() {
        UIView.animate(withDuration: 0.25) {
            self.topBorder.isHidden = true
            self.chevronLeft.isHidden = true
            self.deleteLabel.isHidden = true
            self.recordLabel.isHidden = true
            self.recordPoint.isHidden = true
        }
    }
    
    
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layoutIfNeeded()
        
        backgroundColor = .green
        
        
        addSubview(topBorder)
        topBorder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBorder.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topBorder.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        addSubview(micButton)
        micButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        micButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        micButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        micButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.tap))
        gesture.delaysTouchesBegan = true
        gesture.delaysTouchesEnded = true
        micButton.addGestureRecognizer(gesture)
        
        
        
        
        
        
        
        addSubview(chevronLeft)
        chevronLeft.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        chevronLeft.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        chevronLeft.widthAnchor.constraint(equalToConstant: 20).isActive = true
        chevronLeft.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        addSubview(deleteLabel)
        deleteLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        deleteLabel.leadingAnchor.constraint(equalTo: chevronLeft.trailingAnchor, constant: 6.15).isActive = true
        deleteLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        deleteLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        addSubview(recordLabel)
        recordLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        recordLabel.trailingAnchor.constraint(equalTo: micButton.leadingAnchor, constant: -30).isActive = true
        recordLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        recordLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(recordPoint)
        recordPoint.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        recordPoint.trailingAnchor.constraint(equalTo: recordLabel.leadingAnchor, constant: -10).isActive = true
        recordPoint.widthAnchor.constraint(equalToConstant: 10).isActive = true
        recordPoint.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    
    func updateLabel(_ label: String) {
        UIView.animate(withDuration: 0.0) {
            self.recordLabel.text = label
        }
    }
    
}



//MARK: -  PulseAnimation class


class PulseAnimation: CALayer {
    
    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numebrOfPulse: Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(numberOfPulse: Float = Float.infinity, radius: CGFloat, postion: CGPoint){
        super.init()
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numebrOfPulse = numberOfPulse
        self.position = postion
        
        self.bounds = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        self.cornerRadius = radius
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimaton = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimaton.fromValue = NSNumber(value: 0)
        scaleAnimaton.toValue = NSNumber(value: 1)
        scaleAnimaton.duration = animationDuration
        return scaleAnimaton
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimiation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimiation.duration = animationDuration
        opacityAnimiation.values = [0.4,0.8,0]
        opacityAnimiation.keyTimes = [0,0.3,1]
        return opacityAnimiation
    }
    
    func setupAnimationGroup() {
        DispatchQueue.global(qos: .default).async {
            self.animationGroup.duration = self.animationDuration
            self.animationGroup.repeatCount = self.numebrOfPulse
            let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
            self.animationGroup.timingFunction = defaultCurve
            self.animationGroup.animations = [self.scaleAnimation(),self.createOpacityAnimation()]
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    
    func stopAnimation() {
        self.removeAllAnimations()
    }
    
}

