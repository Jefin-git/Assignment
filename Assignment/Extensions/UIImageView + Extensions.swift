//
//  UIImageView + Extensions.swift
//  Assignment
//
//  Created by Jefin on 01/11/22.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    //MARK: Method to cache and get the image from the url
    func getCachedImage(url: String) {
        let cache = NSCache<NSString, UIImage>()
        if let cachedImage = cache.object(forKey: url as NSString) {
            print("Using a cached image for item: \(url)")
            DispatchQueue.main.async {
            self.image = cachedImage
            }
        } else {
            guard let imageURL = URL(string: url) else { return }
            AF.request(imageURL, method: .get).responseData { response in
                switch response.result {
                case .success(let data):
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    cache.setObject(image, forKey: url as NSString)
                    self.image = image
                }
                case .failure:
                    print(NetworkError.noData.localizedDescription)
                }
            }
        }
    }
}
