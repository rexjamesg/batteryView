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

    //電池外框線粗細
    private let lineWidth:CGFloat = 1.5
    //框線與間距之間的留白(為了美觀)
    private let innerPadding:CGFloat = 1.5
    //電池頭部上緣內縮距離
    private let headSpace:CGFloat = 3.5
    
    //外框路徑
    let path = UIBezierPath()
    //外框塗層
    let shapeLayer = CAShapeLayer()
    
    //電量著色路徑
    private let fillPath = UIBezierPath()
    //電量著色圖層
    private let fillShapeLayer = CAShapeLayer()
    
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
        
        let points = setOutterLinePoints()
        drawOutterLine(points: points)
    }
    //MARK: - 外框
    //設定外框路徑
    private func setOutterLinePoints() -> [CGPoint] {
        return [
            CGPoint.init(x: frame.size.width-headSpace, y: 0),
            CGPoint.init(x: frame.size.width-headSpace, y: frame.size.height*0.2),
            CGPoint.init(x: frame.size.width, y: frame.size.height*0.2),
            CGPoint.init(x: frame.size.width, y: frame.size.height*0.8),
            CGPoint.init(x: frame.size.width-headSpace, y: frame.size.height*0.8),
            CGPoint.init(x: frame.size.width-headSpace, y: frame.size.height),
            CGPoint.init(x: 0, y: frame.size.height)
        ]
    }
    
    //繪製外框
    private func drawOutterLine(points:[CGPoint]) {
        
        path.move(to: CGPoint.init(x: 0, y: 0))
        
        for point in points {
            path.addLine(to: point)
        }
        
        path.close()
                
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    //MARK: - 內部著色
    //設定著色路徑
    private func setFillPathPoints(startX:CGFloat) -> [CGPoint] {
        
        var points:[CGPoint] = []
        
        var shouldDrawHead:Bool = false
        
        if startX >= frame.size.width-2.5 {
            shouldDrawHead = true
        }
                
        if shouldDrawHead {
            //電池凸起的頭部
            points.append(CGPoint(x: frame.size.width-headSpace-innerPadding, y: frame.size.height*0.8-innerPadding))
            points.append(CGPoint(x: frame.size.width-innerPadding, y: frame.size.height*0.8-innerPadding))
            points.append(CGPoint(x: frame.size.width-innerPadding, y: frame.size.height*0.2+innerPadding))
            points.append(CGPoint(x: frame.size.width-headSpace-innerPadding, y: frame.size.height*0.2+innerPadding))
            points.append(CGPoint(x: frame.size.width-headSpace-innerPadding, y: 0+innerPadding))
        } else {
            points.append(CGPoint(x: startX-innerPadding, y: 0+innerPadding))
        }
        
        points.append(CGPoint(x: 0+innerPadding, y: 0+innerPadding))
        points.append(CGPoint(x: 0+innerPadding, y: frame.size.height-innerPadding))
        
        if shouldDrawHead {
            //電池凸起的頭部
            points.append(CGPoint(x: frame.size.width-headSpace-innerPadding, y: frame.size.height-innerPadding))
        } else {
            points.append(CGPoint(x: startX-innerPadding, y: frame.size.height-innerPadding))
        }
        
        return points
    }
    
    //繪製路徑並著色
    private func drawInnerLine(points:[CGPoint]) {
                
        //每次繪製時，清掉所有路徑，避免重複疊加
        fillPath.removeAllPoints()
        fillShapeLayer.removeFromSuperlayer()
        
        for (index, point) in points.enumerated() {
            if index == 0 {
                fillPath.move(to: point)
            } else {
                fillPath.addLine(to: point)
            }
        }
        
        fillPath.close()
        fillShapeLayer.path = fillPath.cgPath
        fillShapeLayer.strokeColor = UIColor.clear.cgColor
        fillShapeLayer.lineWidth = lineWidth
    }
    
    /**
     依照電量動態填滿顏色
     - Parameter batteryLevel: 輸入的電量
     */
    func setBatteryLevel(batteryLevel:CGFloat) {
        
        if batteryLevel <= 0 {
            return
        }
        
        let startX = frame.size.width*batteryLevel
        
        let points = setFillPathPoints(startX: startX)
        
        drawInnerLine(points: points)
                                       
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
