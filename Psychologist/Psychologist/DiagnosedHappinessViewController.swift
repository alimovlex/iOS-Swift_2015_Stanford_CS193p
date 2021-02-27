//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by robot on 2/23/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit;

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate
{
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness];
        }
    }
    
    private let defaults = UserDefaults.standard;
    
    var diagnosticHistory: [Int] {
        get {
            return defaults.object(forKey: History.DefaultsKey) as? [Int] ?? [];
        }
        
        set{
            defaults.set(newValue, forKey: History.DefaultsKey);
        }
    }
    
    private struct History
    {
        static let SegueIdentifier = "Show Diagnostic History";
        static let DefaultsKey = "DiagnosedHappinessViewController.History";
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destination as? TextViewController {
                    if let ppc = tvc.popoverPresentationController { //Supressing the full screen mode of popover controller on iPhone
                        ppc.delegate = self;
                    }
                    tvc.text = "\(diagnosticHistory)";
                }
            default:
                break;
            }
        }
    }
    //Supressing the full screen mode of popover controller on iPhone
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none;
    }
}


