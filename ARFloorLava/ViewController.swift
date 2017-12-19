//
//  ViewController.swift
//  ARFloorLava
//
//  Created by Victor Hong on 19/12/2017.
//  Copyright © 2017 Victor Hong. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        let lavaNode = createLava()
        self.sceneView.scene.rootNode.addChildNode(lavaNode)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createLava() -> SCNNode {
        
        let lavaNode = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.1))
        lavaNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "lava")
        lavaNode.geometry?.firstMaterial?.isDoubleSided = true
        lavaNode.position = SCNVector3(0, 0, -1)
        lavaNode.eulerAngles = SCNVector3(CGFloat(90.degreesToRadians), 0, 0)
        
        return lavaNode
        
    }

    //MARK: ARSCN View Delegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        print("new flat surface detected, new ARPlaneAnchor added")
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        print("updating floor's anchor...")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
        
    }
    
}

extension Int {
    var degreesToRadians: Double {return Double(self) * .pi/180}
}
