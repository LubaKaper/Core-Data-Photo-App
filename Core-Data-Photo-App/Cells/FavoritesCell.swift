//
//  FavoritesCell.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher

class FavoritesCell: UITableViewCell {

    
    @IBOutlet weak var faveImageView: UIImageView!
    
    public func configureCell(for fave: Favorite) {
        faveImageView.kf.setImage(with: URL(string: fave.image ?? ""))
    }
    
}
