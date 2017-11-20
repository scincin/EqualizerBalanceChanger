//
//  ViewController.swift
//  EqualizerBalance
//
//  Created by Selahattin Cincin on 16/11/2017.
//  Copyright © 2017 Selahattin Cincin. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {
    let popSound = Bundle.main.url(forResource: "Eminem_WithoutMe", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()
    
   
    
    lazy var leftBalance: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:90, g:111, b:171)
        button.setTitle("Left", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor((UIColor.white), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(BalanceLeft), for: .touchUpInside)
        return button
    }()
    
    lazy var rightBalance: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:90, g:111, b:171)
        button.setTitle("Right", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor((UIColor.red), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(BalanceRight), for: .touchUpInside)
        return button
    }()
    var channel = AudioChannelLayout.init()
    
    @objc func BalanceRight() {
        audioPlayer.pan = 1
        audioPlayer.play()
        AudioBalanceFade(mLeftRightBalance: 1, mBackFrontFade: 0, mType: AudioBalanceFadeType.equalPower, mChannelLayout:&channel)
        
    }
    
    @objc func BalanceLeft() {
        audioPlayer.pan = -1
        audioPlayer.play()
        AudioBalanceFade(mLeftRightBalance: -1, mBackFrontFade: 0, mType: AudioBalanceFadeType.equalPower, mChannelLayout: &channel)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(r: 61,g: 91,b: 151)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: popSound!)
            audioPlayer.prepareToPlay()
            audioPlayer.format
        } catch  {
            print("hi")
        }
        
        view.addSubview(leftBalance)
        view.addSubview(rightBalance)
        
        setupButtons()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupButtons() {
        //need x,y,width, height constrains
        
        leftBalance.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
        rightBalance.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rightBalance.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
}
extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
    }
}

