//
//  ContentView.swift
//  NasaAppTest
//
//  Created by Никита Попов on 12.12.23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectionDate: Date = Date()
    @ObservedObject var model = PhotoDayViewModel()
    @State private var isShowDetails = false
    @State private var isFavorite = false
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(entity: FavoriteObject.entity(), sortDescriptors: []) private var allItems: FetchedResults<FavoriteObject>
    
    
    var body: some View {
        NavigationView{
            VStack {
                if let currentItem = model.currentItem{
                    NasaItemInfo(item: currentItem, context: context, isFavorite: $model.isFavorite, isShowDetails: $isShowDetails)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    DatePicker(selection: $selectionDate, in: model.getCurrentDaterange(), displayedComponents: .date) {
                        //
                    }
                }
            }
            .navigationTitle("Picture of The Day")
            .frame(maxWidth: .infinity)
        }
        .onAppear{
            Task{
                try await model.fetchPic(date: selectionDate)
            }
            
        }
        .onChange(of: selectionDate, perform: { value in
            Task{
                try await model.fetchPic(date: selectionDate)
            }
            
        })
        
    }
    
    private func checkFavoritePic()-> Bool{
        for im in allItems{
            if im.urlString ?? "" == model.currentItem?.url || im.urlString ?? "" == model.currentItem?.hdUrl ?? ""{
                return true
            }
        }
        if model.isFavorite{
            return true
        }
        return false
    }
}

#Preview {
    ContentView()
}
