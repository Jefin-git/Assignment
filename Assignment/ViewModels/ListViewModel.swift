//
//  ListViewModel.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation

class ListViewModel {
    
    @Published var items = [Items]()
    let networkManager: NetworkingManageable
    
    init(networkManager: NetworkingManageable) {
        self.networkManager = networkManager
        getItems()
    }
    
    //MARK: Method to get the items from the API
    func getItems() {
        DispatchQueue.global(qos: .background).async {
            self.networkManager.getItems { result in
            switch result {
            case .success(let items):
                self.items = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    }
}
