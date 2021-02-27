//
//  ViewController.swift
//  Psychologist
//
//  Created by robot on 2/22/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController
{
    //creating segues in code
    
    @IBAction func nothing(_ sender: UIButton) {
        performSegue(withIdentifier: "nothing", sender: nil);
    }
    //----------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var destination = segue.destination as? UIViewController;
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController;
        }
        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "sad":
                    hvc.happiness = 0;
                case "happy":
                    hvc.happiness = 100;
                case "nothing": hvc.happiness = 25;
                default:
                    hvc.happiness = 50;
                }
            }
        }
    }

}

