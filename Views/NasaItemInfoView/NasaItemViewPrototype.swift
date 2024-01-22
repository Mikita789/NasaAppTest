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
            //MARK: - Image
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
            
            //MARK: - date and action
            HStack{
                Text(item.date ?? "").font(.system(size: 12))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
//                Image(systemName: DataManager.shared.isContainEl(item) ? "heart.fill" : "heart")
//                    .font(.system(size: 20))
//                    .foregroundStyle(DataManager.shared.isContainEl(item) ? .red : (colSch == .light ? .black : .white))
//                    .onTapGesture {
//                        DataManager.shared.addPic(item: item, context: context)
//                        withAnimation(.easeInOut(duration: 0.3)) {
//                            isFavorite.toggle()
//                        }
//                    }
//                Button(action: {
//                    if let hdUrl = item.hdUrl{
//                        guard let url = URL(string: hdUrl) else { return }
//                        UIApplication.shared.open(url)
//                    }else{
//                        guard let url = URL(string: item.url) else { return }
//                        UIApplication.shared.open(url)
//                        
//                    }
//                }, label: {
//                    Image(systemName: "square.and.arrow.down")
//                        .font(.system(size: 20))
//                })
            }
            .padding(.bottom)
            .foregroundStyle(colSch == .light ? .black : .white)
            
            GeometryReader{size in
                HStack{
                    Button(action: {
                        DataManager.shared.addPic(item: item, context: context)
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isFavorite.toggle()
                        }
                    }, label: {
                        Image(systemName: DataManager.shared.isContainEl(item) ? "heart.fill" : "heart")
                            .font(.system(size: 25))
                            .foregroundStyle(DataManager.shared.isContainEl(item) ? .red : (colSch == .light ? .black : .white))
                    })
                    .frame(width: size.size.width / 2, height: size.size.height * 0.9)
                    .background(LinearGradient(colors: [
                        Color.blue, Color.gray, Color.blue
                    ]
                                               , startPoint: .topLeading,
                                               endPoint: .bottomTrailing).opacity(0.3))
                    .clipShape(.capsule)
                    
                    Spacer()
                    Button(action: {
                        if let hdUrl = item.hdUrl{
                            guard let url = URL(string: hdUrl) else { return }
                            UIApplication.shared.open(url)
                        }else{
                            guard let url = URL(string: item.url) else { return }
                            UIApplication.shared.open(url)
                            
                        }
                    }, label: {
                        Image(systemName: "arrow.down.circle")
                            .font(.system(size: 25))
                    })
                    .frame(width: size.size.width / 2, height: size.size.height * 0.9)
                    .background(LinearGradient(colors: [
                        Color.blue, Color.gray, Color.blue
                    ]
                                               , startPoint: .topLeading,
                                               endPoint: .bottomTrailing).opacity(0.3))
                    .clipShape(.capsule)

                }
            }.frame(height: 40)
            
            //MARK: - Title
            HStack {
                Text(item.title ?? "")
                    .font(.system(.title2))
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
            
            //MARK: - Description and full information
            HStack (alignment: .lastTextBaseline){
                Text(item.descr ?? "")
                    .lineLimit(4)
                .padding(.top)
                Button(action: {
                    self.isShowDetails.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                })
            }
            
            Spacer()
        }
        .navigationTitle("Information")
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}

