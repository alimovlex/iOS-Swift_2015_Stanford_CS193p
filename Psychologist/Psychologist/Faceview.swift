//
//  Faceview.swift
//  Happiness
//
//  Created by robot on 2/19/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
    func smilinessForFaceView(sender: Faceview) -> Double?
    
}

@IBDesignable //Making the code live on the storyboard
class Faceview: UIView
{
    @IBInspectable //show variable on item inspector at view properties in storyboard
    var lineWidth: CGFloat = 3
    {
        didSet
        {
            setNeedsDisplay();
        }
    }
    @IBInspectable //show variable on item inspector at view properties in storyboard
    var color: UIColor = UIColor.systemBlue;
    @IBInspectable //show variable on item inspector at view properties in storyboard
    var scale: CGFloat = 0.9
    {
        didSet {
            setNeedsDisplay();
        }
    }
    var faceCenter: CGPoint
    {
        return convert(center, from: superview);
    }
    
    var faceRadius: CGFloat
    {
        return min(bounds.size.width, bounds.size.height)/2 * scale;
    }
    
    weak var dataSource: FaceViewDataSource?;
    
    private struct Scaling
    {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10;
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3;
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5;
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1;
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3;
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3;
    }
    
    private enum Eye
    {
        case Left, Right;
    }
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio;
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio;
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio;
        var eyeCenter = faceCenter;
        eyeCenter.y -= eyeVerticalOffset;
        switch whichEye {
        case .Left:
            eyeCenter.x -= eyeHorizontalSeparation / 2;
        case .Right:
            eyeCenter.x += eyeHorizontalSeparation / 2;
        }
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true);
        path.lineWidth = lineWidth;
        return path;
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio;
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio;
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio;
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight;
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset);
        let end = CGPoint(x: start.x + mouthWidth, y: start.y);
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight);
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y);
        
        let path = UIBezierPath();
        path.move(to: start);
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2);
        path.lineWidth = lineWidth;
        return path;
    }
    
    override func draw(_ rect: CGRect)
    {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true);
        facePath.lineWidth = lineWidth;
        color.set();
        facePath.stroke();
        bezierPathForEye(whichEye: .Left).stroke();
        bezierPathForEye(whichEye: .Right).stroke();
        
        let smiliness = dataSource?.smilinessForFaceView(sender: self) ?? 0.0;
        let smilePath = bezierPathForSmile(fractionOfMaxSmile: smiliness);
        smilePath.stroke();
    }
    

}
