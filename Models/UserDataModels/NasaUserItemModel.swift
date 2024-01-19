//
//  NasaUserItemModel.swift
//  NasaAppTest
//
//  Created by Никита Попов on 17.01.24.
//

import Foundation

struct NasaUserItemModel: Identifiable{
    let id: UUID
    let hdUrl: String?
    let url: String
    let date: String?
    let title: String?
    let descr: String?
    
    init(searchItem: Item){
        self.id = UUID()
        self.url = searchItem.links.first?.href ?? "https://www.nasa.gov"
        self.date = searchItem.data.first?.dateCreated
        self.descr = searchItem.data.first?.description
        self.hdUrl = nil
        self.title = nil
    }
    
    init(nasaPic: NetwDataNasaPic){
        self.id = UUID()
        self.hdUrl = nasaPic.hdurl
        self.url = nasaPic.url
        self.date = nasaPic.date
        self.title = nasaPic.title
        self.descr = nasaPic.explanation
    }
    
    
    init(dataItem: FavoriteObject){
        self.id = dataItem.id ?? UUID()
        self.hdUrl = nil
        self.url = dataItem.urlString ?? "-"
        self.date = nil
        self.title = dataItem.title ?? "-"
        self.descr = dataItem.descr ?? ""
    }
    
    
}
