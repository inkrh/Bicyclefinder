import Foundation
import SwiftyJSON

class CityController {
    func makeRequest(cityUrl: String) async -> CitiesModel {
        var cityData: CitiesModel
        let url = URL(string: Constants.BASEURL+cityUrl)!
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
            cityData = try result.get()
            return cityData
        } catch LoadError.fetchFailed {
            print("Unable to fetch.")
        } catch LoadError.decodeFailed {
            print("Unable to decode.")
        } catch {
            print("Unknown error. Give up all hope.")
        }
        return dummyCities
    }
    
    func decodeReseult(_ result: JSON) async -> CitiesModel {
        let JSONDecoder = JSONDecoder()
        do {
            let decodedData = try JSONDecoder.decode(CitiesModel.self, from: Data(try result.rawData()))
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
        }
        return dummyCities
    }
}
