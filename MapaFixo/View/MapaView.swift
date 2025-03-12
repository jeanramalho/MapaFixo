//
//  MapaView.swift
//  MapaFixo
//
//  Created by Jean Ramalho on 12/03/25.
//
import Foundation
import UIKit
import MapKit

class MapaView: UIView {
    
    lazy var mapa: MKMapView = {
        let mapa = MKMapView()
        mapa.translatesAutoresizingMaskIntoConstraints = false
        return mapa
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
       
        backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        addSubview(mapa)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            mapa.topAnchor.constraint(equalTo: topAnchor),
            mapa.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapa.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapa.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
