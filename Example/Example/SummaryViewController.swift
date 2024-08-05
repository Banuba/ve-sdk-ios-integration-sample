//
//  SummaryViewController.swift
//  Example
//
//  Created by Andrey Sak on 2.08.24.
//

import UIKit

class SummaryViewController: UIViewController {
    
    var editCoverHandler: (() -> Void)?
    
    var coverImage: UIImage?
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .navBackArrow), for: .normal)
        return button
    }()
    
    private let editCoverButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2.0
        button.setTitle("Edit cover", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        view.addSubview(coverImageView)
        coverImageView.image = coverImage
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.widthAnchor.constraint(equalToConstant: 180),
            coverImageView.heightAnchor.constraint(equalToConstant: 320),
            coverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(editCoverAction), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 45),
            backButton.heightAnchor.constraint(equalToConstant: 45),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0)
        ])
        
        view.addSubview(editCoverButton)
        editCoverButton.addTarget(self, action: #selector(editCoverAction), for: .touchUpInside)
        editCoverButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editCoverButton.widthAnchor.constraint(equalToConstant: 140),
            editCoverButton.heightAnchor.constraint(equalToConstant: 45),
            editCoverButton.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor),
            editCoverButton.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 10.0)
        ])
    }
    
    @IBAction func editCoverAction(_ sender: Any) {
        // 6. Back to editing cover
        editCoverHandler?()
    }
}
