//
//  MapView.swift
//  WorldTrotterSUI
//
//  Created by Jacob on 23.03.20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var selectedMapType = 0
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    var body: some View {
        ZStack {
            Map(mapType: $selectedMapType, centerCoordinate: $centerCoordinate, annotations: locations)
                .overlay(
                    Picker("", selection: $selectedMapType) {
                        Text("Standard").tag(0)
                        Text("Hybrid").tag(1)
                        Text("Satelite").tag(2)
                    }
                .pickerStyle(SegmentedPickerStyle())
                .padding(),
                alignment: .top)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        print("Add annotation")
                        let newLocation = MKPointAnnotation()
                        print(self.centerCoordinate)
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
