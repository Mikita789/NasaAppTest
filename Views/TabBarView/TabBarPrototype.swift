//
//  TabBarPrototype.swift
//  NasaAppTest
//
//  Created by Никита Попов on 22.12.23.
//

import SwiftUI

enum TabbarItems: Int, CaseIterable{
    case home = 0
    case search
    case favorite
    
    var title: String{
        switch self {
        case .home:
            "Home"
        case .search:
            "Search"
        case .favorite:
            "Favorete"
        }
    }
    
    var image:String{
        switch self {
        case .home:
            "house"
        case .search:
            "magnifyingglass"
        case .favorite:
            "heart"
        }
    }
    var selectedImage:String{
        self.image + ".fill"
    }
}


struct TabBarPrototype: View {
    @Binding var selectedTag:Int
    
    var body: some View {
        HStack(spacing: 30){
            Spacer()
            ForEach(TabbarItems.allCases, id: \.self){ item in
                HStack {
                    Image(systemName: item.image)
                    selectedTag == item.rawValue ? Text(item.title) : nil
                }
                .font(.system(size: item.rawValue == selectedTag ? 22 : 16))
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(.gray)
                .clipShape(.capsule)
                .overlay {
                    Capsule()
                        .stroke(Color.black, lineWidth: 0.5)
                }
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.3)) {
                        selectedTag = item.rawValue

                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color("TabbarBackground"))
        .clipShape(.capsule)
        .padding()
        
    }
}

#Preview {
    TabBarView()
}


