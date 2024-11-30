//
//  MApViewModel.swift
//  MyLocation
//
//  Created by Ronaldo Akira Fujigaki Kinoshita on 30/11/24.
//

import Foundation
import CoreLocation
import MapKit


enum MapDetails{
    static let startingLocation = CLLocationCoordinate2D(latitude: -23.222081789612854,
                                                         longitude: -45.88630378268977)
    static let span = MKCoordinateSpan(latitudeDelta: 0.1,
                                       longitudeDelta: 0.1)
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation ,
                                               span: MapDetails.span)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else{
            print("location is off and need to be turned on")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus{
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("show alert that location is restricted")
            case .denied:
                print("show alert that location is denied. Go to settings and allow location")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                            span: MapDetails.span)
            @unknown default:
                break
        }
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        checkLocationAuthorization()
    }
    
}
