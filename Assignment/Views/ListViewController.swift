//
//  ListViewController.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import UIKit
import Combine

class ListViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    let listViewModel: ListViewModel
    let connectivityManager: ConnectivityManager
    var username: String = ""
    var listItems = [Items]()
    var subscriptions = Set<AnyCancellable>()
    
    init(listViewModel: ListViewModel,
         connectivityManager: ConnectivityManager) {
        self.listViewModel = listViewModel
        self.connectivityManager = connectivityManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.listViewModel = ListViewModel(networkManager: NetworkingManager())
        self.connectivityManager = ConnectivityManager.shared
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectivityManager.startMonitoring()
        initialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        connectivityManager.stopMonitoring()
    }
    
    func initialSetup() {
        usernameLabel.text = username
        bindNetworkConnectivity()
        listViewModel.$items.sink { items in
            DispatchQueue.main.async {
                self.listItems = items
                self.listTableView.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    func bindNetworkConnectivity() {
        connectivityManager.$isNetworkConnected.sink { isConnected in
            if let connected = isConnected {
                if !connected {
                    self.showAlertController(title: "Error", message: "Please check your network connection")
                }
            }
        }.store(in: &subscriptions)
    }
    
    func navigateToDetailScreen(_ item: Items) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        controller.item = item
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let item = listItems[indexPath.row]
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.posterImageView.getCachedImage(url: item.imageUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailScreen(listItems[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
