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
