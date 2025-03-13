//
//  ViewController.swift
//  MapaFixo
//
//  Created by Jean Ramalho on 12/03/25.
//
import Foundation
import UIKit
import MapKit

//instala o framework externo coreLocation para acompanhar usuário de forma mais rápida do que nativamente

class MapaFixo: UIViewController {

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
        
        
        

//        
//        let anotacao = MKPointAnnotation()
//        anotacao.coordinate = localizacao
//        anotacao.title = "Minha Casa"
//        anotacao.subtitle = "Essa é a marcação da minha casa na Rua Silvia de Faria Marcondes, 445, Parque Fernanda"
//        
//        mapView.addAnnotation(anotacao)
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

extension MapaFixo: CLLocationManagerDelegate, MKMapViewDelegate {
    
    private func setupLocation(){
        
        locationManager.delegate = self
        //configura precisao
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Pedi autorização ao usuário
        locationManager.requestWhenInUseAuthorization()
        //acompanha movimentação do usuário
        locationManager.startUpdatingLocation()
        
    }
    
    // Método para acompanhar a localização do usuário
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Pega o mapa da contentView
        let mapView = contentView.mapa
        // Mostra a localização do usuário
        mapView.showsUserLocation = true
        
        // pega a ultima localizacao do usuário no array de localização do locations
        guard let userLocation = locations.last else {return}
        
        // monta exibição do mapa
        //pega latitute e longitude atual do usuario
        let latitute: CLLocationDegrees = userLocation.coordinate.latitude
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        //configura a latitude e longitude Delta, que é a distancia da exibição do ponto configurado
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        
        // Cria uma variavel de localização utilizando a latitude e logintude capturadas do array de localização atual
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitute, longitude)
        // Cria uma variável de coordenadas Delpa para distancia da exibição
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        // Cria uma variável para passar a localização e a area de visualização configurados
        let region: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVisualizacao)
        
        // Seta a região a ser exibida no mapa
        mapView.setRegion(region, animated: true)
        
    }
}

