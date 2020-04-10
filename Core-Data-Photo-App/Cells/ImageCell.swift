//
//  ImageCell.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    public func configureCollectionViewCell(for imageInfo: Hit) {
        
        imageView.kf.setImage(with: URL(string: imageInfo.webformatURL ?? ""))
        
    }
}
