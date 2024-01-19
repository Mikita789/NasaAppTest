//
//  FavoriteView.swift
//  NasaAppTest
//
//  Created by Никита Попов on 28.12.23.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @FetchRequest(sortDescriptors: []) private var allItems: FetchedResults<FavoriteObject>
    @Environment(\.managedObjectContext) private var context
    
    private let columns:[GridItem] = [GridItem(.flexible(minimum: 100, maximum: .infinity)),
                                      GridItem(.flexible(minimum: 100, maximum: .infinity))
    ]
    
    @State private var isShowDetails : Bool = false
    @State private var currentPhoto: NasaUserItemModel?
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical){
                    LazyVGrid(columns: columns) {
                        ForEach(allItems){ dataItem in
                            ZStack(alignment: .topTrailing){
                                RandonImageNasaView(item: self.dataItemToUserItem(dataItem),
                                                    isFavoriteView: true)
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        DataManager.shared.deleteItem(item: dataItem, context: context)
                                    }
                                    
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .symbolRenderingMode(.hierarchical)
                                    
                                })
                                .offset(x: -1, y: 5)
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Favorite")
                
            }
            .sheet(isPresented: $isShowDetails, content: {
                //detail view
                
                if let currentItem = self.currentPhoto{
                    DetailsView(currentItem: currentItem)
                }
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        for item in allItems{
                            DataManager.shared.deleteItem(item: item, context: context)
                        }
                    }, label: {
                        Image(systemName: "trash")
                    })
                }
            }
        }
    }
    
    private func dataItemToUserItem(_ dataItem: FavoriteObject) -> NasaUserItemModel{
        let item = NasaUserItemModel(dataItem: dataItem)
        return item
    }
}

#Preview {
    FavoriteView()
}
