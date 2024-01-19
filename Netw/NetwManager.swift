//
//  NetwManager.swift
//  NasaAppTest
//
//  Created by Никита Попов on 12.12.23.
//

import Foundation


struct NetwManager{
    
    private var decoder = JSONDecoder()
    private var urlSession = URLSession.shared
    
    
    private func parseJS(data: Data) throws -> NetwDataNasaPic{
        do{
            let result = try self.decoder.decode(NetwDataNasaPic.self, from: data)
            return result
        }catch{
            print("DEBUG: - Parse error")
            throw NetwUserErrors.parseError
        }
    }
    
    func fetchOnePic(date: String) async throws -> NasaUserItemModel{
        let baseURL = ConstantsNetw.getURLString()
        guard let finalURL = URL(string: baseURL + "&date=\(date)") else {
            print("DEBUG: - Bad URL")
            throw NetwUserErrors.badURL
        }
        
        let (data, _) = try await urlSession.data(from: finalURL)
        //let result = NasaPicUserModel(netwItem: try self.parseJS(data: data))
        let result = NasaUserItemModel(nasaPic: try self.parseJS(data: data))
        return result
    }
    
    private func parseSearchResult(data: Data) throws -> NasaSearchDataItem{
        do{
            let res = try self.decoder.decode(NasaSearchDataItem.self, from: data)
            return res
        }catch{
            print("DEBUG : - Parse error")
            throw NetwUserErrors.parseError
        }
    }
    
    func getSearchResult(text: String) async throws -> [NasaUserItemModel]{
        var userData: [NasaUserItemModel] = []
        let resUrl = ConstantsNetw.getURLStringSearch(textQ: text)
        guard let resUrl = URL(string: resUrl) else {
            print("DEBUG: - Bad URL (\(resUrl)")
            throw NetwUserErrors.badURL
        }
        
        let (data, _) = try await urlSession.data(from: resUrl)
        
        let res = try self.parseSearchResult(data: data)
        res.collection.items.map{
            userData.append(NasaUserItemModel(searchItem: $0))
        }
        
        return userData
    }
    
    
    
}
