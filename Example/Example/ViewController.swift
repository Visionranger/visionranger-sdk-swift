//
//  ViewController.swift
//  Example
//
//  Created by Colin Tessarzick on 30.09.21.
//

import UIKit
import Visionranger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = VSNAPIClient.shared
        
        print(VisionrangerAPI.maxRetries)
        
        client.retrieveProduct(id: "1") { product, error in
            guard let product = product, error == nil else {
                print(error?.localizedDescription ?? "Some error occured")
                return
            }
            let item = product.self
            print(item)
        }
    }
}
