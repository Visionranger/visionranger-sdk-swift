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
    /// A room containing a bath or shower and typically also a washbasin and a toilet.
    case bathroom
    /// Powder Room as a product's associated room
    case powder_room
    /// A long passage with doors into rooms on both sides of it
    ///
    /// A hallway in a house or an apartment is the area just inside the front door, into which some of the other rooms open.
    case hallway
    /// Garden as a product's associated room
    case garden
    /// Guest Room as a product's associated room
    case guest_room
    /// Opening or hallway allowing entry into a structure
    case entrance_hall
    /// A group of furniture or space where food is prepared and cooked
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
    /// A group of furniture or space to sleep, study, entertain friends, share, and relax
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
    
    public var localizedDescription: String {
        switch self {
        case .balcony:
            return VSNLocalizedString("Balcony", comment: "Associated Room to a product")
        case .basement:
            return VSNLocalizedString("Basement", comment: "Associated Room to a product")
        case .bathroom:
            return VSNLocalizedString("Bathroom", comment: "Associated Room to a product")
        case .powder_room:
            return VSNLocalizedString("Powder Room", comment: "Associated Room to a product")
        case .hallway:
            return VSNLocalizedString("Hallway", comment: "Associated Room to a product")
        case .garden:
            return VSNLocalizedString("Garden", comment: "Associated Room to a product")
        case .guest_room:
            return VSNLocalizedString("Guest Room", comment: "Associated Room to a product")
        case .entrance_hall:
            return VSNLocalizedString("Entrance Hall", comment: "Associated Room to a product")
        case .kitchen:
            return VSNLocalizedString("Kitchen", comment: "Associated Room to a product")
        case .library:
            return VSNLocalizedString("Library", comment: "Associated Room to a product")
        case .childrens_room:
            return VSNLocalizedString("Childrens Room", comment: "Associated Room to a product")
        case .dining_room:
            return VSNLocalizedString("Dining Room", comment: "Associated Room to a product")
        case .wine_cellar:
            return VSNLocalizedString("Wine Cellar", comment: "Associated Room to a product")
        case .bedroom:
            return VSNLocalizedString("Bedroom", comment: "Associated Room to a product")
        case .pantry:
            return VSNLocalizedString("Pantry", comment: "Associated Room to a product")
        case .study:
            return VSNLocalizedString("Study Room", comment: "Associated Room to a product")
        case .wardrobe:
            return VSNLocalizedString("Wardrobe", comment: "Associated Room to a product")
        case .attic:
            return VSNLocalizedString("Attic", comment: "Associated Room to a product")
        case .laundry_room:
            return VSNLocalizedString("Laundry Room", comment: "Associated Room to a product")
        case .unknown:
            fallthrough
        default:
            return VSNLocalizedString("Unknown", comment: "Default missing room index label")
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
    
    public var localizedDescription: String {
        switch self {
        case .japandi:
            return VSNLocalizedString("Japandi", comment: "Interior Design Style associated to a product")
        case .lagom:
            return VSNLocalizedString("Lagom", comment: "Interior Design Style associated to a product")
        case .wabi_sabi:
            return VSNLocalizedString("Wabi Sabi", comment: "Interior Design Style associated to a product")
        case .minimalism:
            return VSNLocalizedString("Minimalism", comment: "Interior Design Style associated to a product")
        case .modern_country:
            return VSNLocalizedString("Modern Country", comment: "Interior Design Style associated to a product")
        case .scandinavian:
            return VSNLocalizedString("Scandinavian", comment: "Interior Design Style associated to a product")
        case .shabby_chic:
            return VSNLocalizedString("Shabby Chic", comment: "Interior Design Style associated to a product")
        case .hygge:
            return VSNLocalizedString("Hygge", comment: "Interior Design Style associated to a product")
        case .modern:
            return VSNLocalizedString("Modern", comment: "Interior Design Style associated to a product")
        case .colonial:
            return VSNLocalizedString("Colonial", comment: "Interior Design Style associated to a product")
        case .retro:
            return VSNLocalizedString("Retro", comment: "Interior Design Style associated to a product")
        case .maritime:
            return VSNLocalizedString("Maritime", comment: "Interior Design Style associated to a product")
        case .mid_century_modern:
            return VSNLocalizedString("Mid-Century Modern", comment: "Interior Design Style associated to a product")
        case .mediterranean:
            return VSNLocalizedString("Mediterranean", comment: "Interior Design Style associated to a product")
        case .bohemian:
            return VSNLocalizedString("Bohemian", comment: "Interior Design Style associated to a product")
        case .urban_modern:
            return VSNLocalizedString("Urban Modern", comment: "Interior Design Style associated to a product")
        case .glam:
            return VSNLocalizedString("Modern Glamour", comment: "Interior Design Style associated to a product")
        case .industrial:
            return VSNLocalizedString("Industrial", comment: "Interior Design Style associated to a product")
        case .chalet_chic:
            return VSNLocalizedString("Chalet Chic", comment: "Interior Design Style associated to a product")
        case .unknown:
            fallthrough
        default:
            return VSNLocalizedString("Unknown", comment: "Default missing design style index label")
        }
    }
}

/// Associated group of furniture or purpose specific area
public enum VSNHouseArea: Int {
    /// A group of furniture or space designed to serve dishes and meals
    case dining_area
    /// A group of furniture or space designed to relax and get together
    case living_area
    /// A group of furniture or space where food is prepared and cooked
    case kitchen
    /// A group of furniture or space to sleep, study, entertain friends, share, and relax
    case bedroom
    /// A room containing a bath or shower and typically also a washbasin and a toilet.
    case bathroom
    /// A long passage with doors into rooms on both sides of it
    ///
    /// A hallway in a house or an apartment is the area just inside the front door, into which some of the other rooms open.
    case hallway
    /// Opening or hallway allowing entry into a structure
    case entrance
    /// A product's associated house area is not specified or the value is unknown
    case unknown
    
    public var localizedDescription: String {
        switch self {
        case .dining_area:
            return VSNLocalizedString("Dining Area", comment: "Associated group of furnitre or purpose specific area")
        case .living_area:
            return VSNLocalizedString("Living Area", comment: "Associated group of furnitre or purpose specific area")
        case .kitchen:
            return VSNLocalizedString("Kitchen", comment: "Associated group of furnitre or purpose specific area")
        case .bedroom:
            return VSNLocalizedString("Bedroom", comment: "Associated group of furnitre or purpose specific area")
        case .bathroom:
            return VSNLocalizedString("Bathroom", comment: "Associated group of furnitre or purpose specific area")
        case .hallway:
            return VSNLocalizedString("Corridor", comment: "Associated group of furnitre or purpose specific area")
        case .entrance:
            return VSNLocalizedString("Entrance", comment: "Associated group of furnitre or purpose specific area")
        case .unknown:
            fallthrough
        default:
            return VSNLocalizedString("Unknown", comment: "Default missing product type index label")
        }
    }
}

/// A distinct type of furniture or decor
public enum VSNFurnitureType: Int {
    case sofa
    case seating
    case shelf
    case cabinet
    case table
    case side_table
    case bed
    case rug
    case commode
    case lamp
    case mirror
    case wardrobe
    case baby_furniture
    /// A product's associated furniture type is not specified or the value is unknown
    case unknown
    
    public var localizedDescription: String {
        switch self {
        case .sofa:
            return VSNLocalizedString("Sofa", comment: "A distinct type of furniture or decor")
        case .seating:
            return VSNLocalizedString("Seating", comment: "A distinct type of furniture or decor")
        case .shelf:
            return VSNLocalizedString("Shelf", comment: "A distinct type of furniture or decor")
        case .cabinet:
            return VSNLocalizedString("Cabinet", comment: "A distinct type of furniture or decor")
        case .table:
            return VSNLocalizedString("Table", comment: "A distinct type of furniture or decor")
        case .side_table:
            return VSNLocalizedString("Side Table", comment: "A distinct type of furniture or decor")
        case .bed:
            return VSNLocalizedString("Bed", comment: "A distinct type of furniture or decor")
        case .rug:
            return VSNLocalizedString("Rug", comment: "A distinct type of furniture or decor")
        case .commode:
            return VSNLocalizedString("Commode", comment: "A distinct type of furniture or decor")
        case .lamp:
            return VSNLocalizedString("Lamp", comment: "A distinct type of furniture or decor")
        case .mirror:
            return VSNLocalizedString("Mirror", comment: "A distinct type of furniture or decor")
        case .wardrobe:
            return VSNLocalizedString("Wardrobe", comment: "A distinct type of furniture or decor")
        case .baby_furniture:
            return VSNLocalizedString("Baby Furniture", comment: "A distinct type of furniture or decor")
        case .unknown:
            fallthrough
        default:
            return VSNLocalizedString("Unknown", comment: "Default missing product type index label")
        }
    }
}

/// A specific type of furniture that shares similarities with others
public enum VSNFurnitureCategory: Int {
    /// Sofa or couch that, underneath its seating cushions, hides a metal frame and thin mattress that can be unfolded or opened up to make a bed
    case sofa_bed
    /// Low table designed to be placed in a sitting area for convenient support of beverages, remote controls, magazines, books (especially large, illustrated coffee table books), decorative objects, and other small items
    case coffee_table
    /// Small table or cabinet designed to stand beside a bed or elsewhere in a bedroom
    case nightstand
    /// Form of furniture typically of a rectangular structure with four walls and a removable lid, for storage
    case chest
    /// Large fabric bag, filled with polystyrene beans, designed by Piero Gatti, Cesare Paolini and Franco Teodoro
    case beanbag
    /// Piece of furniture for seating multiple people
    case couch
    /// A sofa that has a corner partway along it
    case corner_sofa
    /// A sofa that has a very large seating surface per person
    case bigsofa
    /// One large piece of furniture, that could be arranged separately
    case living_landscape
    /// Small pieces of furniture that are used only in combination with sofas
    case sofa_element
    /// Piece of furniture having various sections and compartments, designed to stand against a wall
    case wall_unit
    /// Low cupboards that provide plenty of storage space in the horizontal plane
    case lowboard
    /// A large, comfortable chair with side supports for a person's arms that also offers sleeping functionality
    case armchair_with_sleep_function
    /// A sofa that has a corner partway along it that also offers sleeping functionality
    case corner_sofa_with_sleep_function
    /// A comfortable chair for relaxing on, especially an outdoor chair that adjusts or extends, allowing a person to recline
    case lounger
    /// A large, extra comfortable chair with side supports for a person's arms
    case relax_armchair
    /// A large, comfortable chair with side supports for a person's arms
    case armchair
    /// A long seat for several people, typically made of wood or stone
    case bench
    /// A seat without a back or arms, typically resting on three or four legs or on a single pedestal
    case stool
    /// A shelf on which books can be stored
    case bookshelf
    /// A type of shelf whose wall mounts are hidden in the shelf and have no visible brackets
    case wall_shelf
    /// Screen or piece of furniture placed in a way that divides a room into separate areas
    case room_divider
    /// A flat length of wood or other rigid material, attached to a wall or forming part of a piece of furniture, that provides a surface for the storage or display of objects
    case shelf
    /// Item of furniture traditionally used in the dining room for serving food, for displaying serving dishes, and for storage
    case sideboard
    /// A cupboard with shelves or drawers for storing or displaying articles
    case cabinet
    /// High cupboards that provide plenty of storage space in the horizontal plane
    case highboard
    /// Sleep system in which a sprung base forms the basis instead of a slatted frame. Boxspring means spring box[1] and essentially describes the structure of the base frame
    case boxspring
    /// A bed made out of hardwood materials.
    case solid_wood_bed
    /// Any bed frame (including the foot and headboards) that incorporates materials such as velvet, faux leather or suede, or other materials other than wood
    case upholstered_bed
    /// Japanese traditional style of bedding
    case futon
    /// Any bed frame that is made of metal, typically iron
    case metal_bed
    /// Any bed made for multifunctional uses. Ideal for small spaces
    case functional_bed
    /// A large, tall cupboard or recess in which clothes may be hung or stored whose doors are mounted on the top and can freely be moved horizontally as wanted
    case floating_door_wardrobe
    /// A large, tall cupboard or recess in which clothes may be hung or stored whose doors are mounted with fixed hinges
    case hinged_door_wardrobe
    /// A table with a mirror and drawers, used while dressing or applying make-up
    case dressing_table
    /// A tall cupboard or wardrobe with a door, used for storage
    case closet
    /// A child's wicker cradle
    case bassinet
    /// Small raised platform designed to allow a person to change someone's diaper
    case changing_table
    /// Small bed especially for infants and very young children
    case infant_bed
    /// Small bench that is typically placed in front of a wardrobe or in a walk in closet
    case wardrobe_bench
    /// A mat placed in a doorway, on which people can wipe their shoes on entering a building
    case doormat
    /// A mirror placed near a coat rack or that is a part of a wardrobe
    case coat_mirror
    /// A table whose top is supported by brackets or brackets rather than the usual four legs
    case console_table
    /// A stand with hooks on which to hang coats, hats, etc
    case coat_rack
    /// Storage unit designed for holding shoes
    case shoe_cabinet
    /// Smaller wardrobe used for small clothes
    case wardrobe_cabinet
    /// A table on which meals are served in a dining room
    case dining_table
    /// A separate seat for one person, typically with a back and four legs
    case chair
    /// A chair that has one leg and is mounted on a big plate to grant stability
    case plate_foot
    /// A typical chair with 4 legs
    case four_feet_chair
    /// A chair whose seating and framework are not supported by the typical arrangement of 4 legs
    case cantilever
    /// A chair that also has support for a person's arms
    case chair_armchair
    /// A chair whose seating and framework are not supported by the typical arrangement of 4 legs
    case skid_chair
    /// A tall stool for customers at a bar to sit on
    case bar_stool
    /// Usually quite tall tables that require tall bar stools in order to accommodate patrons
    case bar_table
    /// Facilitates the transport of drinks, food and dishes
    case serving_trolley
    /// A piece of furniture consisting of two beds, one above the other, that form a unit
    case bunk_bed
    /// A bed whose frame is smaller than normal beds, to fit a kids body size
    case childrens_bed
    /// A piece of furniture with a flat or sloping surface and typically with drawers, at which one can read, write, or do other work
    case desk
    /// Type of chair that is designed for use at a desk in an office
    case desk_chair
    /// Made of a base of wide drawers topped by a desk with a hinged desktop surface, which is in turn topped by a bookcase usually closed with a pair of doors, often made of glass
    case secretary
    /// Type of chair that is designed for use at a desk in an office
    case office_chair
    /// A large piece of office furniture, typically made of metal, with deep drawers for storing documents
    case filing_cabinet
    /// A large, tall cupboard or recess in which documents may be stored
    case office_shelf
    /// A group of shelfs, cabinets and/or other pieces of office furniture that are aligned along an office's wall
    case office_wall
    /// A rug whose fibers are taller and looser
    case high_pile_rug
    /// A rug that is a dense and short-cut pile rug with a soft velvet appearance
    case velour_rug
    /// Woven wool rug. They are shaggy in appearance, and are thick and soft
    case flokati_rug
    /// Made of natural fibers that are very durable and versatile
    case sisal_rug
    /// A rug created without knots
    case tufted_rug
    /// Characterized by a longer pile length than other rugs, and sometimes referred to as "noodles" for their noodle like shape
    case shaggy_rug
    /// Very high pile rug
    case country_pile_rug
    /// A rug typically made of plastic that is placed in front of the house door to prevent dirt to get indoor
    case mudflap_rug
    /// Heavy textile made for a wide variety of utilitarian and symbolic purposes and produced in "Oriental countries"
    case oriental_rug
    /// Hand-woven carpets by the Berber people in North Africa and the Sahara
    case berber_carpet
    /// Completely woolen rugs with elaborate designs paired with perfectly mellowed tones of colors
    case nepali_rug
    /// Modern and well-designed rug without special pile requirements to be met
    case design_rug
    /// A rug whose base is made of sheep skin
    case sheepskin_rug
    /// A rug whose base os made of lamp skin
    case lampskin_rug
    /// Rugs that look like silk rugs, but don’t have the strength, vibrancy or feel of real silk
    case art_silk_rug
    /// Created by hand weaving silk fibres
    case silk_rug
    /// A product's category is not specified or the value is unknown
    case unknown
    
    public var localizedDescription: String {
        switch self {
        case .sofa_bed:
            return VSNLocalizedString("Sofa Bed", comment: "A product's category")
        case .coffee_table:
            return VSNLocalizedString("Coffee Table", comment: "A product's category")
        case .nightstand:
            return VSNLocalizedString("Nightstand", comment: "A product's category")
        case .chest:
            return VSNLocalizedString("Chest", comment: "A product's category")
        case .beanbag:
            return VSNLocalizedString("Beanbag", comment: "A product's category")
        case .couch:
            return VSNLocalizedString("Couch", comment: "A product's category")
        case .bigsofa:
            return VSNLocalizedString("Bigsofa", comment: "A product's category")
        case .living_landscape:
            return VSNLocalizedString("Living Landscape", comment: "A product's category")
        case .sofa_element:
            return VSNLocalizedString("Sofa Element", comment: "A product's category")
        case .wall_unit:
            return VSNLocalizedString("Wall Unit", comment: "A product's category")
        case .lowboard:
            return VSNLocalizedString("Lowboard", comment: "A product's category")
        case .armchair_with_sleep_function:
            return VSNLocalizedString("Armchair with sleep function", comment: "A product's category")
        case .corner_sofa_with_sleep_function:
            return VSNLocalizedString("Corner Sofa with sleep function", comment: "A product's category")
        case .lounger:
            return VSNLocalizedString("Lounger", comment: "A product's category")
        case .relax_armchair:
            return VSNLocalizedString("Relax Armchair", comment: "A product's category")
        case .armchair:
            return VSNLocalizedString("Armchair", comment: "A product's category")
        case .bench:
            return VSNLocalizedString("Bench", comment: "A product's category")
        case .stool:
            return VSNLocalizedString("Stool", comment: "A product's category")
        case .bookshelf:
            return VSNLocalizedString("Bookshelf", comment: "A product's category")
        case .wall_shelf:
            return VSNLocalizedString("Wall Shelf", comment: "A product's category")
        case .room_divider:
            return VSNLocalizedString("Room Divider", comment: "A product's category")
        case .shelf:
            return VSNLocalizedString("Shelf", comment: "A product's category")
        case .sideboard:
            return VSNLocalizedString("Sideboard", comment: "A product's category")
        case .cabinet:
            return VSNLocalizedString("Cabinet", comment: "A product's category")
        case .highboard:
            return VSNLocalizedString("Highboard", comment: "A product's category")
        case .boxspring:
            return VSNLocalizedString("Boxspring Bed", comment: "A product's category")
        case .solid_wood_bed:
            return VSNLocalizedString("Solid Wood Bed", comment: "A product's category")
        case .upholstered_bed:
            return VSNLocalizedString("Upholstered Bed", comment: "A product's category")
        case .futon:
            return VSNLocalizedString("Futon Bed", comment: "A product's category")
        case .metal_bed:
            return VSNLocalizedString("Metal Bed", comment: "A product's category")
        case .functional_bed:
            return VSNLocalizedString("Functional Bed", comment: "A product's category")
        case .floating_door_wardrobe:
            return VSNLocalizedString("Floating-Door Wardrobe", comment: "A product's category")
        case .hinged_door_wardrobe:
            return VSNLocalizedString("Hinged-Door Wardrobe", comment: "A product's category")
        case .dressing_table:
            return VSNLocalizedString("Dressing Table", comment: "A product's category")
        case .closet:
            return VSNLocalizedString("Closet", comment: "A product's category")
        case .bassinet:
            return VSNLocalizedString("Bassinet", comment: "A product's category")
        case .changing_table:
            return VSNLocalizedString("Changing Table", comment: "A product's category")
        case .infant_bed:
            return VSNLocalizedString("Baby Crib", comment: "A product's category")
        case .wardrobe_bench:
            return VSNLocalizedString("Wardrobe Bench", comment: "A product's category")
        case .doormat:
            return VSNLocalizedString("Doormat", comment: "A product's category")
        case .coat_mirror:
            return VSNLocalizedString("Coat Mirror", comment: "A product's category")
        case .console_table:
            return VSNLocalizedString("Console Table", comment: "A product's category")
        case .coat_rack:
            return VSNLocalizedString("Coat Rack", comment: "A product's category")
        case .shoe_cabinet:
            return VSNLocalizedString("Shoe Cabinet", comment: "A product's category")
        case .wardrobe_cabinet:
            return VSNLocalizedString("Wardrobe Cabinet", comment: "A product's category")
        case .dining_table:
            return VSNLocalizedString("Dining Table", comment: "A product's category")
        case .chair:
            return VSNLocalizedString("Chair", comment: "A product's category")
        case .plate_foot:
            return VSNLocalizedString("Plate-Foot Chair", comment: "A product's category")
        case .four_feet_chair:
            return VSNLocalizedString("4 Feet Chair", comment: "A product's category")
        case .cantilever:
            return VSNLocalizedString("Cantilever", comment: "A product's category")
        case .chair_armchair:
            return VSNLocalizedString("Chair Armchair", comment: "A product's category")
        case .skid_chair:
            return VSNLocalizedString("Skid Chair", comment: "A product's category")
        case .bar_stool:
            return VSNLocalizedString("Bar Stool", comment: "A product's category")
        case .bar_table:
            return VSNLocalizedString("Bar Table", comment: "A product's category")
        case .serving_trolley:
            return VSNLocalizedString("Serving Trolley", comment: "A product's category")
        case .bunk_bed:
            return VSNLocalizedString("Bunk Bed", comment: "A product's category")
        case .childrens_bed:
            return VSNLocalizedString("Children's Bed", comment: "A product's category")
        case .desk:
            return VSNLocalizedString("Desk", comment: "A product's category")
        case .desk_chair:
            return VSNLocalizedString("Desk Chair", comment: "A product's category")
        case .secretary:
            return VSNLocalizedString("Secretary", comment: "A product's category")
        case .office_chair:
            return VSNLocalizedString("Office Chair", comment: "A product's category")
        case .filing_cabinet:
            return VSNLocalizedString("Filing Cabinet", comment: "A product's category")
        case .office_shelf:
            return VSNLocalizedString("Office Shelf", comment: "A product's category")
        case .office_wall:
            return VSNLocalizedString("Office Wall", comment: "A product's category")
        case .high_pile_rug:
            return VSNLocalizedString("High Pile Rug", comment: "A product's category")
        case .velour_rug:
            return VSNLocalizedString("Velour Rug", comment: "A product's category")
        case .flokati_rug:
            return VSNLocalizedString("Flokati Rug", comment: "A product's category")
        case .sisal_rug:
            return VSNLocalizedString("Sisal Rug", comment: "A product's category")
        case .tufted_rug:
            return VSNLocalizedString("Tufted Rug", comment: "A product's category")
        case .shaggy_rug:
            return VSNLocalizedString("Shaggy Rug", comment: "A product's category")
        case .country_pile_rug:
            return VSNLocalizedString("Country Pile Rug", comment: "A product's category")
        case .mudflap_rug:
            return VSNLocalizedString("Mudflap Rug", comment: "A product's category")
        case .oriental_rug:
            return VSNLocalizedString("Oriental Rug", comment: "A product's category")
        case .berber_carpet:
            return VSNLocalizedString("Berber Carpet", comment: "A product's category")
        case .nepali_rug:
            return VSNLocalizedString("Nepal/Tibet Rug", comment: "A product's category")
        case .design_rug:
            return VSNLocalizedString("Design Rug", comment: "A product's category")
        case .sheepskin_rug:
            return VSNLocalizedString("Sheepskin Rug", comment: "A product's category")
        case .lampskin_rug:
            return VSNLocalizedString("Lampskin Rug", comment: "A product's category")
        case .art_silk_rug:
            return VSNLocalizedString("Art Silk Rug", comment: "A product's category")
        case .silk_rug:
            return VSNLocalizedString("Silk Rug", comment: "A product's category")
        case .unknown:
            fallthrough
        default:
            return VSNLocalizedString("Unknown", comment: "Default missing product category index label")
        }
    }
}

/// A product's component major material
///
/// A material is defined as major, when it covers at least 50% of the component's visible surface
public enum VSNFurnitureMaterial: Int {
    /// Brand name of a common synthetic textile material
    case alcantara
    /// Type of leather dyed exclusively with soluble dyes
    case aniline_leather
    /// Soft, fluffy staple fiber that grows in a boll, or protective case, around the seeds of the cotton plants of the genus Gossypium in the mallow family Malvaceae
    case cotton
    /// Robust upholstery fabric made according to new weaving techniques in a mixture of polyester and polyacrylic
    case boucle_robusta
    /// Rich fabric woven with a raised pattern, typically with gold or silver thread
    case brocade
    /// A fabric woven densely and tightly from strong yarn
    case canvas
    /// A woven or knitted fabric with a velvety surface made of chenille yarn
    case chenille
    /// Woodblock printed, painted, stained or glazed calico textile that originated in Golconda (present day Hyderabad, India) in the 16th century
    case chintz
    /// Textile with a distinctive texture—a raised "cord" or wale. Modern corduroy is most commonly composed of tufted cords, sometimes exhibiting a channel (bare to the base fabric) between the tufts
    case corduroy
    /// Acrylic fabric coated with Teflon, which is a classic water-resistant outdoor fabric
    case dralon
    /// Heavy smooth woven cotton fabric
    case drell
    /// The colour of unbleached linen
    case ecru
    /// A silk, rayon, or worsted clothing fabric in plain weave characterized by alternating wide and narrow cross ribs
    case epingle
    /// Fabric without texture or an obvious surface relief
    case flat_fabric
    /// Fabric that is worked with alternating sides facing the knitter
    case flat_knitted_fabric
    /// In textile technology, refers to fibers that protrude from the fabric.
    case flor
    /// Made of distinct material qualities such as nylon, cotton, spandex, polyester, and many more
    case goblin
    /// Type of fabric woven on a Jacquard loom, a machine loom invented by the French textile artisan Joseph Marie Jacquard in 1804
    case jacquard
    /// Sturdy cotton warp-faced textile in which the weft passes under two or more warp threads
    case denim
    // :nodoc:
    case freton
    /// One of several names given to artificial or synthetic leather
    case faux_leather
    /// Leather noted for its soft feel. It is a generic term in the leather field and has no distinct test for characterization
    case nappa_leather
    /// Textile made from the fibers of the flax plant
    case linen
    /// Synthetic fiber finer than one denier or decitex/thread, having a diameter of less than ten micrometers
    case microfiber
    /// Fabric or yarn made from the hair of the Angora goat (not to be confused with the Angora rabbit, which produces Angora wool)
    case mohair
    /// An optical effect in which the superimposition of regular rasters creates a raster, again periodic, which has special structures that are not present in any of the individual patterns and vary when the method of superimposition is changed
    case moire
    // :nodoc:
    case nanova
    /// Generic designation for a family of synthetic polymers composed of polyamides
    case nylon
    /// Type of woven dress shirt fabric, employed to make dress shirts sometimes called Oxford shirts worn on casual to formal occasions
    case oxford_fabric
    /// Refers to a weave style typically used for cotton yarn and characterized by raised parallel cords or geometric patterns in the fabric
    case pique
    /// Rich fabric of silk, cotton, wool, or a combination of these, with a long, soft nap
    case plush
    /// Category of polymers that contain the ester functional group in every repeat unit of their main chain
    case polyester
    /// Woven fabrics, often made of nylon, using a special reinforcing technique that makes them resistant to tearing and ripping
    case ripstop
    /// Type of woven tufted fabric in which the cut threads are evenly distributed, with a short dense pile, giving it a distinctive soft feel
    case velvet
    /// Type of fabric weave that produces a characteristically glossy, smooth or lustrous material, typically with a glossy top surface and a dull back
    case satin
    /// Natural protein fiber, some forms of which can be woven into textiles
    case silk
    /// Plush, knitted fabric or textile similar to velvet or velveteen. It is usually made from cotton, but can also be made from synthetic materials such as polyester
    case velour
    /// Type of leather with a fuzzy, napped finish
    case suede_leather
    /// Synthetic fiber made from natural sources of regenerated cellulose such as wood and related agricultural products
    case viscose
    /// Pile jersey fabrics having soft protruding fibers on the fabric surface
    case knitted_velour
    /// Top-grain leather that has been sanded or buffed on the grain side, or outside, to give a slight nap of short protein fibers, producing a velvet-like surface
    case nubuck
    /// Differs from cowhide in thickness and flexibility which translates into exceptionally durable and comfortable upholstered furniture
    case buffalo_leather
    /// Brushed or dull polished metal is metal with a unidirectional satin finish
    case brushed_aluminum
    /// Physically hand buffed and shined to a mirrored finish and has no protective coating
    case polished_aluminum
    /// Alloy consisting primarily of copper, commonly with about 12–12.5% tin and often with the addition of other metals (such as tin, aluminium, manganese, nickel or zinc) and sometimes non-metals or metalloids such as arsenic, phosphorus or silicon
    case bronze
    /// Refers to the element chromium, which can be applied over another metal as a thin layer to create a gleaming finish
    case chrome
    /// Corrosion-resistant alloy of iron, chromium and, in some cases, nickel and other metals
    case stainless_steel
    /// Strong, hard magnetic silvery-grey metal, the chemical element of atomic number 26
    case iron
    /// Chemical element with the symbol Au (from Latin: aurum) and atomic number 79
    case gold
    /// Chemical element with the symbol Cu (from Latin: cuprum) and atomic number 29
    case copper
    /// Alloy of copper and zinc, in proportions which can be varied to achieve varying mechanical, electrical, and chemical properties
    case brass
    /// Chemical element with the symbol Ni and atomic number 28
    case nickel
    /// Precious shiny greyish-white metal, the chemical element of atomic number 47
    case silver
    /// Type of hardwood that derives from the oak tree native to the northern hemisphere
    case oak
    /// Fine-grained wood that has a light orange to salmon colour
    case beech
    /// Harder, heavier and usually lighter in colour than the so often processed American variety
    case european_walnut
    /// Fine, uniform texture with generally straight grain, but variations such as birdseye, tiger, flame, curly, wavy, rippled or fiddleback grain occur and are often selected for specialty custom artisan furniture
    case maple
    /// Hardwood that is extremely strong and durable
    case birch
    /// Inexpensive, lightweight wood that can be yellowish or whitish with brown knots
    case pine
    /// Only genus of the subfamily Piceoideae within the plant family of the pine family
    case spruce
    /// One of the softest woods in the hardwood family, just above pine and poplar
    case alder
    /// Hardwood that comes from the cherry fruit tree
    case cherry_tree
    /// Deciduous conifer that grows fast in cold climates
    case larch
    /// Straight-grained, reddish-brown timber of three tropical hardwood species of the genus Swietenia, indigenous to the Americas[1] and part of the pantropical chinaberry family, Meliaceae
    case mahogany
    /// Hard wood with a tendency to slightly warp, even after having been processed professionally
    case heartwood_beech
    // :nodoc:
    case wild_oak
    /// Light colored, smooth-grained hardwood that grows throughout the east coast and parts of Canada
    case ash
    /// Characteristic light brown
    case heartwood_ash
    // :nodoc:
    case heartwood_walnut
    /// Reddish-brown wood and lumber from heartwood of the sweet gum tree
    case satin_walnut
    /// One of the most frequent visual defects of beech is red heart
    ///
    /// It is an abnormal formation, associated with the death of the living cells, and a discoloration of their contents (Panshin and DeZeuw 1980).
    case red_heart_beech
    // :nodoc:
    case structure_ash
    /// A product's component major material is not specified or the value is unknown
    case unknown
    /// Hide of a sheep, sometimes also called lambskin
    case sheepskin
    /// Metamorphic rock composed of recrystallized carbonate minerals, most commonly calcite or dolomite
    case marble
    
    public var localizedDescription: String {
        switch self {
        case .alcantara:
            return VSNLocalizedString("Alcantara", comment: "Product component's major material")
        case .aniline_leather:
            return VSNLocalizedString("Aniline Leather", comment: "Product component's major material")
        case .cotton:
            return VSNLocalizedString("Cotton", comment: "Product component's major material")
        case .boucle_robusta:
            return VSNLocalizedString("Bouclé Robusta", comment: "Product component's major material")
        case .brocade:
            return VSNLocalizedString("Brocade", comment: "Product component's major material")
        case .canvas:
            return VSNLocalizedString("Canvas", comment: "Product component's major material")
        case .chenille:
            return VSNLocalizedString("Chenille", comment: "Product component's major material")
        case .chintz:
            return VSNLocalizedString("Chintz", comment: "Product component's major material")
        case .corduroy:
            return VSNLocalizedString("Corduroy", comment: "Product component's major material")
        case .dralon:
            return VSNLocalizedString("Dralon", comment: "Product component's major material")
        case .drell:
            return VSNLocalizedString("Drell", comment: "Product component's major material")
        case .ecru:
            return VSNLocalizedString("Ecru", comment: "Product component's major material")
        case .epingle:
            return VSNLocalizedString("Epinglé", comment: "Product component's major material")
        case .flat_fabric:
            return VSNLocalizedString("Flat Fabric", comment: "Product component's major material")
        case .flat_knitted_fabric:
            return VSNLocalizedString("Flat Knitted Fabric", comment: "Product component's major material")
        case .flor:
            return VSNLocalizedString("Flor", comment: "Product component's major material")
        case .goblin:
            return VSNLocalizedString("Goblin", comment: "Product component's major material")
        case .jacquard:
            return VSNLocalizedString("Jacquard", comment: "Product component's major material")
        case .denim:
            return VSNLocalizedString("Denim", comment: "Product component's major material")
        case .freton:
            return VSNLocalizedString("Freton", comment: "Product component's major material")
        case .faux_leather:
            return VSNLocalizedString("Faux Leather", comment: "Product component's major material")
        case .nappa_leather:
            return VSNLocalizedString("Nappa Leather", comment: "Product component's major material")
        case .linen:
            return VSNLocalizedString("Linen", comment: "Product component's major material")
        case .microfiber:
            return VSNLocalizedString("Microfiber", comment: "Product component's major material")
        case .mohair:
            return VSNLocalizedString("Mohair", comment: "Product component's major material")
        case .moire:
            return VSNLocalizedString("Moiré", comment: "Product component's major material")
        case .nanova:
            return VSNLocalizedString("Nanova", comment: "Product component's major material")
        case .nylon:
            return VSNLocalizedString("Nylon", comment: "Product component's major material")
        case .oxford_fabric:
            return VSNLocalizedString("Oxford Fabric", comment: "Product component's major material")
        case .pique:
            return VSNLocalizedString("Piqué", comment: "Product component's major material")
        case .plush:
            return VSNLocalizedString("Plush", comment: "Product component's major material")
        case .polyester:
            return VSNLocalizedString("Polyester", comment: "Product component's major material")
        case .ripstop:
            return VSNLocalizedString("Ripstop", comment: "Product component's major material")
        case .velvet:
            return VSNLocalizedString("Velvet", comment: "Product component's major material")
        case .satin:
            return VSNLocalizedString("Satin", comment: "Product component's major material")
        case .silk:
            return VSNLocalizedString("Silk", comment: "Product component's major material")
        case .velour:
            return VSNLocalizedString("Velour", comment: "Product component's major material")
        case .suede_leather:
            return VSNLocalizedString("Suede Leather", comment: "Product component's major material")
        case .viscose:
            return VSNLocalizedString("Viscose", comment: "Product component's major material")
        case .knitted_velour:
            return VSNLocalizedString("Knitted Velour", comment: "Product component's major material")
        case .nubuck:
            return VSNLocalizedString("Nubuck", comment: "Product component's major material")
        case .buffalo_leather:
            return VSNLocalizedString("Buffalo Leather", comment: "Product component's major material")
        case .brushed_aluminum:
            return VSNLocalizedString("Brushed Aluminum", comment: "Product component's major material")
        case .polished_aluminum:
            return VSNLocalizedString("Polished Aluminum", comment: "Product component's major material")
        case .bronze:
            return VSNLocalizedString("Bronze", comment: "Product component's major material")
        case .chrome:
            return VSNLocalizedString("Chrome", comment: "Product component's major material")
        case .stainless_steel:
            return VSNLocalizedString("Stainless Steel", comment: "Product component's major material")
        case .iron:
            return VSNLocalizedString("Iron", comment: "Product component's major material")
        case .gold:
            return VSNLocalizedString("Gold", comment: "Product component's major material")
        case .copper:
            return VSNLocalizedString("Copper", comment: "Product component's major material")
        case .brass:
            return VSNLocalizedString("Brass", comment: "Product component's major material")
        case .nickel:
            return VSNLocalizedString("Nickel", comment: "Product component's major material")
        case .silver:
            return VSNLocalizedString("Silver", comment: "Product component's major material")
        case .oak:
            return VSNLocalizedString("Oak", comment: "Product component's major material")
        case .beech:
            return VSNLocalizedString("Beech", comment: "Product component's major material")
        case .european_walnut:
            return VSNLocalizedString("European Walnut", comment: "Product component's major material")
        case .maple:
            return VSNLocalizedString("Maple", comment: "Product component's major material")
        case .birch:
            return VSNLocalizedString("Birch", comment: "Product component's major material")
        case .pine:
            return VSNLocalizedString("Pine", comment: "Product component's major material")
        case .spruce:
            return VSNLocalizedString("Spruce", comment: "Product component's major material")
        case .alder:
            return VSNLocalizedString("Alder", comment: "Product component's major material")
        case .cherry_tree:
            return VSNLocalizedString("Cherry Tree", comment: "Product component's major material")
        case .larch:
            return VSNLocalizedString("Larch", comment: "Product component's major material")
        case .mahogany:
            return VSNLocalizedString("Mahogany", comment: "Product component's major material")
        case .heartwood_beech:
            return VSNLocalizedString("Heartwood Beech", comment: "Product component's major material")
        case .wild_oak:
            return VSNLocalizedString("Wild Oak", comment: "Product component's major material")
        case .ash:
            return VSNLocalizedString("Ash", comment: "Product component's major material")
        case .heartwood_ash:
            return VSNLocalizedString("Heartwood Ash", comment: "Product component's major material")
        case .heartwood_walnut:
            return VSNLocalizedString("Heartwood Walnut", comment: "Product component's major material")
        case .satin_walnut:
            return VSNLocalizedString("Satin Walnut", comment: "Product component's major material")
        case .red_heart_beech:
            return VSNLocalizedString("Red Heart Beech", comment: "Product component's major material")
        case .structure_ash:
            return VSNLocalizedString("Structure Ash", comment: "Product component's major material")
        case .sheepskin:
            return VSNLocalizedString("Sheepskin", comment: "Product component's major material")
        case .marble:
            return VSNLocalizedString("Marble", comment: "Product component's major material")
        case .unknown:
            fallthrough
        default:
            return VSNLocalizedString("Unknown", comment: "Default missing product component material index label")
        }
    }
}
