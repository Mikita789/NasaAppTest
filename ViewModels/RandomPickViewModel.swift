//
//  RandomPickViewModel.swift
//  NasaAppTest
//
//  Created by Никита Попов on 14.12.23.
//

import Foundation

@MainActor
class RandomPickViewModel: ObservableObject{
    @Published var allPic: [NasaUserItemModel] = []

    let netwManager = NetwManager()
    
    init() {
        Task{
            try await getRandPic()
        }
    }
    
    private func getDateRange() -> ClosedRange<Date>{
        let calendar = Calendar.current
        let yest = calendar.date(byAdding: .day, value: -1, to: Date())
        let startDay = DateComponents(year: 2015, month: 1, day: 1)

        return (calendar.date(from: startDay) ?? Date.now)...(yest ?? Date.now)
    }
    
    private func fetchDateStrArr(count: Int = 20)->[String]{
        var resArr:[String] = []
        let range = self.getDateRange()
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let startDate = range.lowerBound
        let endDate = range.upperBound
        for _ in 0..<count{
            let span = TimeInterval.random(in: startDate.timeIntervalSinceNow...endDate.timeIntervalSinceNow)
            let res = Date(timeIntervalSinceNow: span)
            resArr.append(df.string(from: res))
        }
        
        return resArr
    }
    
    func getRandPic(count: Int = 20) async throws {
        self.allPic = []
        let randDate = self.fetchDateStrArr(count: count)
        for date in randDate{
            var onePic:NasaUserItemModel?
            onePic = try await netwManager.fetchOnePic(date: date)
            
            if let onePic = onePic {
                self.allPic.append(onePic)
            }
        }
    }
    
    func getSearchItems(text: String) async throws{
        self.allPic = try await netwManager.getSearchResult(text: text)
    }
}
