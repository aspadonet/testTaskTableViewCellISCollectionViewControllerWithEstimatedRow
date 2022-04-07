//
//  PhotoViewController.swift
//  TestPhotoLab
//
//  Created by Alexander Avdacev on 23.02.22.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        addConstraint()
    }
    
    @objc func closeVC() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func addConstraint() {
        view.addSubview(imageView)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
    
}
