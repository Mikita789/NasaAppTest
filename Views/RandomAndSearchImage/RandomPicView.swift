//
//  RandomPicView.swift
//  NasaAppTest
//
//  Created by Никита Попов on 14.12.23.
//

import SwiftUI

struct RandomPicView: View {
    @ObservedObject private var model = RandomPickViewModel()
    private let columns:[GridItem] = [GridItem(.flexible(minimum: 100, maximum: .infinity)),
                                      GridItem(.flexible(minimum: 100, maximum: .infinity))
    ]
    
    @State private var isShowDetail = false
    @State private var currentPhotoItem: NasaUserItemModel?
    @State private var searchText = ""
    @State private var selectedItem: NasaUserItemModel?
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical){
                    LazyVGrid(columns: columns){
                        ForEach(model.allPic, id: \.id) { item in
                            RandonImageNasaView(item: item)
                                .onTapGesture {
                                    print(item.title)
                                    self.selectedItem = item
                                    self.isShowDetail = true
                                }
                        }
                    }
                }
                
                .refreshable {
                    Task{
                        searchText == "" ? try await model.getRandPic() : try await model.getSearchItems(text: searchText)
                    }
                }
                .searchable(text: $searchText)
                .onChange(of: searchText, perform: { value in
                    if !value.isEmpty && value != "" && value.count > 2 {
                        Task{
                            try await model.getSearchItems(text: value)
                        }
                    }else {
                        Task{
                            try await model.getRandPic()
                        }
                    }
                })
                .padding()
                .scrollIndicators(.never)
                .frame(maxWidth: .infinity)

            }
            .sheet(isPresented: $isShowDetail, content: {
                if let selectedItem = self.selectedItem{
                    DetailsView(currentItem: selectedItem)
                }
            })
            .navigationTitle("Pictures of The Day")
        }
    }
    
    
}

#Preview {
    RandomPicView()
}
