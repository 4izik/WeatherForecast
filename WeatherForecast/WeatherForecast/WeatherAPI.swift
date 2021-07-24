import Foundation

class WeatherAPI:Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset:Int
    let current: Current
    let minutely: [Minutely]
    let hourly: [Hourly]
    let daily: [Daily]
    let alerts: Alerts?

}
class Current:Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Double
    let wind_speed: Double
    let wind_gust: Double?
    let wind_deg: Double
    let weather: [Weather]
    //let rain: Double?
    let snow: Double?
}
class Minutely:Codable{
    let dt: Int
    let precipitation: Double
}
class Hourly:Codable{
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Double
    let wind_speed: Double
    let wind_gust: Double?
    let wind_deg: Double
    let pop: Double
    let weather: [Weather]
    //let rain: Double?
    let snow: Double?
}
class Daily:Codable{
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset:Int
    let moon_phase: Double
    let temp: Temp
    let feels_like: Feels_like
    let pressure: Int
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let wind_speed: Double
    let wind_gust: Double?
    let wind_deg: Double
    let pop: Double
    let weather: [Weather]
    //let rain: Double?
    let snow: Double?
}
class Alerts:Codable {
    let sender_name: String
    let event: String
    let start:Int
    let end: Int
    let description: String
}
class Weather: Codable {
    let id:Int
    let main: String
    let description: String
    let icon: String
}
class Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}
class Feels_like:Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
struct CustomDecodeError: Codable {

    let detail: String?

    

    init(description: String?) {

        detail = description

    }

}
