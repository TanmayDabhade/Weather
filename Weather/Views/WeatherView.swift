import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        GeometryReader{geometry in
            ZStack {
                // Background image
                switch weather.weather[0].main {
                case "Clear":
                    Image("clear")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Rain":
                    Image("rain")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Thunderstorm":
                    Image("thunder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Drizzle":
                    Image("drizzle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Snow":
                    Image("snow")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Mist", "Fog":
                    Image("fog")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Smoke":
                    Image("haze")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Haze":
                    Image("haze")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Dust", "Sand", "Ash":
                    Image("haze")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Squall":
                    Image("snow")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Tornado":
                    Image("tornado")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                case "Clouds":
                    Image("cloud")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                default:
                    Image("questionmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                }
                VStack {
                    // Top section with rounded rectangle
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(weather.name)
                                .font(.title)
                                .bold()
                            Text("Today \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        
                        
                        HStack {
                            VStack(alignment: .leading) {
                                switch weather.weather[0].main {
                                case "Clear":
                                    Image(systemName: "sun.max.fill")
                                        .font(.system(size: 40))
                                case "Rain":
                                    Image(systemName: "cloud.rain.fill")
                                        .font(.system(size: 40))
                                case "Thunderstorm":
                                    Image(systemName: "cloud.bolt.rain.fill")
                                        .font(.system(size: 40))
                                case "Drizzle":
                                    Image(systemName: "cloud.drizzle.fill")
                                        .font(.system(size: 40))
                                case "Snow":
                                    Image(systemName: "cloud.snow.fill")
                                        .font(.system(size: 40))
                                case "Mist", "Fog":
                                    Image(systemName: "cloud.fog.fill")
                                        .font(.system(size: 40))
                                case "Smoke":
                                    Image(systemName: "smoke.fill")
                                        .font(.system(size: 40))
                                case "Haze":
                                    Image(systemName: "sun.haze.fill")
                                        .font(.system(size: 40))
                                case "Dust", "Sand", "Ash":
                                    Image(systemName: "sun.dust.fill")
                                        .font(.system(size: 40))
                                case "Squall":
                                    Image(systemName: "wind.snow")
                                        .font(.system(size: 40))
                                case "Tornado":
                                    Image(systemName: "tornado")
                                        .font(.system(size: 40))
                                case "Clouds":
                                    Image(systemName: "cloud.fill")
                                        .font(.system(size: 40))
                                default:
                                    Image(systemName: "questionmark")
                                        .font(.system(size: 40))
                                }
                                
                                Text(weather.weather[0].main)
                                    .font(.system(size: 30))
                            }
                            .frame(width: 100, alignment: .leading)
                            .padding(.leading, 20)
                            Spacer()
                            
                            Text(weather.main.feelslike.roundDouble() + "ºC")
                                .font(.system(size: 80))
                                .fontWeight(.bold)
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .padding()
                    .colorInvert()
                    
                    .padding(.bottom, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20, corners: .allCorners)
                    
                    
                    VStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Current Weather")
                                .bold()
                                .padding(.bottom, 20)
                            HStack {
                                
                                VStack(alignment: .leading){
                                    
                                    WeatherRow(logo: "thermometer", name: "Min Temperature", value: "\(weather.main.temp_min.roundDouble())ºC")
                                    
                                    WeatherRow(logo: "wind", name: "Wind Speed", value: "\(weather.wind.speed.roundDouble())m/s")
                                    
                                }
                                Spacer()
                                VStack(alignment: .leading){
                                    WeatherRow(logo: "thermometer", name: "Max Temperature", value: "\(weather.main.temp_max.roundDouble())ºC")
                                    WeatherRow(logo: "humidity", name: "Humidity ", value: "\(weather.main.humidity.roundDouble())%")
                                    
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.345))
                        .background(Color.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                    }
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .preferredColorScheme(.dark)
            }
        }
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
