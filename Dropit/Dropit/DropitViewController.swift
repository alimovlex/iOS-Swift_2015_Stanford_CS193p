//
//  DropitViewController.swift
//  Dropit
//
//  Created by robot on 2/26/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate
{

    @IBOutlet weak var gameView: BezierPathsView!;
    
    lazy var animator: UIDynamicAnimator = {
    let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView);
        lazilyCreatedDynamicAnimator.delegate = self;
    return lazilyCreatedDynamicAnimator;
    }()
    
    let dropitBehavior = DropitBehavior();
    
    var dropsPerRow = 10;
    
    var dropSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow);
        return CGSize(width: size, height: size);
    }
    
    struct PathNames {
        static let MiddleBarrier = "Middle Barrier";
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        let barrierSize = dropSize;
        let barrierOrigin = CGPoint(x: gameView.bounds.midX - barrierSize.width/2, y: gameView.bounds.midY - barrierSize.height/2);
        let path = UIBezierPath(ovalIn: CGRect(origin: barrierOrigin, size: barrierSize));
        dropitBehavior.addBarrier(path: path, named: PathNames.MiddleBarrier);
        gameView.setPath(path: path, named: PathNames.MiddleBarrier);
    }
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        removeCompletedRow();
    }
    
    @IBAction func drop(_ sender: UITapGestureRecognizer)
    {
        drop();
    }
    
    func drop() {
        var frame = CGRect(origin: CGPoint.zero, size: dropSize);
        frame.origin.x = CGFloat.random(max:dropsPerRow) * dropSize.width;
        
        let dropView = UIView(frame: frame);
        dropView.backgroundColor = UIColor.random;
        
        dropitBehavior.addDrop(drop: dropView);
    }
    
    func removeCompletedRow() {
        var dropsToRemove = [UIView]();
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height);
        repeat {
            dropFrame.origin.y -= dropSize.height;
            dropFrame.origin.x = 0;
            var dropsFound = [UIView]();
            var rowIsComplete = true;
            for _ in  0..<dropsPerRow {
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), with: nil) {
                    if hitView.superview == gameView {
                        dropsFound.append(hitView);
                    } else {
                        rowIsComplete = false;
                    }
                }
                dropFrame.origin.x += dropSize.width;
            }
            if rowIsComplete {
                dropsToRemove += dropsFound;
            }
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0;
        for drop in dropsToRemove {
            dropitBehavior.removeDrop(drop: drop);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        animator.addBehavior(dropitBehavior);
    }
    
}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max));
    }
}

private extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
        case 0: return UIColor.green;
        case 1: return UIColor.blue;
        case 2: return UIColor.orange;
        case 3: return UIColor.red;
        case 4: return UIColor.purple;
        default: return UIColor.black;
        }
    }
}
