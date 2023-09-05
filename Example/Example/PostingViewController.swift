//
//  PostingViewController.swift
//  Example
//
//  Created by Andrei Sak on 5.09.23.
//

import UIKit

class PostingViewController: UIViewController {
  
  var doneCallback: (() -> Void)?
  
  private let doneButton: UIButton = {
    let button = UIButton()
    button.setTitle("Done", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemBlue
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationItem.title = "Posting View Controller"
    
    view.backgroundColor = .white
    
    view.addSubview(doneButton)
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      doneButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      doneButton.widthAnchor.constraint(equalToConstant: 100),
      doneButton.heightAnchor.constraint(equalToConstant: 44.0)
    ])
    
    doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
  }
  
  @objc func doneAction() {
    doneCallback?()
  }
}
