//
//  BezierPathsView.swift
//  Dropit
//
//  Created by robot on 2/26/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {

    private var bezierPaths = [String:UIBezierPath]();
    
    func setPath(path: UIBezierPath?, named name: String) {
        bezierPaths[name] = path;
        setNeedsDisplay();
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke();
        }
    }
    

}
