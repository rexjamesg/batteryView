//
//  BatteryView.swift
//  TestBatteryView
//
//  Created by Yu Li Lin on 2019/11/29.
//  Copyright © 2019 Yu Li Lin. All rights reserved.
//

import UIKit

import UIKit

class BatteryView: UIView {

    private let lineWidth:CGFloat = 1.5
    private let innerPadding:CGFloat = 1.5
    private let fillPath = UIBezierPath()
    private let fillShapeLayer = CAShapeLayer()
    private let space:CGFloat = 2.5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        backgroundColor = .clear
        
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: 0, y: 0))
        path.addLine(to: CGPoint.init(x: frame.size.width-space, y: 0))
        path.addLine(to: CGPoint.init(x: frame.size.width-space, y: frame.size.height*0.2))
        path.addLine(to: CGPoint.init(x: frame.size.width, y: frame.size.height*0.2))
        path.addLine(to: CGPoint.init(x: frame.size.width, y: frame.size.height*0.8))
        path.addLine(to: CGPoint.init(x: frame.size.width-space, y: frame.size.height*0.8))
        path.addLine(to: CGPoint.init(x: frame.size.width-space, y: frame.size.height))
        path.addLine(to: CGPoint.init(x: 0, y: frame.size.height))
        path.close()
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    func setBatteryLevel(batteryLevel:CGFloat) {
        fillPath.removeAllPoints()
        fillShapeLayer.removeFromSuperlayer()
        
        if batteryLevel <= 0 {
            return
        }
        
        let startX = frame.size.width*batteryLevel
        var shouldDrawHead:Bool = false
        if startX >= frame.size.width-2.5 {
            shouldDrawHead = true
        }
                
        if shouldDrawHead {
            //電池凸起的頭部
            fillPath.move(to: CGPoint(x: frame.size.width-space-innerPadding, y: frame.size.height*0.8-innerPadding))
            fillPath.addLine(to: CGPoint(x: frame.size.width-innerPadding, y: frame.size.height*0.8-innerPadding))
            fillPath.addLine(to: CGPoint(x: frame.size.width-innerPadding, y: frame.size.height*0.2+innerPadding))
            fillPath.addLine(to: CGPoint(x: frame.size.width-space-innerPadding, y: frame.size.height*0.2+innerPadding))
            fillPath.addLine(to: CGPoint(x: frame.size.width-space-innerPadding, y: 0+innerPadding))
        } else {
            fillPath.move(to: CGPoint(x: startX-innerPadding, y: 0+innerPadding))
        }
        
        fillPath.addLine(to: CGPoint(x: 0+innerPadding, y: 0+innerPadding))
        fillPath.addLine(to: CGPoint(x: 0+innerPadding, y: frame.size.height-innerPadding))
        
        if shouldDrawHead {
            //電池凸起的頭部
            fillPath.addLine(to: CGPoint(x: frame.size.width-space-innerPadding, y: frame.size.height-innerPadding))
        } else {
            fillPath.addLine(to: CGPoint(x: startX-innerPadding, y: frame.size.height-innerPadding))
        }

        fillShapeLayer.path = fillPath.cgPath
        fillShapeLayer.strokeColor = UIColor.clear.cgColor
        fillShapeLayer.lineWidth = lineWidth
        
        var color = UIColor.green.cgColor
        
        if batteryLevel > 0.2 && batteryLevel < 0.5 {
            color = UIColor.yellow.cgColor
        } else if batteryLevel <= 0.2 {
            color = UIColor.red.cgColor
        }
        
        fillShapeLayer.fillColor = color
        layer.addSublayer(fillShapeLayer)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
