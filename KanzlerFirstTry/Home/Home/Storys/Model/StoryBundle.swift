//
//  StoryBundle.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 22.04.2024.
//

import SwiftUI

struct StoryBundle: Identifiable,Hashable {
    var id = UUID().uuidString
    var profileName: String
    var profileImage: String
    var isSeen: Bool = false
    var stories: [Story]
    
    
    
}

struct Story: Identifiable,Hashable{
    var id = UUID().uuidString
    var imageURL: String
}
//#Preview {
//    StoryBundle()
//}
