//
//  SwiftUIView.swift
//  MyMap
//
//  Created by 楢府佑 on 2023/07/03.
//

import SwiftUI
import MapKit

enum MapType {
    case standard
    case satelite
    case hybrid
}

struct MapView: UIViewRepresentable {
    
    // 検索ワード
    let searchKey: String
    // マップ種類
    let mapType: MapType
    
    func makeUIView(context: Context) -> MKMapView {
        // 地図を生成
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("検索キーワード:\(searchKey)")
        
        switch mapType {
        case .standard:
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .flat)
        case .satelite:
            uiView.preferredConfiguration = MKImageryMapConfiguration()
        case .hybrid:
            uiView.preferredConfiguration = MKHybridMapConfiguration()
        }
        
        let geocoder = CLGeocoder()
        
        // 入力された文字列から緯度軽度を取得
        geocoder.geocodeAddressString(
            searchKey,
            completionHandler: { (placemarks, error) in
                if let placemarks,
                   let firstPlacemark = placemarks.first,
                    let location = firstPlacemark.location {
                    
                    let targetCordinate = location.coordinate
                    print("緯度軽度:\(targetCordinate)")
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = targetCordinate
                    pin.title = searchKey
                    uiView.addAnnotation(pin)
                    
                    uiView.region = MKCoordinateRegion(center: targetCordinate,
                                                       latitudinalMeters: 500,
                                                       longitudinalMeters: 500)
                }
            })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "羽田空港", mapType: .standard)
    }
}
