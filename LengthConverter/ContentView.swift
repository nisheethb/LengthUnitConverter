//
//  ContentView.swift
//  LengthConverter
//
//  Created by Nisheeth Bandaru on 7/8/20.
//  Copyright © 2020 Nisheeth Bandaru. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputLength = ""
    @State private var inputUnit = 1
    @State private var outputUnit = 4
    
    let unitTypes = ["m", "km", "ft", "yd", "mi"]
        
    func lengthToMeters(initialUnit unitType: String, length: Double)
        -> Double {
        switch unitType {
        case "m":
            return length
        case "km":
            return length * 1000
        case "ft":
            return length / 3.2808399
        case "yd":
            return length / 1.0936133
        case "mi":
            return length * 1609.344
        default:
            return length
        }
    }
    
    func metersToLength(targetUnit unitType: String, length: Double)
        -> Double {
        switch unitType {
        case "m":
            return length
        case "km":
            return length / 1000
        case "ft":
            return length * 3.2808399
        case "yd":
            return length * 1.0936133
        case "mi":
            return length / 1609.344
        default:
            return length
        }
    }
    
    var outputLength : String {
        let length = Double(inputLength) ?? 0
        let lengthInMeters = lengthToMeters(initialUnit: unitTypes[inputUnit], length: length)
        let finalLength = metersToLength(targetUnit: unitTypes[outputUnit], length: lengthInMeters)
        if finalLength.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", finalLength)
        } else {
            return String(format: "%.3f", finalLength)
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Length in \(unitTypes[inputUnit])",
                        text: $inputLength)
                        .keyboardType(.decimalPad)
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(0 ..< unitTypes.count) {
                            Text("\(self.unitTypes[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section() {
                    Text("\(outputLength) \(unitTypes[outputUnit])")
                    
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(0 ..< unitTypes.count) {
                            Text("\(self.unitTypes[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }.navigationBarTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
