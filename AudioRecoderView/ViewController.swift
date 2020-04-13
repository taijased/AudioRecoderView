//
//  ViewController.swift
//  AudioRecoderView
//
//  Created by Максим Спиридонов on 13.04.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    let controlsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        return view
    }()
    
    let squareView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    lazy var audioRecoder: AudioRecoderView = AudioRecoderView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        
        
        
        view.addSubview(controlsView)
        controlsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controlsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        controlsView.addSubview(squareView)
        squareView.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor).isActive = true
        squareView.centerXAnchor.constraint(equalTo: controlsView.centerXAnchor).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        squareView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        audioRecoder.delegate = self
        controlsView.addSubview(audioRecoder)
        audioRecoder.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor).isActive = true
        audioRecoder.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor).isActive = true
        audioRecoder.heightAnchor.constraint(equalToConstant: 100).isActive = true
        audioRecoder.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    
    
    
}



extension ViewController: AudioRecoderViewDelegate {
    func activeView() {
        print(#function)
    }
    
   
    func defaultView() {
        print(#function)
    }
}
