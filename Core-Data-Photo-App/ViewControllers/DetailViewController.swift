//
//  DetailViewController.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    
    @IBOutlet weak var heartButton: UIBarButtonItem!
    
    var imageInfo: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        guard let image = imageInfo else {
            fatalError("check prepare for segue")
        }
        if let userName = image.user{
            userLabel.text = "user: \(userName)"
        } else {
            userLabel.text = "user: nothing"

        }
        
        tagsLabel.text = image.tags
        likesLabel.text = "likes: \(image.likes?.description ?? "")"
        favoritesLabel.text = "favorited by \(image.favorites?.description ?? "0") users"
        
        detailImageView.kf.setImage(with: URL(string: image.largeImageURL ?? ""))
    }
    

    

    @IBAction func heartButtonPressed(_ sender: UIBarButtonItem) {
    }
    

}
