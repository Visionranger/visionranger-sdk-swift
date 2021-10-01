//
//  VSNCatalogizationEnums.swift
//  Visionranger
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

import Foundation

/// The associated room of a product
public enum VSNRoom: Int {
    /// Balcony as a product's associated room
    case balcony
    /// Basement as a product's associated room
    case basement
    /// Bathroom as a product's associated room
    case bathroom
    /// Powder Room as a product's associated room
    case powder_room
    /// Corridor as a product's associated room
    case corridor
    /// Garden as a product's associated room
    case garden
    /// Guest Room as a product's associated room
    case guest_room
    /// Entrance Hall as a product's associated room
    case entrance_hall
    /// Kitchen as a product's associated room
    case kitchen
    /// Library as a product's associated room
    case library
    /// Living Room as a product's associated room
    case living_room
    /// Children's Room as a product's associated room
    case childrens_room
    /// Dining Room as a product's associated room
    case dining_room
    /// Wine Cellar as a product's associated room
    case wine_cellar
    /// Bedroom as a product's associated room
    case bedroom
    /// Pantry as a product's associated room
    case pantry
    /// Study Room as a product's associated room
    case study
    /// Wardrobe as a product's associated room
    case wardrobe
    /// Attic as a product's associated room
    case attic
    /// Laundry Room as a product's associated room
    case laundry_room
    /// A product's associated room is not specified or the value is unknown
    case unknown
    
    var name: String {
        switch self {
        case .balcony:
            return NSLocalizedString("Balcony", comment: "Associated Room to a product")
        case .basement:
            return NSLocalizedString("Basement", comment: "Associated Room to a product")
        case .bathroom:
            return NSLocalizedString("Bathroom", comment: "Associated Room to a product")
        case .powder_room:
            return NSLocalizedString("Powder Room", comment: "Associated Room to a product")
        case .corridor:
            return NSLocalizedString("Corridor", comment: "Associated Room to a product")
        case .garden:
            return NSLocalizedString("Garden", comment: "Associated Room to a product")
        case .guest_room:
            return NSLocalizedString("Guest Room", comment: "Associated Room to a product")
        case .entrance_hall:
            return NSLocalizedString("Entrance Hall", comment: "Associated Room to a product")
        case .kitchen:
            return NSLocalizedString("Kitchen", comment: "Associated Room to a product")
        case .library:
            return NSLocalizedString("Library", comment: "Associated Room to a product")
        case .childrens_room:
            return NSLocalizedString("Childrens Room", comment: "Associated Room to a product")
        case .dining_room:
            return NSLocalizedString("Dining Room", comment: "Associated Room to a product")
        case .wine_cellar:
            return NSLocalizedString("Wine Cellar", comment: "Associated Room to a product")
        case .bedroom:
            return NSLocalizedString("Bedroom", comment: "Associated Room to a product")
        case .pantry:
            return NSLocalizedString("Pantry", comment: "Associated Room to a product")
        case .study:
            return NSLocalizedString("Study Room", comment: "Associated Room to a product")
        case .wardrobe:
            return NSLocalizedString("Wardrobe", comment: "Associated Room to a product")
        case .attic:
            return NSLocalizedString("Attic", comment: "Associated Room to a product")
        case .laundry_room:
            return NSLocalizedString("Laundry Room", comment: "Associated Room to a product")
        case .unknown:
            fallthrough
        default:
            return NSLocalizedString("Unknown", comment: "Default missing room index label")
        }
    }
}

/// Interior Design Style associated to a product
public enum VSNDesignStyle: Int {
    /// Combines warm feel-good atmosphere with strict aesthetics and brings together the cool style of the North with the reduced aesthetics of the East
    case japandi
    /// Describes a Swedish attitude to life that aims for the golden mean - not too much and not too little
    case lagom
    /// Japanese concept of aesthetics based on clarity and imperfection
    case wabi_sabi
    /// Characterised by simplicity, clean lines, and a monochromatic palette with colour used as an accent
    case minimalism
    /// Stepping away from a purely traditional country design style; modern country allows for more playful and nuanced aspects along with minimal notes
    case modern_country
    /// A minimalistic style using a blend of textures and soft hues to make sleek, modern décor feel warm and inviting
    case scandinavian
    /// Embraces a worn, lived-in look
    case shabby_chic
    /// Transverses all seasons and is best described as the creation of “coziness” and “togetherness”.
    case hygge
    /// Celebrate natural materials, neutral or earthy colors, and the elimination of unnecessary detailing
    ///
    /// Often confused with contemporary style, today’s modern style is based on a design movement that was birthed around the turn of the 20th century.
    /// While you may see a range of colors in contemporary styling, modern styles would have monochromatic colors.
    case modern
    /// Reasonable combination of rich luxury, comfort and exoticism
    ///
    /// This design is suitable for those whose wealth is above average. High-quality natural materials, decoration and decor are worth a lot.
    case colonial
    /// A combination of classical and modern elements
    ///
    /// It is not too cumbersome, but it exudes a sense of authenticity and modernity.
    /// This style uses classic furniture but has omitted the cumbersome and classic details, so it is both neat, simple and luxurious.
    case retro
    /// Nautical style which involves the use of decoration and finishing materials that are associated with the sea, beach, ships
    case maritime
    /// Characterized by refined lines, minimalist silhouettes, and natural shapes
    case mid_century_modern
    /// Focus on indoor-outdoor living; natural materials and finishes; and an effortless, minimalist-chic approach to decorating
    case mediterranean
    /// Features creative application of rich patterns and vibrant colors, especially those with red or purple tones
    case bohemian
    /// Minimalist modern, glamorous chic, ethnic heirlooms, and edgy experimental designs all collide in a distinctively 21st-century setting
    case urban_modern
    /// Combination of metallic, neutral and accent color
    case glam
    /// Emphasizes liberal use of exposed steel with distressed wooden elements, frequently complemented by exposed brick walls
    case industrial
    /// Lots of wood, brassy eye-catchers, Alpine accents, alluring items for cuddling, and bit of rustic charm
    case chalet_chic
    /// A product's associated design style is not specified or the value is unknown
    case unknown
    
    var name: String {
        switch self {
        case .japandi:
            return NSLocalizedString("Japandi", comment: "Interior Design Style associated to a product")
        case .lagom:
            return NSLocalizedString("Lagom", comment: "Interior Design Style associated to a product")
        case .wabi_sabi:
            return NSLocalizedString("Wabi Sabi", comment: "Interior Design Style associated to a product")
        case .minimalism:
            return NSLocalizedString("Minimalism", comment: "Interior Design Style associated to a product")
        case .modern_country:
            return NSLocalizedString("Modern Country", comment: "Interior Design Style associated to a product")
        case .scandinavian:
            return NSLocalizedString("Scandinavian", comment: "Interior Design Style associated to a product")
        case .shabby_chic:
            return NSLocalizedString("Shabby Chic", comment: "Interior Design Style associated to a product")
        case .hygge:
            return NSLocalizedString("Hygge", comment: "Interior Design Style associated to a product")
        case .modern:
            return NSLocalizedString("Modern", comment: "Interior Design Style associated to a product")
        case .colonial:
            return NSLocalizedString("Colonial", comment: "Interior Design Style associated to a product")
        case .retro:
            return NSLocalizedString("Retro", comment: "Interior Design Style associated to a product")
        case .maritime:
            return NSLocalizedString("Maritime", comment: "Interior Design Style associated to a product")
        case .mid_century_modern:
            return NSLocalizedString("Mid-Century Modern", comment: "Interior Design Style associated to a product")
        case .mediterranean:
            return NSLocalizedString("Mediterranean", comment: "Interior Design Style associated to a product")
        case .bohemian:
            return NSLocalizedString("Bohemian", comment: "Interior Design Style associated to a product")
        case .urban_modern:
            return NSLocalizedString("Urban Modern", comment: "Interior Design Style associated to a product")
        case .glam:
            return NSLocalizedString("Modern Glamour", comment: "Interior Design Style associated to a product")
        case .industrial:
            return NSLocalizedString("Industrial", comment: "Interior Design Style associated to a product")
        case .chalet_chic:
            return NSLocalizedString("Chalet Chic", comment: "Interior Design Style associated to a product")
        case .unknown:
            fallthrough
        default:
            return NSLocalizedString("Unknown", comment: "Default missing design style index label")
        }
    }
}
