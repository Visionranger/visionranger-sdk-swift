//
//  VSNProductDimensions.swift
//  VSNProductDimensions
//
//  Created by Colin Tessarzick on 23.09.21.
//

import Foundation

/// Product dimensions and volume are important values for determining the product size category.
///
/// In addition to product weight, dimensions are used to calculate a variety of fees for shipping through Visionranger's verified panrter businesses, including storage fees, shipping fees, assembly fees and handling fees for merchandise returns.
public class VSNProductDimensions: NSObject {
    
    /// The length of the product in centimeter
    public var length: Double?
    
    /// The height of the product in centimeter
    public var height: Double?
    
    /// The width of the product in centimeter
    public var width: Double?
    
    public var allResponseFields: [AnyHashable : Any]
    
    /// A convenient way of initialising a `VSNProductDimensions` object
    /// - Parameter dimensions: An array of type `Double`. The order of values is important!
    ///
    /// To initialize the object correctly, write the array as follows:
    /// ```
    /// [length, height, width]
    /// ```
    public convenience init(_ dimensions: [Double]) {
        let length = Double(dimensions.index(0, offsetBy: 0))
        let height = Double(dimensions.index(1, offsetBy: 0))
        let width = Double(dimensions.index(2, offsetBy: 0))
        
        self.init(length: length, height: height, width: width, allResponseFields: [:])
    }
    
    internal init(length: Double, height: Double, width: Double, allResponseFields: [AnyHashable: Any]) {
        self.length = length
        self.height = height
        self.width = width
        self.allResponseFields = allResponseFields
        super.init()
    }
    
    /// Initializes a new `VSNProductDimensions` object with a length, height and width of 0 centimeters.
    convenience override init() {
        self.init(length: 0, height: 0, width: 0, allResponseFields: [:])
    }
}

extension VSNProductDimensions: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response else {
            return nil
        }
        
        let dimensions = VSNProductDimensions()
        dimensions.allResponseFields = dict
        // All propertes are nullable
        dimensions.length = dict["length"] as? Double
        dimensions.width = dict["width"] as? Double
        dimensions.height = dict["height"] as? Double
        
        return dimensions as? Self
    }
}
