//
//  ViewController.swift
//  TestPhotoLab
//
//  Created by Alexander Avdacev on 16.02.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,FotoAddDelegate {
    
    var photo = [Photo]()
    
    var labImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "labHeader"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0
        return imageView
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FotoTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var imageView: UIImage? {
        didSet{ self.photo.append(Photo(image: imageView!))
            tableView.reloadData()
        }
    }
    
    func selectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func fotoAdd() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerController delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edidImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageView = edidImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    // MARK: - setup Circular Image Style
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addConstraint()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 440.0
        self.tableView.allowsSelection = false
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = CGRect(x: 0, y: 160, width: view.bounds.size.width , height: view.bounds.size.height)
    }
    
    func addConstraint(){
        view.addSubview(tableView)
        view.addSubview(labImage)
        labImage.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            labImage.heightAnchor.constraint(equalToConstant: 65),
            labImage.widthAnchor.constraint(equalToConstant: 368),
            labImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            //labImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: labImage.centerYAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: labImage.centerXAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FotoTableViewCell
        cell.delegate = self
        cell.photo = photo        
        return cell
    }
    
}

