//
//  AltTabBar.swift
//  NasaAppTest
//
//  Created by Никита Попов on 27.12.23.
//

import SwiftUI

struct AltTabBar: View {
    @State private var selectedTag: Int = 0
    
    var body: some View {
        
        VStack {
            Spacer()

            HStack(spacing: 40){
                ForEach(Array(AltTabBarItems.allCases), id: \.self) { item in
                    HStack{
                        Image(item.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        item.rawValue == self.selectedTag ? Text(item.textIcon) : nil
                    }
                    .font(.system(size: item.rawValue == self.selectedTag ? 25 : 16))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .background(item.rawValue == self.selectedTag ? Color.gray.opacity(0.1) : nil)
                    .clipShape(.capsule)
                    .onTapGesture{
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.selectedTag = item.rawValue
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 10)
            .shadow(color: .black, radius: 3)
            .ignoresSafeArea()
        }

    }
}

#Preview {
    AltTabBar()
}

enum AltTabBarItems:Int, CaseIterable{
    case home = 0
    case search
    case favorite
    
    var icon:String{
        switch self{
            
        case .home:
            return "homeIcon"
        case .search:
            return "searchIcon"
        case .favorite:
            return "favoriteIcon"
        }
    }
    
    var textIcon:String{
        switch self{
            
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .favorite:
            return "Favorite"
        }
    }
    
}
