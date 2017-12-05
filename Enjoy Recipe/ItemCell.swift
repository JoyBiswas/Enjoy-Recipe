//
//  ItemCell.swift
//  Enjoy Recipe
//
//  Created by MacBook Air on 12/4/17.
//  Copyright © 2017 MacBook Air. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb:UIImageView!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var ingredients: UILabel!
    
    @IBOutlet weak var steps: UITextView!
    
    func configureCell(item: Item) {
        
        title.text = item.title
        time.text = "\(item.time) m"
        ingredients.text = item.ingredients
        steps.text = item.steps
        thumb.image = item.toImage?.image as? UIImage
        
    }
    
}
