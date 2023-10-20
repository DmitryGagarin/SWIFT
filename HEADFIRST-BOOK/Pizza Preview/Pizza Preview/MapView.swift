//
//  MapView.swift
//  Pizza Preview
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region: MKCoordinateRegion =
    MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.65663, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView()
}
