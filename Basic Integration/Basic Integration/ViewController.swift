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
        
//        client.createConfiguration(withParameters: [
//            "color": "Umber",
//            "color_code": "685548",
//            "delivery_index": VSNEstimatedDelivery.twoToThreeMonths.rawValue,
//            "depth": 68,
//            "height": 91.5,
//            "width": 90,
//            "image_url": "https://catalog.visionranger.com/products/vipp466_1_preview.png",
//            "material": VSNFurnitureMaterial.unknown.rawValue,
//            "model_url": "https://catalog.visionranger.com/products/v466-Lodge-Lounge-Chair-CURLY07.usdz",
//            "price": 4508.9,
//            "product_id": "7",
//            "sku": "N/A",
//            "specific": "Dark Oak Legs"
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
//
//        client.createConfiguration(withParameters: [
//            "color": "Beaver",
//            "color_code": "A58574",
//            "delivery_index": VSNEstimatedDelivery.twoToThreeMonths.rawValue,
//            "depth": 68,
//            "height": 91.5,
//            "width": 90,
//            "image_url": "https://catalog.visionranger.com/products/vipp466_2_preview.png",
//            "material": VSNFurnitureMaterial.aniline_leather.rawValue,
//            "model_url": "https://catalog.visionranger.com/products/v466-Lodge-Lounge-Chair-CLOUD258.usdz",
//            "price": 3463.9,
//            "product_id": "7",
//            "sku": "N/A",
//            "specific": "Dark Oak Legs"
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
//
//        client.createConfiguration(withParameters: [
//            "color": "Light French Beige",
//            "color_code": "C5A781",
//            "delivery_index": VSNEstimatedDelivery.threeToFourWeeks.rawValue,
//            "depth": 130,
//            "height": 73,
//            "width": 130,
//            "image_url": "https://catalog.visionranger.com/products/vipp494_preview.png",
//            "material": VSNFurnitureMaterial.oak.rawValue,
//            "model_url": "https://catalog.visionranger.com/products/v494_cabin_table_round.usdz",
//            "price": 5091.9,
//            "product_id": "6",
//            "sku": "VIPP 49430",
//            "specific": "Light Beige Jura Marble"
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
        
        client.retrieveProduct(id: "1") { product, error in
            guard let product = product else {
                return
            }
            if let error = error {
                print(error.localizedDescription)
            }
            if let value = product.catalogization?.category {
                print(value.localizedDescription)
            }
        }
    }
}

