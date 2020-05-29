//
//  Map.swift
//  WorldTrotterSUI
//
//  Created by Jacob on 23.03.20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI
import MapKit


struct Map: UIViewRepresentable {
    @Binding var mapType: Int
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    @State var showMapAlert = false
        
    var annotations: [MKPointAnnotation]
    
    typealias UIViewType = MKMapView
    
    func makeUIView(context: UIViewRepresentableContext<Map>) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        mapView.addAnnotation(MKPointAnnotation.stuttgart);
        
        return mapView
    }
    
    
    func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<Map>)
    {
        switch mapType {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            print("unknown mapType: \(mapType)")
        }
        
        // Annotation challenge
        if (annotations.count != mapView.annotations.count) {
            print("update annotations")
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(annotations)
            mapView.addAnnotation(MKPointAnnotation.stuttgart);
        }
    }
    
    // Annotation challenge
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: Map

        init(_ parent: Map) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map(mapType: .constant(0),
            centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
            annotations: [MKPointAnnotation.example])
    }
}


extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
    
    static var stuttgart: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Stuttgart"
        annotation.subtitle = "City in Germany"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 48.774037, longitude: 9.174388)
        return annotation
    }
}
