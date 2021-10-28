//
//  MagnetManager.swift
//  Ghost Tracker
//
//  Created by Colin Greene on 10/27/21.
//

import Foundation
import Combine
import CoreMotion

class MagnetManager: ObservableObject {

    private var magnetManager: CMMotionManager

    @Published
    var x: Double = 0.0
    @Published
    var y: Double = 0.0
    @Published
    var z: Double = 0.0


    init() {
        self.magnetManager = CMMotionManager()
        self.magnetManager.magnetometerUpdateInterval = 1/60
        self.magnetManager.startMagnetometerUpdates(to: .main) { (magnetometerData, error) in
            guard error == nil else {
                print(error!)
                return
            }

            if let magnetData = magnetometerData {
                self.x = magnetData.magneticField.x
                self.y = magnetData.magneticField.y
                self.z = magnetData.magneticField.z
            }

        }

    }
}
