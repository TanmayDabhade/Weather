// filepath: /Users/tanmay/Coding/iOS/Weather/Weather/Components/GlassUI.swift
//
//  GlassUI.swift
//  Weather
//
//  Created by GitHub Copilot on 10/7/25.
//
import SwiftUI

// MARK: - Glass Card Modifier
extension View {
    func glassCard(cornerRadius: CGFloat = 20) -> some View {
        self
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(LinearGradient(
                        colors: [Color.white.opacity(0.35), Color.white.opacity(0.05)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    ), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
    }
}

// MARK: - Liquid Background
struct LiquidBackground: View {
    var weatherKey: String
    var opacity: Double = 0.55
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var palette: [Color] {
        switch weatherKey {
        case "Clear":
            return [Color.yellow, Color.orange, Color.blue]
        case "Rain":
            return [Color.blue, Color.indigo, Color.purple]
        case "Thunderstorm":
            return [Color.purple, Color.blue, Color.cyan]
        case "Drizzle":
            return [Color.cyan, Color.mint, Color.blue]
        case "Snow":
            return [Color.cyan, Color.mint, Color.white]
        case "Mist", "Fog", "Smoke", "Haze", "Dust", "Sand", "Ash":
            return [Color.gray, Color.mint, Color.cyan]
        case "Squall":
            return [Color.blue, Color.cyan, Color.mint]
        case "Tornado":
            return [Color.indigo, Color.purple, Color.gray]
        case "Clouds":
            return [Color.blue, Color.cyan, Color.indigo]
        default:
            return [Color.purple, Color.blue, Color.mint]
        }
    }

    var body: some View {
        Group {
            if reduceMotion {
                // Static, low-motion variant
                Canvas { ctx, size in
                    let count = 3
                    let maxR = max(size.width, size.height)
                    for i in 0..<count {
                        let angle = Double(i) * .pi * 0.66
                        let x = size.width * 0.5 + CGFloat(cos(angle)) * size.width * (0.22 + 0.06 * CGFloat(i))
                        let y = size.height * 0.5 + CGFloat(sin(angle)) * size.height * (0.20 + 0.08 * CGFloat(i))
                        let r = maxR * (0.24 + 0.04 * CGFloat(i))
                        let color = palette[i % palette.count]
                        let gradient = Gradient(colors: [color.opacity(0.7), color.opacity(0.18), .clear])
                        let shader = GraphicsContext.Shading.radialGradient(gradient, center: CGPoint(x: x, y: y), startRadius: 0, endRadius: r)
                        let circle = Path(ellipseIn: CGRect(x: x - r, y: y - r, width: r*2, height: r*2))
                        ctx.fill(circle, with: shader)
                    }
                }
                .blur(radius: 40)
                .opacity(opacity * 0.8)
            } else {
                TimelineView(.animation) { timeline in
                    let t = timeline.date.timeIntervalSinceReferenceDate
                    Canvas { ctx, size in
                        // Render a set of animated radial gradients (metaballs-like glow)
                        let count = 4
                        let maxR = max(size.width, size.height)
                        for i in 0..<count {
                            let speed = 0.18 + Double(i) * 0.06
                            let phase = t * speed + Double(i) * .pi/3
                            let x = size.width  * 0.5 + CGFloat(cos(phase)) * size.width  * (0.25 + 0.1 * CGFloat(i))
                            let y = size.height * 0.5 + CGFloat(sin(phase * 0.9)) * size.height * (0.22 + 0.1 * CGFloat(i))
                            let r = maxR * (0.22 + 0.06 * CGFloat(i))

                            // Choose color cycling through the palette
                            let color = palette[i % palette.count]
                            let gradient = Gradient(colors: [color.opacity(0.85), color.opacity(0.2), .clear])
                            let shader = GraphicsContext.Shading.radialGradient(
                                gradient,
                                center: CGPoint(x: x, y: y),
                                startRadius: 0, endRadius: r
                            )
                            let circle = Path(ellipseIn: CGRect(x: x - r, y: y - r, width: r*2, height: r*2))
                            ctx.fill(circle, with: shader)
                        }
                    }
                }
                .blur(radius: 50)
                .opacity(opacity)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}

struct GlassUI_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.black, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            LiquidBackground(weatherKey: "Clear")
            VStack(spacing: 20) {
                Text("Glass Card")
                    .font(.title2).bold()
                    .padding(24)
                    .glassCard(cornerRadius: 24)
                    .padding()
            }
        }
        .preferredColorScheme(.dark)
    }
}
