//
//  ContentView.swift
//  MyLocation
//
//  Created by Ronaldo Akira Fujigaki Kinoshita on 28/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var mapViewModel = MapViewModel()
    
    
    
    var body: some View{
        
        Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true).ignoresSafeArea()
            .accentColor(Color(.black))
            .onAppear{
                mapViewModel.checkIfLocationServiceIsEnabled()
            }
    }
}




#Preview {
    MapView()
}
