//
//  tempCell.swift
//  TestPhotoLab
//
//  Created by Alexander Avdacev on 18.02.22.
//
import UIKit

class ButtonCollectionCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    internal let reuseIdentifier2 = "Cell"
    
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var collectionViewDistanceFromCellBottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var distanceBetweenCollectionToLabelConstraint: NSLayoutConstraint!
//    @IBOutlet weak var buttonsCollectionView: UICollectionView!
    
    var outView: UIView = {
       let view = UIView()
        return view
    }()
    var inView: UIView = {
       let view = UIView()
        return view
    }()
    
    internal  var buttonsCollectionView: UICollectionView!
    var collectionViewHeight: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        self.buttonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.delegate = self
        buttonsCollectionView.showsHorizontalScrollIndicator = false
        buttonsCollectionView.isPagingEnabled = true
        buttonsCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier2)
        buttonsCollectionView.backgroundColor = .clear
        buttonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
       
        outView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        inView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        self.addSubview(outView)
//        self.bounds.height = baseCollectionViewController.view.frame.height
        outView.addSubview(inView)
        inView.addSubview(buttonsCollectionView)
        
        //bottomConstraint = self.bottomAnchor.constra//.constraint(equalTo: baseCollectionViewController.view.frame.width)
        outView.layer.shadowColor = UIColor.black.cgColor
        outView.layer.shadowRadius = 7
        outView.layer.shadowOpacity = 0.7
        outView.layer.shadowOffset = CGSize(width: 5.5, height: 5.5)
        outView.layer.cornerRadius = 30.0
        
        outView.translatesAutoresizingMaskIntoConstraints = false
        inView.translatesAutoresizingMaskIntoConstraints = false
        buttonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        outView.backgroundColor = .white
        inView.backgroundColor = .gray
        inView.layer.cornerRadius = 30.0
        
        NSLayoutConstraint.activate([
            outView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            outView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            outView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            outView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
        ])
        NSLayoutConstraint.activate([
            inView.topAnchor.constraint(equalTo: outView.topAnchor, constant: 15),
            inView.bottomAnchor.constraint(equalTo: outView.bottomAnchor, constant: -15),
            inView.leadingAnchor.constraint(equalTo: outView.leadingAnchor, constant: 15),
            inView.trailingAnchor.constraint(equalTo: outView.trailingAnchor, constant: -15),
            
        ])
        
        NSLayoutConstraint.activate([
            buttonsCollectionView.topAnchor.constraint(equalTo: inView.topAnchor, constant: 100),
           // baseCollectionViewController.view.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            buttonsCollectionView.leadingAnchor.constraint(equalTo: inView.leadingAnchor, constant: 0),
            buttonsCollectionView.trailingAnchor.constraint(equalTo: inView.trailingAnchor, constant: 0),
            
        ])
        collectionViewHeight = buttonsCollectionView.heightAnchor.constraint(equalToConstant: 640)
        collectionViewHeight?.isActive = true
        bottomAnchor.constraint(equalTo: buttonsCollectionView.bottomAnchor, constant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        //Comment: here we give the collectionView to layout it's items with a very large height so it will take all the space he needs and then we calculate the cell height with all the constraints in place (this method is called after the storyboard constraints are set so you have to take them into account
//        //Maybe it clearer to write all these outlets by code and keep constants for the constraints and not use constraint outlets
//
//        buttonsCollectionView.frame = CGRect(x: buttonsCollectionView.frame.origin.x, y: buttonsCollectionView.frame.origin.y, width: buttonsCollectionView.frame.width , height: 10000)
//
//        buttonsCollectionView.layoutIfNeeded()
//
////        let newCellSize = CGSize(width: buttonsCollectionView.collectionViewLayout.collectionViewContentSize.width, height: buttonsCollectionView.collectionViewLayout.collectionViewContentSize.height + collectionViewDistanceFromCellBottomConstraint.constant + distanceBetweenCollectionToLabelConstraint.constant + titleLabel.frame.height)
//        let newCellSize = CGSize(width: buttonsCollectionView.collectionViewLayout.collectionViewContentSize.width, height: buttonsCollectionView.collectionViewLayout.collectionViewContentSize.height)
//        return newCellSize
//    }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 11
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath) as! BaseCollectionViewCell
    
        // Configure the cell
    
        return cell
    }

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: (buttonsCollectionView.bounds.width - 64) / 3, height: (buttonsCollectionView.bounds.width - 64) / 3)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 16, left: 16, bottom: 16, right: 16)
//    }
}
