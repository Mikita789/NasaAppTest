//
//  DetailsView.swift
//  NasaAppTest
//
//  Created by Никита Попов on 15.12.23.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject private var model = DetailsViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var context
    
    var currentItem: NasaUserItemModel
    var colorBack = Color.gray.opacity(0.2)
    
    @State private var isFavorite: Bool = false
    @State private var isShowDetails = false
    @State private var isDismiss = false
    
    var body: some View {
        
        NavigationView {
            NasaItemInfo(item: currentItem, context: context, isFavorite: $model.isFavorite, isShowDetails: $isShowDetails)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            //dismiss
                            dismiss()
                        } label: {
                            
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                                .font(.system(size: 20))
                                .symbolRenderingMode(.hierarchical)
                        }
                        
                    }
                }
                .onAppear{
                    print("load view/n\(currentItem.title)")
                }
        }
        
    }
    
}

#Preview {
    DetailsView(currentItem: nasaItemConstant)
}
