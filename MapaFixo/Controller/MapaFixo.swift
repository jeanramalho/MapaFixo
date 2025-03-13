//
//  ViewController.swift
//  MapaFixo
//
//  Created by Jean Ramalho on 12/03/25.
//
import Foundation
import UIKit
import MapKit

class MapaFixo: UIViewController, MKMapViewDelegate {
    
    let contentView: MapaView = MapaView()
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        setupLocation()
        setupContentView()
        setHierarchy()
        setConstraints()
    }
    
    private func setupContentView(){
        let mapView = contentView.mapa
        
        let latitute: CLLocationDegrees = -23.670803
        let longitude: CLLocationDegrees = -46.7885849
        
        let latDelta: CLLocationDegrees = 0.001
        let longDelta: CLLocationDegrees = 0.001
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitute, longitude)
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVisualizacao)
        
        mapView.setRegion(region, animated: true)
        
        let anotacao = MKPointAnnotation()
        anotacao.coordinate = localizacao
        anotacao.title = "Minha Casa"
        anotacao.subtitle = "Essa é a marcação da minha casa na Rua Silvia de Faria Marcondes, 445, Parque Fernanda"
        
        mapView.addAnnotation(anotacao)
    }
    
    private func setHierarchy(){
        
        view.addSubview(contentView)
    }
    
    private func setConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }


}

extension MapaFixo: CLLocationManagerDelegate {
    
    private func setupLocation(){
        
        locationManager.delegate = self
        //configura precisao
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

