//
//  TabBarView.swift
//  NasaAppTest
//
//  Created by Никита Попов on 20.12.23.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.colorScheme) var baseColor
    @State private var currentSect = 0
    
//    init(){
//        UITabBar.appearance().isHidden = true
//    }
    var body: some View {
        ZStack( alignment: .bottom){
            VStack {
                TabView(selection: $currentSect) {
                    ContentView()
                        .tabItem {
                            Label("Daily", systemImage: "calendar")
                        }
                        .tag(0)
                    
                    RandomPicView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                        .tag(1)
                    
                    FavoriteView()
                        .tabItem {
                            Label("Favorite", systemImage: "heart")
                        }
                        .tag(2)
                }
            .tint(baseColor == .light ? .black : .white )
            }
            
            
//            VStack {
//                Spacer()
//                TabBarPrototype(selectedTag: $currentSect)
//            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    TabBarView()
}
