//
//  HappinessViewController.swift
//  Happiness
//
//  Created by robot on 2/19/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    
    @IBOutlet weak var faceView: Faceview! {
        didSet {
            faceView.dataSource = self;
        }
    }
    
    var happiness: Int = 100
        { // 0 = lugubrious, 100 = ecstatic
        didSet
        {
            happiness = min(max(happiness, 0), 100);
            print("happiness = \(happiness)");
            updateUI();
        }
    }
    private func updateUI()
    {
        faceView?.setNeedsDisplay();
        title = "\(happiness)";
    }
    func smilinessForFaceView(sender: Faceview) -> Double? {
        return Double(happiness-50)/50;
    }
}
