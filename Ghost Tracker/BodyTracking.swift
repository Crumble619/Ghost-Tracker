//
//  BodyTracking.swift
//  Ghost Tracker
//
//  Created by Colin Greene on 10/27/21.
//

import SwiftUI
import RealityKit
import ARKit

class BodySkeleton: Entity {
    var jointNames: [String] = ["head_joint", "right_arm_joint", "right_forearm_joint", "right_hand_joint", "left_arm_joint", "left_forearm_joint", "left_hand_joint", "neck_1_joint", "hips_joint", "spine_4_joint", "spine_7_joint", "right_upleg_joint", "right_leg_joint", "right_foot_joint", "left_upleg_joint", "left_leg_joint", "left_foot_joint"]
    var joints: [String: Entity] = [:]
    
    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()
        
        //ARSkeletonDefinition.defaultBody3D.jointNames
        
        for jointName in jointNames {
            var jointRadius: Float = 0.03
            var jointColor: UIColor = .green
            
            let jointEntity = makeJoint(radius: jointRadius, color: jointColor)
            joints[jointName] = jointEntity
            self.addChild(jointEntity)
        }
        
        self.update(with: bodyAnchor)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func makeJoint(radius: Float, color: UIColor) -> Entity {
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: color, roughness: 0.8, isMetallic: false)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        
        return modelEntity
    }
    
    func update(with bodyAnchor: ARBodyAnchor) {
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
            if let jointEntity = joints[jointName], let jointTransform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: jointName)) {
                let jointOffset = simd_make_float3(jointTransform.columns.3)
                jointEntity.position = rootPosition + jointOffset
                jointEntity.orientation = Transform(matrix: jointTransform).rotation
            }
        }
    }
}

var bodySkeleton: BodySkeleton?
var bodySkeletonAnchor = AnchorEntity()

struct ARViewContainer: UIViewRepresentable {
    
    typealias UIViewType = ARView
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.setupForBodyTracking()
        
        arView.scene.addAnchor(bodySkeletonAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

extension ARView: ARSessionDelegate {
    
    func setupForBodyTracking() {
        
        let config = ARBodyTrackingConfiguration()
        self.session.run(config)
        
        self.session.delegate = self
    }
    
    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let bodyAnchor = anchor as? ARBodyAnchor {
                // Create or update skeleton.
                if let skeleton = bodySkeleton {
                    // BodySkeleton already exists, update pose of all joints.
                    skeleton.update(with: bodyAnchor)
                } else {
                    // Seeing body for the first time, create bodySkeleton.
                    let skeleton = BodySkeleton(for: bodyAnchor)
                    bodySkeleton = skeleton
                    bodySkeletonAnchor.addChild(skeleton)
                }
            }
        }
    }
}

struct BodyTracking: View {
    var body: some View {
        return ARViewContainer()
    }
}

struct BodyTracking_Previews: PreviewProvider {
    static var previews: some View {
        BodyTracking()
    }
}
