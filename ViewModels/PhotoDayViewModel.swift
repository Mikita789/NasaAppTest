//
//  PhotoDayViewModel.swift
//  NasaAppTest
//
//  Created by Никита Попов on 13.12.23.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class PhotoDayViewModel:ObservableObject{
    @Published var currentItem: NasaUserItemModel?{
        didSet{

            
        }
    }
    @Published var isLoaded = false
    @Published var isFavorite = false
    
    
    private var netwModel = NetwManager()

    
    func getCurrentDaterange()-> ClosedRange<Date>{
        let calend = Calendar.current
        let endDate = Date.now
        let startDate = DateComponents(year: 2017, month: 1, day: 1)
        
        return (calend.date(from: startDate)!...endDate)
    }
    
    func fetchPic(date: Date) async throws {
        let strDate = self.calculateStringDate(date: date)
        Task{
            self.isLoaded = false
            self.currentItem = try await netwModel.fetchOnePic(date: strDate)
            self.isLoaded = true

        }
    }
    
    private func calculateStringDate(date: Date) -> String  {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        
        return df.string(from: date)
    }
    
    private func checkPicture(_ collection: FetchedResults<FavoriteObject>)->Bool{
        for im in collection{
            if im.urlString ?? "" == self.currentItem?.url ?? ""{
                return true
            }
        }
        return false
    }
}
