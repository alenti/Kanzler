//
//  StoryView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 22.04.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct StoryView: View {
    @EnvironmentObject var storyData: StoryViewModel
    
    var body: some View {
        if storyData.showStory {
            TabView(selection: $storyData.currentStory) {
                ForEach($storyData.stories) { $bundle in
                    StoryCardView(bundle: $bundle)
                        .environmentObject(storyData)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .transition(.move(edge: .bottom))
        }
    }
}

struct StoryCardView: View {
    @Binding var bundle: StoryBundle
    @EnvironmentObject var storyData: StoryViewModel
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var timerProgress: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                let index = min(Int(timerProgress), bundle.stories.count - 1)
                if index >= 0 && index < bundle.stories.count {
                    let story = bundle.stories[index]
                    WebImage(url: URL(string: story.imageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(
                HStack {
                    Rectangle().fill(Color.black.opacity(0.01)).onTapGesture {
                        if (timerProgress - 1) < 0 {
                            updateStory(forward: false)
                        } else {
                            timerProgress = CGFloat(Int(timerProgress - 1))
                        }
                    }
                    Rectangle().fill(Color.black.opacity(0.01)).onTapGesture {
                        if (timerProgress + 1) > CGFloat(bundle.stories.count) {
                            updateStory()
                        } else {
                            timerProgress = CGFloat(Int(timerProgress + 1))
                        }
                    }
                }
            )
            .overlay(
                Button(action: {
                    withAnimation {
                        storyData.showStory = false
                        timerProgress = 0
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding(),
                alignment: .topTrailing
            )
            .overlay(
                HStack(spacing: 5) {
                    ForEach(0..<bundle.stories.count, id: \.self) { index in
                        GeometryReader { proxy in
                            let width = proxy.size.width
                            let progress = timerProgress - CGFloat(index)
                            let perfectProgress = min(max(progress, 0), 1)
                            Capsule()
                                .fill(Color.gray.opacity(0.5))
                                .overlay(
                                    Capsule()
                                        .fill(Color.white)
                                        .frame(width: width * perfectProgress),
                                    alignment: .leading
                                )
                        }
                    }
                }
                .frame(height: 1.4)
                .padding(.horizontal),
                alignment: .top
            )
            .onAppear {
                timerProgress = 0
            }
            .rotation3DEffect(
                getAngle(proxy: proxy),
                axis: (x: 0, y: 1, z: 0),
                anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                perspective: 2.5
            )
            .onAppear {
                timerProgress = 0
            }
        }
        .onReceive(timer) { _ in
            if storyData.currentStory == bundle.id {
                if !bundle.isSeen {
                    bundle.isSeen = true
                }
                if timerProgress < CGFloat(bundle.stories.count) {
                    timerProgress += 0.03
                } else {
                    updateStory()
                }
            }
        }
    }
    
    func updateStory(forward: Bool = true) {
        let index = min(Int(timerProgress), bundle.stories.count - 1)
        let story = bundle.stories[index]
        
        if !forward {
            if let first = storyData.stories.first, first.id != bundle.id {
                let bundleIndex = storyData.stories.firstIndex { currentBundle in
                    return bundle.id == currentBundle.id
                } ?? 0
                withAnimation {
                    storyData.currentStory = storyData.stories[bundleIndex - 1].id
                }
            } else {
                timerProgress = 0
            }
            return
        }
        
        if let last = bundle.stories.last, last.id == story.id {
            if let lastBundle = storyData.stories.last, lastBundle.id == bundle.id {
                withAnimation {
                    storyData.showStory = false
                }
                timerProgress = 0
            } else {
                let bundleIndex = storyData.stories.firstIndex { currentBundle in
                    return bundle.id == currentBundle.id
                } ?? 0
                withAnimation {
                    storyData.currentStory = storyData.stories[bundleIndex + 1].id
                }
            }
        }
    }
    
    func getAngle(proxy: GeometryProxy) -> Angle {
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        let rotationAngle: CGFloat = 45
        let degrees = rotationAngle * progress
        return Angle(degrees: Double(degrees))
    }
}


#Preview {
    HomeView(selectedTab: .constant(.home))
}
