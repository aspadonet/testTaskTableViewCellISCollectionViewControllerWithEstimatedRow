//
//  FotoTableViewCell.swift
//  TestPhotoLab
//
//  Created by Alexander Avdacev on 16.02.22.
//

import UIKit

protocol FotoAddDelegate: AnyObject  {
    func fotoAdd()
}

class FotoTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    weak var  delegate: FotoAddDelegate!
    
    var outView: UIView = {
        let view = UIView()
        return view
    }()
    
    var inView: UIView = {
        let view = UIView()
        return view
    }()
    
    var photo: [Photo] = [] {
        didSet{
            baseCollectionViewController.photo = photo
        }
    }
    var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "labButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.layer.borderWidth = 0
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.backgroundColor = .clear
        tf.text = "You can edit on click"
        return tf
    }()
    
    var baseCollectionViewController = BaseCollectionViewController()
    var collectionViewHeight: NSLayoutConstraint?
    var collectionOutViewHeight: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate=self
        plusButton.addTarget(self, action: #selector(addFoto), for: .touchUpInside)
        outView.layer.shadowColor = UIColor.black.cgColor
        outView.layer.shadowRadius = 7
        outView.layer.shadowOpacity = 0.7
        outView.layer.shadowOffset = CGSize(width: 5.5, height: 5.5)
        outView.layer.cornerRadius = 30.0
        outView.backgroundColor = .white
        inView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 0.9999999404, alpha: 1)
        inView.layer.cornerRadius = 30.0
        addConstraint()
        
    }
    
    @objc func addFoto() {
        delegate?.fotoAdd()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Откинуть клавиатуру
        textField.resignFirstResponder()
        // Распечатать значение в текстовом поле
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.isEnabled = true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.textField.isEnabled = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            print("\(String(describing: textField.text))")
            
        })
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
        self.textField.isEnabled = true
    }
    
    var timer: Timer?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEditing{
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                DispatchQueue.main.async {
                    self.textField.isEnabled = false
                }
            })
        }
        
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        //Comment: here we give the collectionView to layout it's items with a very large height so it will take all the space he needs and then we calculate the cell height with all the constraints in place (this method is called after the storyboard constraints are set so you have to take them into account
        //Maybe it clearer to write all these outlets by code and keep constants for the constraints and not use constraint outlets
        
        baseCollectionViewController.view.frame = CGRect(x: baseCollectionViewController.view.frame.origin.x, y: baseCollectionViewController.view.frame.origin.y, width: baseCollectionViewController.view.frame.width , height: 10000)
        
        baseCollectionViewController.view.layoutIfNeeded()

        let newCellSize = CGSize(width: baseCollectionViewController.collectionViewLayout.collectionViewContentSize.width, height: baseCollectionViewController.collectionViewLayout.collectionViewContentSize.height + collectionViewHeight!.constant + collectionOutViewHeight!.constant * 2 + 10)
        return newCellSize
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //layoutIfNeeded()
    }
    
    fileprivate func addConstraint() {
        self.addSubview(outView)
        outView.addSubview(inView)
        contentView.addSubview(baseCollectionViewController.view)
        contentView.addSubview(textField)
        contentView.addSubview(plusButton)
        outView.translatesAutoresizingMaskIntoConstraints = false
        inView.translatesAutoresizingMaskIntoConstraints = false
        baseCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            outView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            outView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            outView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            outView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            inView.topAnchor.constraint(equalTo: outView.topAnchor, constant: 15),
            inView.bottomAnchor.constraint(equalTo: outView.bottomAnchor, constant: -15),
            inView.leadingAnchor.constraint(equalTo: outView.leadingAnchor, constant: 15),
            inView.trailingAnchor.constraint(equalTo: outView.trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            baseCollectionViewController.view.topAnchor.constraint(equalTo: inView.topAnchor, constant: 100),
            baseCollectionViewController.view.bottomAnchor.constraint(equalTo: inView.bottomAnchor, constant: 0),
            baseCollectionViewController.view.leadingAnchor.constraint(equalTo: inView.leadingAnchor, constant: 0),
            baseCollectionViewController.view.trailingAnchor.constraint(equalTo: inView.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: inView.topAnchor, constant: 15),
            plusButton.trailingAnchor.constraint(equalTo: inView.trailingAnchor, constant: -15),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: inView.topAnchor, constant: 15),
            textField.leadingAnchor.constraint(equalTo: inView.leadingAnchor, constant: 15),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        collectionViewHeight = baseCollectionViewController.view.topAnchor.constraint(equalTo: inView.topAnchor, constant: 100)
        collectionOutViewHeight = inView.topAnchor.constraint(equalTo: outView.topAnchor, constant: 15)
    }
}
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    var height: CGFloat = 280
//
//    if indexPath.item == 0 {
//        // calculate the necessary size for our cell somehow
//        let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
//
//        dummyCell.layoutIfNeeded()
//
//        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: view.frame.height))
//        height = estimatedSize.height

//
//    return .init(width: view.frame.width, height: height)
//}
