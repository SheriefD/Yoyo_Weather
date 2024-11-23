//
//  ShimmerModifier.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ZStack {
                        Color.gray.opacity(1)
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.4), Color.clear]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                        .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false), value: isAnimating)
                    }
                }.clipped()
            )
            .onAppear {
                isAnimating = true
            }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }
}
