//
//  StoryViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 22.04.2024.
//

import Firebase
import FirebaseStorage
import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var stories: [StoryBundle] = []
    @Published var showStory: Bool = false
    @Published var currentStory: String = ""
    @Published var isLoading: Bool = false
    private var isDataLoaded: Bool = false
    
    func fetchStoriesIfNeeded() {
        if !isDataLoaded {
            fetchStories()
        }
    }
    
    func fetchStories() {
        isLoading = true
        let db = Firestore.firestore()
        let storiesRef = db.collection("stories")

        storiesRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching stories: \(String(describing: error?.localizedDescription))")
                self.isLoading = false
                return
            }
            
            var storyBundles = [StoryBundle]()
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                let data = document.data()
                let profileImagePath = data["profileImage"] as? String ?? ""
                let storiesData = data["stories"] as? [[String: Any]] ?? []
                var stories = [Story]()
                
                dispatchGroup.enter()
                self.fetchImageURL(for: profileImagePath) { profileImageURL in
                    var resolvedProfileImage = profileImagePath
                    if let url = profileImageURL {
                        resolvedProfileImage = url
                    }
                    
                    let innerDispatchGroup = DispatchGroup()
                    for storyData in storiesData {
                        let imageURL = storyData["imageURL"] as? String ?? ""
                        let timestamp = storyData["timestamp"] as? Timestamp ?? Timestamp(date: Date())
                        
                        innerDispatchGroup.enter()
                        self.fetchImageURL(for: imageURL) { url in
                            if let url = url {
                                let story = Story(imageURL: url, timestamp: timestamp)
                                stories.append(story)
                            }
                            innerDispatchGroup.leave()
                        }
                    }
                    
                    innerDispatchGroup.notify(queue: .main) {
                        stories.sort { $0.timestamp.dateValue() < $1.timestamp.dateValue() }
                        let storyBundle = StoryBundle(profileImage: resolvedProfileImage, stories: stories)
                        storyBundles.append(storyBundle)
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.stories = storyBundles.sorted { $0.latestTimestamp.dateValue() > $1.latestTimestamp.dateValue() }
                self.isLoading = false
                self.isDataLoaded = true
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
