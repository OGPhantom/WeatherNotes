//
//  AppBackground.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI

struct AppBackground: View {
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        ZStack {
            (scheme == .dark
             ? Color(red: 0.08, green: 0.09, blue: 0.11)
             : Color(red: 0.96, green: 0.97, blue: 0.98))

            RadialGradient(
                colors: [
                    .accent.opacity(0.45),
                    .clear
                ],
                center: .top,
                startRadius: 0,
                endRadius: 350
            )
            .blur(radius: 60)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AppBackground()
        .environment(\.colorScheme, .dark)
}
