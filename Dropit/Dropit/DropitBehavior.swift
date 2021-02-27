//
//  DropitBehavior.swift
//  Dropit
//
//  Created by robot on 2/26/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class DropitBehavior: UIDynamicBehavior
{
    let gravity = UIGravityBehavior();
    
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior();
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true;
        return lazilyCreatedCollider;
    }()
    
    lazy var dropBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedDropBehavior = UIDynamicItemBehavior();
        lazilyCreatedDropBehavior.allowsRotation = true;
        lazilyCreatedDropBehavior.elasticity = 0.75;
        return lazilyCreatedDropBehavior;
    }()
    
    override init() {
        super.init();
        addChildBehavior(gravity);
        addChildBehavior(collider);
        addChildBehavior(dropBehavior);
    }
    
    func addBarrier(path: UIBezierPath, named name: String) {
        collider.removeBoundary(withIdentifier: name as NSCopying);
        collider.addBoundary(withIdentifier: name as NSCopying, for: path);
    }
    
    func addDrop(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop);
        gravity.addItem(drop);
        collider.addItem(drop);
        dropBehavior.addItem(drop);
    }
    
    func removeDrop(drop: UIView) {
        gravity.removeItem(drop);
        collider.removeItem(drop);
        dropBehavior.removeItem(drop);
        drop.removeFromSuperview();
    }

}
