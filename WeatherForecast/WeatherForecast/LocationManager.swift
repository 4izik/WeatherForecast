import Foundation
import CoreLocation
class LocationManager: NSObject
{
    static let shared=LocationManager()
    
    typealias AccessRequestBlock = (Bool)->()
    typealias LocationRequestBlock = (CLLocationCoordinate2D?)->()
    
    var isEnabled : Bool {return CLLocationManager.isEnabled}
    var canRequestAccess : Bool {return CLLocationManager.canRequestService}
    
    private var accessRequestCompletion:AccessRequestBlock?
    private var locationRequestCompletion:LocationRequestBlock?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyThreeKilometers
    }
    
    func requestAccess(completion: AccessRequestBlock?){
        accessRequestCompletion = completion
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation(completion: LocationRequestBlock?) {
        locationRequestCompletion=completion
        locationManager.startUpdatingLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        accessRequestCompletion?(isEnabled)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else {return}
        locationRequestCompletion?(location)
        locationRequestCompletion=nil
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.startUpdatingLocation()
        locationRequestCompletion?(nil)
        locationRequestCompletion=nil
    }
}
extension CLLocationManager {
    static var canRequestService:Bool {
        return authorizationStatus() != .restricted && authorizationStatus() != .denied
    }
    static var isEnabled:Bool {
        return authorizationStatus() == .authorizedAlways || authorizationStatus() == .authorizedWhenInUse
    }
}

