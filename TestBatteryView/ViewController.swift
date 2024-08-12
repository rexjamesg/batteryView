//
//  ViewController.swift
//  TestBatteryView
//
//  Created by Yu Li Lin on 2019/11/29.
//  Copyright © 2019 Yu Li Lin. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    //MARK: - Private Properties
    private var batteryView: BatteryView = .init()
    private var slider = UISlider()
    private var sliderLabel: UILabel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setBatterView()
        setSlider()
        setSliderLabel(slider: slider)
        batteryView.setBatteryLevel(batteryLevel: CGFloat(slider.value))
    }
}

// MARK: - Private Methods

private extension ViewController {
    func setSlider() {
        slider = UISlider(frame: CGRect(x: 0, y: batteryView.frame.origin.y + 100, width: view.frame.size.width * 0.5, height: 50))
        slider.center.x = view.center.x
        view.addSubview(slider)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(didChangeSliderValue(sender:)), for: .valueChanged)
        slider.value = 0.5
    }
    
    @objc func didChangeSliderValue(sender: UISlider) {
        batteryView.setBatteryLevel(batteryLevel: CGFloat(sender.value))
        sliderLabel.text = "\(Int(sender.value * 100))%"
    }

    func setBatterView() {
        batteryView = BatteryView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        batteryView.center = view.center
        view.addSubview(batteryView)
    }

    func setSliderLabel(slider: UISlider) {
        sliderLabel = UILabel(frame: CGRect(x: 0, y: batteryView.frame.origin.y + 50, width: 100, height: 40))
        sliderLabel.textColor = UIColor.black
        sliderLabel.center.x = view.center.x
        sliderLabel.text = "\(Int(slider.value * 100))%"
        sliderLabel.textAlignment = .center
        view.addSubview(sliderLabel)
    }
}
