//
//  ImageViewController.swift
//  Cassini
//
//  Created by robot on 2/24/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{
    var imageURL: NSURL? {
        didSet {
            image = nil;
            if view.window != nil {
                fetchImage();
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private func fetchImage()
    {
        if let url = imageURL {
            spinner?.startAnimating();
            let background = DispatchQueue.global(); //multithreading GCD
            background.async
             {
                let imageData = NSData(contentsOf: url as URL);
                let main = DispatchQueue.main; //multithreading GCD
                main.async {
                    if url == self.imageURL {
                    if imageData != nil {
                        self.image = UIImage(data: imageData! as Data);
                    } else {
                        self.image = nil;
                    }
                    }
                }
                
            }
            
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size;
            scrollView.delegate = self;
            scrollView.minimumZoomScale = 0.03;
            scrollView.maximumZoomScale = 1.0;
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView;
    }
    
    //creating UIImageView in code
    private var imageView = UIImageView();
    
    private var image: UIImage? {
        get {
            return imageView.image;
        }
        set {
            imageView.image = newValue;
            imageView.sizeToFit();
            scrollView?.contentSize = imageView.frame.size;
            spinner?.stopAnimating();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        scrollView.addSubview(imageView);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if image == nil {
            fetchImage();
        }
    }
}
