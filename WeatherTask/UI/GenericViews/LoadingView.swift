//
//  LoadingView.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context:Context) -> UIActivityIndicatorView {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        return activity
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
