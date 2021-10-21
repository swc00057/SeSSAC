//
//  MapViewController.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    static let identifier = "MapViewController"
    let theatherLocationInfo = TheaterLocationInfo()
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        
        //서울역
        let location = CLLocationCoordinate2D(latitude: 37.55523771230805, longitude: 126.96984146337905)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //핀 만들기
        
        let theaterAnnotation = theatherLocationInfo.mapAnnotations
        for theater in theaterAnnotation {
            let annotation = MKPointAnnotation()
            annotation.title = theater.location
            let location = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
            // Do any additional setup after loading the view.
        }
        
        //맵뷰에에서 어노테이션 삭제
        //let anotations = mapView.annotations
        //mapView.removeAnnotation(annotations)
    }
    
}
extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func checkUserLocationServiceAuthorization(){
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus //IOS 14 이상
            
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // IOS14 미만
        }
        //IOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청 가능(8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        }
        else {
            print("IOS 위치 서비스를 켜주세요")
        }
    }
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도 default가 존재함
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() //필수! 위치 접근 시작! => didUpdateLoctation 이 실행된다
        case .restricted, .denied:
            print("DENIED")
        case .authorizedAlways:
            print("ALWAYS")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("DEFAULT")
        }
        
        if #available(iOS 14.0, *){
            //정확도 체크 : 정확도 감소가 되어 있을경우, 1시간 4번, 미리 알림, 배터리타임.
            let accurancyState = locationManager.accuracyAuthorization
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
            }
        }
        else{
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        if let coordiante = locations.last?.coordinate{
            
            let annotation = MKPointAnnotation()
            annotation.title = "CURRENT LOCATION"
            annotation.coordinate = coordiante
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordiante, span: span)
            mapView.setRegion(region, animated: true)
            
            //10. 중요
            locationManager.stopUpdatingLocation()
        }
        else {
            print("Location CanNot Find")
        }
    }
    
    //사용자가 위치 권한을 허용했다면 iOS 14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServiceAuthorization()
    }
    //사용자가 위치 권한을 허용했다면 iOS 14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServiceAuthorization()
    }
    //사용자 위치 접근에 실패 하였을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        print("사용자 위치 접근에 실패 하였습니다.")
    }
}
