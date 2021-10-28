//
//  Ghost_TrackerApp.swift
//  Ghost Tracker
//
//  Created by Colin Greene on 10/27/21.
//

import SwiftUI

@main
struct Ghost_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(motion: MagnetManager())
        }
    }
}
