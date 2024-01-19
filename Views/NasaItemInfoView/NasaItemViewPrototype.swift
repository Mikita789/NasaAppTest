//
//  NasaItemViewPrototype.swift
//  NasaAppTest
//
//  Created by Никита Попов on 18.01.24.
//

import SwiftUI
import CoreData


struct NasaItemInfo: View {
    @Environment(\.colorScheme) private var colSch
    
    var item: NasaUserItemModel
    var context: NSManagedObjectContext
    
    @Binding var isFavorite: Bool
    @Binding var isShowDetails: Bool
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: item.url)) { im in
                im
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture(count: 2){
                        withAnimation(.easeInOut(duration: 0.3)) {
                            DataManager.shared.addPic(item: item, context: context)
                            isFavorite.toggle()
                        }
                    }
            } placeholder: {
                ProgressView()
            }
            .shadow(color: .black ,radius: 5)
            .padding(.top)
            
            
            HStack{
                Text(item.date ?? "").font(.system(size: 12))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Image(systemName: DataManager.shared.isContainEl(item) ? "heart.fill" : "heart")
                    .font(.system(size: 20))
                    .foregroundStyle(DataManager.shared.isContainEl(item) ? .red : (colSch == .light ? .black : .white))
                    .onTapGesture {
                        DataManager.shared.addPic(item: item, context: context)
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isFavorite.toggle()
                        }
                    }
                Button(action: {
                    if let hdUrl = item.hdUrl{
                        guard let url = URL(string: hdUrl) else { return }
                        UIApplication.shared.open(url)
                    }else{
                        guard let url = URL(string: item.url) else { return }
                        UIApplication.shared.open(url)
                        
                    }
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 20))
                })
            }
            .padding(.bottom)
            .foregroundStyle(colSch == .light ? .black : .white)
            
            HStack {
                Text(item.title ?? "")
                    .font(.system(.title2))
                Button(action: {
                    self.isShowDetails.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                })
                Spacer()
            }
            .sheet(isPresented: $isShowDetails){
                ScrollView(.vertical) {
                    HStack {
                        Text(item.title ?? "")
                            .font(.system(.title))
                            .padding()
                        Spacer()
                    }
                    Text(item.descr ?? "")
                        .padding(.horizontal)
                }
                .presentationDetents([.height(400), .medium])
            }
            Divider()
            
            Text(item.descr ?? "")
                .lineLimit(4)
                .padding(.top)
            
            Spacer()
        }
        .navigationTitle("Information")
        .padding(.horizontal)
    }
}

