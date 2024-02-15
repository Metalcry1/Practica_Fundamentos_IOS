//
//  HeroesViewCell.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 6/11/23.
//

import UIKit
import Kingfisher

class HeroesViewCell: UITableViewCell {
    //MARK: - CONSTANTS -
    static let identifier: String = "HeroesViewCell"
    static let sizeCell: CGFloat = 400
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoHeroe: UIImageView!
    @IBOutlet weak var heroId: UILabel!
    @IBOutlet weak var nameHeroe: UILabel!
    
    //MARK: - FUNTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        heroId.text = nil
        nameHeroe.text = nil
        photoHeroe.image = nil
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(
        id: String? = nil,
        name: String? = nil,
        photo: String? = nil,
        description: String? = nil
    ) {
        self.heroId.text = "ID: \(id ?? "default id")"
        self.nameHeroe.text = name
        self.photoHeroe.kf.setImage(with: URL(string: photo ?? ""))
    }
    
}
