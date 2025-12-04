import Foundation
import SwiftyJSON

//TODO: error handling

class NetworksController {
    func makeRequest() async -> NetworksModel {
        var networkData: NetworksModel
        let url = URL(string: Constants.networkURL)!
        let request = URLRequest(url: url)
        let task = Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let json = JSON(data)
                print(json)
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
        let jsonDecoder = JSONDecoder()
        do {
            // decode and order by country then city
            let decodedData = try jsonDecoder.decode(NetworksModel.self, from: Data(try result.rawData()))
            let sortedNetworks = decodedData.networks.sorted(by: { ($0.location.country, $0.location.city) < ($1.location.country, $1.location.city) })
            return NetworksModel(networks: sortedNetworks)
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
