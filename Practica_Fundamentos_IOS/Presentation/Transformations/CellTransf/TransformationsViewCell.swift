//
//  TransformationsTableViewCell.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 10/11/23.
//

import UIKit

class TransformationsViewCell: UITableViewCell {
    //MARK: - CONSTANTS -
    static let identifier: String = "TransformationsViewCell"
    static let sizeCell: CGFloat = 400
    
    
    //MARK: - OUTLETS -
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var transformationDescription: UILabel!
    @IBOutlet weak var transformationPhoto: UIImageView!
    @IBOutlet weak var transformationName: UILabel!
    
    //MARK: - LIFECYCLE -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - FUNTIONS -
    override func prepareForReuse() {
        super.prepareForReuse()
        
        transformationName.text = nil
        transformationPhoto.image = nil
        transformationDescription.text  = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateView(
        name: String? = nil,
        photo: String? = nil,
        description: String? = nil
    ) {
        self.transformationName.text = name
        self.transformationDescription.text = description
        self.transformationPhoto.kf.setImage(with: URL(string: photo ?? ""))
    }
    
}
