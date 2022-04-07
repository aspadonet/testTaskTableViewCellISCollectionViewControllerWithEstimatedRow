//
//  BaseCollectionViewCell.swift
//  TestPhotoLab
//
//  Created by Alexander Avdacev on 17.02.22.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    var fotoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "labHeader"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fotoImage.backgroundColor = .purple
        addConstraint()
    }
    fileprivate func addConstraint() {
        addSubview(fotoImage)
        NSLayoutConstraint.activate([
            fotoImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            fotoImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            fotoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            fotoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
