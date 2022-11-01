//
//  ConnectivityManager.swift
//  Assignment
//
//  Created by Jefin on 01/11/22.
//

import Combine
import Network

final class ConnectivityManager {
    static let shared = ConnectivityManager()
    let monitor: NWPathMonitor!
    let networkQueue = DispatchQueue.global(qos: .background)
    @Published var isNetworkConnected: Bool?
    
    init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: networkQueue)
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
            self.isNetworkConnected = path.status == .satisfied
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
