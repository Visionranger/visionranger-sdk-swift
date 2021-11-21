//
//  ViewController.swift
//  Basic Integration
//
//  Created by Colin Tessarzick on 01.10.21.
//
//  Copyright © 2020-2021 Visionranger e.K. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import Visionranger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let client = VSNAPIClient.shared
//
//        client.createConfiguration(withParameters: [
//            "color": "Timberwolf",
//            "color_code": "D6D0C7",
//            "delivery_index": VSNEstimatedDelivery.twoToThreeMonths.rawValue,
//            "depth": 68,
//            "height": 91.5,
//            "width": 90,
//            "image_url": "https://catalog.visionranger.com/products/vipp466_3_preview.png",
//            "material": VSNFurnitureMaterial.cotton.rawValue,
//            "model_url": "https://catalog.visionranger.com/products/v466-Lodge-Lounge-Chair-BARNUM03.usdz",
//            "price": 2143.9,
//            "product_id": "7",
//            "sku": "N/A",
//            "specific": "Light Oak Legs"
//        ]) { config, error in
//            guard let config = config else {
//                return
//            }
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            if let value = config.price {
//                print(value)
//            }
//        }
        
//        client.retrieveProduct(id: "5") { product, error in
//            guard let object = product else {
//                return
//            }
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            if let value = object.allResponseFields["designer"] {
//                print(value)
//            } else {
//                print("something is not right")
//            }
//        }
        
        print(VSNRoom.bathroom.localizedDescription)
    }
}

