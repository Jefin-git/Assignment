//
//  ListTableViewCell.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
