//
//  ContentView.swift
//  Practice
//
//  Created by iYezan on 02/05/2021.
//

import SwiftUI 

struct ContentView: View {
    @ObservedObject var fetcher = NetworkManager()
    @ObservedObject var weatherVM = WeatherVM()
    
    init() {
        self.weatherVM = WeatherVM()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(alignment: .center) {
                    
                    Form {
                        ForEach(fetcher.weatherData) { wthr in
                            HStack {
                                Text(wthr.name)
                                
                                Spacer()
                                
                                Text("\(wthr.main.temp!-273.15, specifier: "%.1f")")
                                
                                
                            }
                            
                        }
                        
                    }
                    VStack(alignment: .center) {
                        TextField("Enter city name", text: self.$weatherVM.cityName)  {
                            self.weatherVM.search()
                            
                        }.font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .fixedSize()
                        
                        Text(self.weatherVM.temprature)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .offset(y: 100)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.green)
                    .edgesIgnoringSafeArea(.all)
                    
                }
            }
            .navigationTitle("Weather app")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
