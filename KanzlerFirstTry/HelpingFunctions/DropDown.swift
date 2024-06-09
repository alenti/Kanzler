//
//  SwiftUIView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 17.12.2023.
//

import SwiftUI

struct DropDown: View {
    var hint: String
    var options: [String]
    var anchor: Anchor = .bottom
    var cornerRadius: CGFloat = 10
    @Binding var selection: String?
    
    @State private var showOptions: Bool = false
    
    @Environment(\.colorScheme) private var scheme
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex: Double = 1000.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if showOptions && anchor == .top {
                    OptionsView()
                }
                HStack(spacing: 0) {
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? .gray : .primary)
                        .lineLimit(1)
                    
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .rotationEffect(.init(degrees: showOptions ? -180 : 0))
                }
                .padding(.horizontal, 15) // отступ стрeлочек
                .frame(width: geometry.size.width, height: 50)
                //.background(scheme == .dark ? Color.black : Color.white)
                .contentShape(Rectangle())
                .onTapGesture {
                    index += 1
                    zIndex = index
                    withAnimation(.snappy) {
                        showOptions.toggle()
                    }
                    UIApplication.shared.hideKeyboard()
                }
                .zIndex(10)
                
                if showOptions && anchor == .bottom {
                    OptionsView()
                }
            }
            .clipped()
            .contentShape(Rectangle())
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.red, lineWidth: 1) // Добавляем красную обводку
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(scheme == .dark ? Color.black : Color.white)
                    )
            )
            .frame(height: 50, alignment: anchor == .top ? .bottom : .top)
        }
        .frame(maxWidth: .infinity) // Используем maxWidth для адаптивной ширины
        .zIndex(zIndex)
    }
    
    func calculateHeight() -> CGFloat {
        let itemHeight: CGFloat = 45 // Высота одного элемента
        let totalHeight = itemHeight * CGFloat(options.count) + 20 // Общая высота + padding
        let maxHeight = UIScreen.main.bounds.height / 3 // Максимальная высота - высота экрана

        return min(totalHeight, maxHeight)
    }
    
    @ViewBuilder
    func OptionsView() -> some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(options, id: \.self) { option in
                    HStack(spacing: 0) {
                        Text(option)
                            .lineLimit(1)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .opacity(selection == option ? 1 : 0)
                    }
                    .foregroundStyle(selection == option ? Color.primary : Color.gray)
                    .animation(.none, value: selection)
                    .frame(height: 40)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selection = option
                            showOptions = false
                        }
                        UIApplication.shared.hideKeyboard()
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .transition(.move(edge: anchor == .top ? .bottom : .top))
            // Adding Transition
        }
        .frame(height: calculateHeight())
    }
    
    enum Anchor {
        case top
        case bottom
    }
}

#Preview {
    Registration()
}
