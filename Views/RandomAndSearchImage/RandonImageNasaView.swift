//
//  RandNasaIvageView.swift
//  NasaAppTest
//
//  Created by Никита Попов on 20.12.23.
//

import SwiftUI

struct RandonImageNasaView: View {
    var item: NasaUserItemModel
    @State private var isShowDetailView: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            AsyncImage(url: URL(string: item.url),scale: 0.5) { im in
                im
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: (item.hdUrl != nil ? .black : .red), radius: 5)
            } placeholder: {
                ProgressView()
            }
            .padding(.vertical, 20)
        
        }

        
    }
}
