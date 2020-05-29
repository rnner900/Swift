//
//  ConversionView.swift
//  WorldTrotterSUI
//
//  Created by Jacob on 23.03.20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI

struct ConversionView: View {
    @State var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet {
            updateCelsiusValue()
        }
    }
    private var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    @State private var fahrenheitValueText: String = ""
    @State private var validFahrenheitValueText: String = ""
    @State private var celsiusValueText: String = "???"
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func updateCelsiusValue() {
        if let celsiusValue = celsiusValue {
            celsiusValueText = numberFormatter.string(from: NSNumber(value: celsiusValue.value)) ?? "???"
        } else {
            celsiusValueText = "???"
        }
    }

    func validate() -> Binding<String> {
        return Binding<String> (
            get: {
                return self.fahrenheitValueText
            }
        ){
            self.fahrenheitValueText = $0
            if let value = Double($0) {
                self.fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
                self.validFahrenheitValueText = self.fahrenheitValueText
            } else {
                if $0 != "" {
                    self.fahrenheitValueText = self.validFahrenheitValueText
                } else {
                    self.fahrenheitValue = nil
                    self.validFahrenheitValueText = $0
                }
            }
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        // Color(red: 245/255, green: 244/255, blue: 241/255)
        Color(hex: 0xf5f4f13)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.endEditing()
        }
            .overlay(
                VStack {
                    TextField("value", text: validate())
                        .font(.system(size: 70))
                        .padding(.all)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: 0xe15829))
                        .keyboardType(.decimalPad)
                    Text("degrees Fahrenheit")
                        .font(.system(size: 35))
                        .foregroundColor(Color(hex: 0xe15829))
                    Text("is really")
                        .font(.system(size: 35))
                    Text(celsiusValueText)
                        .font(.system(size: 70))
                        .foregroundColor(Color(hex: 0xe15829))
                    Text("degrees Celsius")
                        .font(.system(size: 35))
                        .foregroundColor(Color(hex: 0xe15829))
                }
        )
    }
}

struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView()
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
