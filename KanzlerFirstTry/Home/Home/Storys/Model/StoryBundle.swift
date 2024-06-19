//
//  StoryBundle.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 22.04.2024.
//

import SwiftUI
import Firebase

struct StoryBundle: Identifiable, Hashable {
    var id = UUID().uuidString
    var profileImage: String
    var isSeen: Bool = false
    var stories: [Story]
    var latestTimestamp: Timestamp {
        stories.max(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })?.timestamp ?? Timestamp(date: Date())
    }
}

struct Story: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
    let timestamp: Timestamp
}
