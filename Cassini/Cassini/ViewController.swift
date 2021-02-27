//
//  ViewController.swift
//  Cassini
//
//  Created by robot on 2/24/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ivc = segue.destination as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "Earth": ivc.imageURL = DemoURL.NASA.Earth;
                ivc.title = "Earth";
                case "Saturn":
                    ivc.imageURL = DemoURL.NASA.Saturn;
                    ivc.title = "Saturn";
                case "Cassini":
                    ivc.imageURL = DemoURL.NASA.Cassini;
                    ivc.title = "Cassini";
                default:
                    break;
                }
            }
        }
    }
}

