//
//  ContentView.swift
//  How-To-Change-Your-App-Icon
//
//  Created by Thomas Kellough on 4/17/21.
//

import SwiftUI

struct ContentView: View {
    @State private var appIcons = ["redBlack"]
    @State private var selectedIcon = "redBlack"
    
    var body: some View {
        VStack {
            Picker("Choose your app icon", selection: $selectedIcon) {
                ForEach(appIcons, id: \.self) {
                    Text($0)
                }
            }.onReceive([self.selectedIcon].publisher.first()) { (value) in
                UIApplication.shared.setAlternateIconName(selectedIcon) { error in
                    if let error = error {
                        print("Error setting icon! \(error.localizedDescription)")
                    } else {
                        print("Successfully set icon")
                    }
                }
            }
        }.onAppear(perform: {
            appIcons = Bundle.appIcons
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Bundle {
    static var appIcons: [String] {
        var availableIcons = [String]()
        
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Could not get dictionary!")
        }
        
        if let icons = dictionary["CFBundleIcons"] as? [String: Any] {
            if let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
                for (key, _) in alternateIcons {
                    availableIcons.append(key)
                }
            }
        }
        
        return availableIcons
    }
}

//extension Bundle {
//    static var appIcons: [String] {
//        var availableIcons = [String]()
//
//        guard let dictionary = Bundle.main.infoDictionary else { return availableIcons }
//        if let icons = dictionary["CFBundleIcons"] as? [String: Any] {
//            if let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
//                for (key, _) in alternateIcons {
//                    availableIcons.append(key)
//                }
//            }
//        }
//
//        return availableIcons
//    }
//}
