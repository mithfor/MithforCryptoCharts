//
//  FoundedIcon.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 08.10.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let foundedIcon = try? JSONDecoder().decode(FoundedIcon.self, from: jsonData)

import Foundation

// MARK: - FoundedIcon
struct FoundedIcon: Codable {
    let data: DataClass
    let errors: JSONNull?
    let meta: Meta
}

// MARK: - DataClass
struct DataClass: Codable {
    let success: Bool
    let objects: [Object]
}

// MARK: - Object
struct Object: Codable {
//    let publicID
    let name: String
    let createdTimestamp: Int
    let showNewBadge: Bool
//    let contentType: ObjectContentType
    let filesize, viewCount, downloadCount, animated: Int
    let color, demoted, emoji, flag: Int
    let icon, illustration, logo, solid: Int
    let whiteOnTransparent, displayShowContrast, synced: Int
//    let vectorSet: ObjectVectorSet
    let assets: [Asset]
    let path: String
    let url: String
    let markup: JSONNull?
    let bitmapsExported, useCleanBitmaps: Int
    let vectorSetSubsetVectors: JSONNull?
    let publicNotes: String

    enum CodingKeys: String, CodingKey {
//        case publicID
        case name, createdTimestamp, showNewBadge, /*contentType,*/ filesize, viewCount, downloadCount, animated, color, demoted, emoji, flag, icon, illustration, logo, solid, whiteOnTransparent, displayShowContrast, synced, /*vectorSet,*/ assets, path, url, markup, bitmapsExported, useCleanBitmaps, vectorSetSubsetVectors, publicNotes
    }
}

// MARK: - Asset
struct Asset: Codable {
//    let publicID: String
    let filesize: Int
    let contentType: AssetContentType
    let bitmap, vector, exported, cleaned: Int
    let size, width, height: Int
    let url: String?

    enum CodingKeys: String, CodingKey {
//        case publicID
        case filesize, contentType, bitmap, vector, exported, cleaned, size, width, height, url
    }
}

enum AssetContentType: String, Codable {
    case empty = ""
    case imagePNG = "image/png"
    case textXML = "text/xml"
}

enum ObjectContentType: String, Codable {
    case imageSVG = "image/svg"
    case imageSVGXML = "image/svg+xml"
}

// MARK: - ObjectVectorSet
struct ObjectVectorSet: Codable {
    let vectorSetDesigners: [VectorSetDesigner]
    let vectorSetSubsets: [VectorSetSubset]
    let publishedVectorCount, totalVectorCount: Int
    let license: License
    let description, publicID, name, slug: String
    let animated, color, solid, emoji: Int
    let flag, icon, illustration, logo: Int
    let published: Int
    let shortDescription, longDescription: String
    let websiteURL: String
    let customizationURL, repositoryURL: String
    let publicNotes: String

    enum CodingKeys: String, CodingKey {
        case vectorSetDesigners, vectorSetSubsets, publishedVectorCount, totalVectorCount, license, description
        case publicID
        case name, slug, animated, color, solid, emoji, flag, icon, illustration, logo, published, shortDescription, longDescription, websiteURL, customizationURL, repositoryURL, publicNotes
    }
}

// MARK: - License
struct License: Codable {
    let publicID: PublicID
    let shortName: ShortName
    let longName: LongName
    let officialURL: String
    let chooseALicenseURL: String
    let creativeCommonsURL: String
    let sitemapURL: String
    let customURL: String
    let slug: Slug
    let published, custom: Int
    let publicNotes: String

    enum CodingKeys: String, CodingKey {
        case publicID
        case shortName, longName, officialURL, chooseALicenseURL, creativeCommonsURL, sitemapURL, customURL, slug, published, custom, publicNotes
    }
}

enum LongName: String, Codable {
    case apacheLicense20 = "Apache License 2.0"
    case creativeCommonsAttribution40International = "Creative Commons Attribution 4.0 International"
    case creativeCommonsZeroV10Universal = "Creative Commons Zero v1.0 Universal"
    case custom = "Custom"
    case gnuGeneralPublicLicenseV30 = "GNU General Public License v3.0"
    case mitLicense = "MIT License"
    case silOpenFontLicense11 = "SIL Open Font License 1.1"
}

enum PublicID: String, Codable {
    case lcns0192Mkl3 = "lcns0192mkl3"
    case lcns3Tdx6Ons = "lcns3tdx6ons"
    case lcns4Rv5Iqwm = "lcns4rv5iqwm"
    case lcns7Zptpedq = "lcns7zptpedq"
    case lcnsban2M3K3 = "lcnsban2m3k3"
    case lcnsi1Zx4M88 = "lcnsi1zx4m88"
    case lcnskkx58Qpn = "lcnskkx58qpn"
    case lcnsp0Rto2Om = "lcnsp0rto2om"
}

enum ShortName: String, Codable {
    case apache20 = "Apache 2.0"
    case cc0 = "CC0"
    case ccBy40 = "CC BY 4.0"
    case custom = "Custom"
    case gplV3 = "GPL v3"
    case mit = "MIT"
    case ofl11 = "OFL 1.1"
}

enum Slug: String, Codable {
    case apache20 = "apache-2.0"
    case cc0 = "cc0"
    case ccBy40 = "cc-by-4.0"
    case customIconperk = "custom-iconperk"
    case customManypixels = "custom-manypixels"
    case gpl30 = "gpl-3.0"
    case mit = "mit"
    case ofl11 = "ofl-1.1"
}

// MARK: - VectorSetDesigner
struct VectorSetDesigner: Codable {
    let publicID: String
    let designer: Designer
    let vectorSet: VectorSetDesignerVectorSet

    enum CodingKeys: String, CodingKey {
        case publicID
        case designer, vectorSet
    }
}

// MARK: - Designer
struct Designer: Codable {
    let publicID, path, name, slug: String
    let shortDescription, longDescription: String
    let websiteURL: String
    let twitterUsername, gitHubUsername: String
    let dribbbleUsername: DribbbleUsername
    let behanceUsername: String
    let instagramUsername: InstagramUsername
    let figmaUsername: String
    let linkedInURL, facebookURL: String
    let youTubeURL: String
    let organization, published: Int
    let publicNotes: String

    enum CodingKeys: String, CodingKey {
        case publicID
        case path, name, slug, shortDescription, longDescription, websiteURL, twitterUsername, gitHubUsername, dribbbleUsername, behanceUsername, instagramUsername, figmaUsername, linkedInURL, facebookURL, youTubeURL, organization, published, publicNotes
    }
}

enum DribbbleUsername: String, Codable {
    case dariusdan = "dariusdan"
    case empty = ""
    case iconscout = "iconscout"
    case lukaszholeczek = "lukaszholeczek"
}

enum InstagramUsername: String, Codable {
    case empty = ""
    case mrholek = "mrholek"
}

// MARK: - VectorSetDesignerVectorSet
struct VectorSetDesignerVectorSet: Codable {
    let publicID: String

    enum CodingKeys: String, CodingKey {
        case publicID
    }
}

// MARK: - VectorSetSubset
struct VectorSetSubset: Codable {
    let publicID: String
    let publishedCount, totalCount: Int
    let subset: Subset
    let vectorSet: VectorSetDesignerVectorSet
    let list: Int

    enum CodingKeys: String, CodingKey {
        case publicID
        case publishedCount, totalCount, subset, vectorSet, list
    }
}

// MARK: - Subset
struct Subset: Codable {
    let publicID, label, slug, description: String
    let group: Group
    let publishedVectorCount: Int
    let publicNotes: String

    enum CodingKeys: String, CodingKey {
        case publicID
        case label, slug, description, group, publishedVectorCount, publicNotes
    }
}

enum Group: String, Codable {
    case category = "category"
    case color = "color"
    case style = "style"
    case type = "type"
}

// MARK: - Meta
struct Meta: Codable {
    let found: Int
    let more: Bool
    let suggestion: JSONNull?
    let timestamp: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
