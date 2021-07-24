import Foundation
import Alamofire

class WeatherLoader {
    
    func loaderWeather(lat: Double, lon:Double, completion: @escaping (WeatherAPI) -> Void) {

            let request = AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&lang=ru&exclude=alerts&units=metric&appid=9061835a58ee45825f994cc2fd8f2820").responseJSON { data in
                var weather:WeatherAPI?
                if let result = data.data {
                    do {
                    let decoder = JSONDecoder()
                        let jsonResults = try decoder.decode(WeatherAPI.self, from: result)
                        weather=jsonResults
                        } catch DecodingError.dataCorrupted(let context) {
                            let dataString = String.init(data: result, encoding: .utf8) ?? "Nil String"
                            let error = CustomDecodeError(description: context.debugDescription + " " + dataString)
                            print(error)
                        } catch DecodingError.keyNotFound(let key, let context) {
                            let error = CustomDecodeError(description: context.debugDescription + key.description)
                            print(error)
                        } catch DecodingError.typeMismatch(_, let context) {
                            let error = CustomDecodeError(description: context.debugDescription + (context.codingPath.last?.description ?? ""))
                            print(error)
                        } catch DecodingError.valueNotFound(_, let context) {
                            let error = CustomDecodeError(description: context.debugDescription + (context.codingPath.last?.description ?? ""))
                            print(error)
                        } catch let error {
                            let customError = CustomDecodeError(description: error.localizedDescription)
                            print(customError)
                        }
                }
                DispatchQueue.main.async {
                    completion(weather!)
                }
            }
        }
}

