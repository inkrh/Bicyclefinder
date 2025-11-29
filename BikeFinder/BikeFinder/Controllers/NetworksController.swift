import Foundation
import SwiftyJSON

//TODO: error handling
//TODO: sorting
//TODO: filtering by country/city

class NetworksController {
    func makeRequest() async -> NetworksModel {
        var networkData: NetworksModel
        let url = URL(string: Constants.networkURL)!
        let request = URLRequest(url: url)
        let task = Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let json = JSON(data)
                return await decodeReseult(json)
                
            }
            
        }
        let result = await task.result
        do {
            networkData = try result.get()
            return networkData
        } catch LoadError.fetchFailed {
            print("Unable to fetch.")
        } catch LoadError.decodeFailed {
            print("Unable to decode.")
        } catch {
            print("Unknown error. Give up all hope.")
        }
        return dummyNetworks
    }
    
    func decodeReseult(_ result: JSON) async -> NetworksModel {
        let JSONDecoder = JSONDecoder()
        do {
            let decodedData = try JSONDecoder.decode(NetworksModel.self, from: Data(try result.rawData()))
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
        }
        //dummyNetworks is useful for previews, better to return nil and handle the error, but this is just a demo
        return dummyNetworks
    }
}

enum LoadError: Error {
    case fetchFailed, decodeFailed
}
