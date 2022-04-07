//
//  BaseCollectionViewController.swift
//  TestPhotoLab
//
//  Created by Alexander Avdacev on 17.02.22.
//

import UIKit

private let reuseIdentifier = "Cell"

class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var photo: [Photo] = [] {
        didSet{ collectionView.reloadData() }
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor  = #colorLiteral(red: 1, green: 1, blue: 0.9999999404, alpha: 1)
        self.collectionView!.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.reloadData()
    }   
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BaseCollectionViewCell
        cell.fotoImage.image = photo[indexPath.row].image
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewController()
        vc.imageView.image = photo[indexPath.row].image
        vc.modalPresentationStyle = .overFullScreen
        self.view.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.bounds.width - 64) / 3, height: (view.bounds.width - 64) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}
