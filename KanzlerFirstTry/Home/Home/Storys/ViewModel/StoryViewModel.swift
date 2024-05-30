//
//  StoryViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 22.04.2024.
//

import SwiftUI

class StoryViewModel: ObservableObject{
    
    @Published var stories : [StoryBundle] = [
        
        StoryBundle(profileName: "iJustine", profileImage: "instagram", stories: [
            Story(imageURL: "pan1"),
            Story(imageURL: "pan2"),
            Story(imageURL:"pan1"),
            ]),
        
        StoryBundle(profileName:"Jenna Ezarik", profileImage:"instagram",  stories: [
            Story (imageURL: "pan3"),
            Story (imageURL: "pan2"),
            ])
        ]
        
    // Properties...
    @Published var showStory: Bool = false
    // Will Be unique Story Bundle ID....
    @Published var currentStory: String = ""
    
}

//#Preview {
//    StoryViewModel()
//}
