//
//  BannerViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import Firebase
import FirebaseStorage
import SwiftUI

class BannersViewModel: ObservableObject {
    @Published var promotions: [BannerModel] = []
    @Published var interesting: [BannerModel] = []
    @Published var isLoading: Bool = false
    private var isDataLoaded: Bool = false
    
    func fetchBannersIfNeeded() {
        if !isDataLoaded {
            fetchBanners()
        }
    }
    
    func fetchBanners() {
        isLoading = true
        let db = Firestore.firestore()
        let bannersRef = db.collection("banners")

        fetchBannerCollection(bannersRef: bannersRef.document("promotions").collection("items")) { banners in
            DispatchQueue.main.async {
                self.promotions = banners.sorted { $0.timestamp.dateValue() < $1.timestamp.dateValue() }
                self.isLoading = false
                self.isDataLoaded = true
            }
        }
        
        fetchBannerCollection(bannersRef: bannersRef.document("interesting").collection("items")) { banners in
            DispatchQueue.main.async {
                self.interesting = banners.sorted { $0.timestamp.dateValue() < $1.timestamp.dateValue() }
                self.isLoading = false
                self.isDataLoaded = true
            }
        }
    }
    
    private func fetchBannerCollection(bannersRef: CollectionReference, completion: @escaping ([BannerModel]) -> Void) {
        bannersRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching banners: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var banners = [BannerModel]()
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                let data = document.data()
                let title = data["title"] as? String ?? ""
                let imagePath = data["imageURL"] as? String ?? ""
                let timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
                let description = data["description"] as? String ?? "" // новое поле
                
                dispatchGroup.enter()
                self.fetchImageURL(for: imagePath) { url in
                    if let url = url {
                        let banner = BannerModel(imagePath: url, title: title, timestamp: timestamp, description: description.replacingOccurrences(of: "\\n", with: "\n"))
                        banners.append(banner)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(banners)
            }
        }
    }
    
    private func fetchImageURL(for path: String, completion: @escaping (String?) -> Void) {
        guard path.hasPrefix("gs://") || path.hasPrefix("http://") || path.hasPrefix("https://") else {
            print("Invalid URL scheme for path: \(path)")
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference(forURL: path)
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching image URL: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(url?.absoluteString)
        }
    }
}
