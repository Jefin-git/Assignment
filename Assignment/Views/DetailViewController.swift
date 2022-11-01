//
//  DetailViewController.swift
//  Assignment
//
//  Created by Jefin on 01/11/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var item: Items? = nil
    let detailViewModel: DetailViewable
    
    init(detailViewModel: DetailViewable) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.detailViewModel = DetailViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    func initialSetup() {
        guard let item = item else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = item.title
            self.descriptionTextView.text = item.description
            self.posterImageView.getCachedImage(url: item.imageUrl)
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let item = item else { return }
        if detailViewModel.saveItemToDatabase(item) {
            self.showAlertController(title: "Success", message: "Data has been saved into Core Database successfully!")
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        guard let item = item else { return }
        if detailViewModel.deleteItemFromDatabase(item) {
            self.showAlertController(title: "Success", message: "Data has been deleted from the Core Database successfully!")
        } else {
            self.showAlertController(title: "Error", message: "There is no such data to delete in the core database")
        }
    }

    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
