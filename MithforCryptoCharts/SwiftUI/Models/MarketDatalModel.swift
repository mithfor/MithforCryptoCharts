//
//  MarketDataModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 19.11.2024.
//

import Foundation

// JSonData:
/*
 URL: https://pro-api.coingecko.com/api/v3/global
 
 JSONResponse:
 
 {
     "data": {
         "active_cryptocurrencies": 15408,
         "upcoming_icos": 0,
         "ongoing_icos": 49,
         "ended_icos": 3376,
         "markets": 1158,
         "total_market_cap": {
             "btc": 34917161.78377328,
             "eth": 1039333473.4224702,
             "ltc": 37306006581.66208,
             "bch": 7227465720.32919,
             "bnb": 5263667098.885415,
             "eos": 4983398906690.697,
             "xrp": 2950494384785.095,
             "xlm": 14161904994914.113,
             "link": 220348289324.0448,
             "dot": 558678325715.4515,
             "yfi": 513222338.5975077,
             "usd": 3254689444993.4897,
             "aed": 11954474331461.104,
             "ars": 3.260446990621685e+15,
             "aud": 4994434867473.077,
             "bdt": 388981123572802.3,
             "bhd": 1226728253401.941,
             "bmd": 3254689444993.4897,
             "brl": 18808440211747.297,
             "cad": 4550950883698.288,
             "chf": 2877090139653.6797,
             "clp": 3.16004307593308e+15,
             "cny": 23562324237030.355,
             "czk": 77872109751784.38,
             "dkk": 22963542746387.68,
             "eur": 3078688858566.024,
             "gbp": 2570137123406.898,
             "gel": 8885302184832.244,
             "hkd": 25332016057093.36,
             "huf": 1256204895148351.2,
             "idr": 5.161704304873797e+16,
             "ils": 12183083718077.44,
             "inr": 274672680862390.94,
             "jpy": 503748464476202.06,
             "krw": 4.539922192760683e+15,
             "kwd": 1000660779242.1373,
             "lkr": 947028333657161.9,
             "mmk": 6.828338455596342e+15,
             "mxn": 65630389548666.0,
             "myr": 14558225887455.867,
             "ngn": 5.466576391811077e+15,
             "nok": 35804415474745.555,
             "nzd": 5517701053613.014,
             "php": 191624726362848.75,
             "pkr": 904152727819193.2,
             "pln": 13346299961649.754,
             "rub": 327340508099040.1,
             "sar": 12218579361164.523,
             "sek": 35607565347733.305,
             "sgd": 4359347316071.518,
             "thb": 112413718740630.05,
             "try": 112298509243656.44,
             "twd": 105466580865602.25,
             "uah": 134381863540608.23,
             "vef": 325892054127.198,
             "vnd": 8.268538535005954e+16,
             "zar": 58813393685785.45,
             "xdr": 2475894335837.666,
             "xag": 104387068725.176,
             "xau": 1238181505.5588753,
             "bits": 34917161783773.28,
             "sats": 3.491716178377328e+15
         },
         "total_volume": {
             "btc": 2448598.7071023006,
             "eth": 72884234.26365301,
             "ltc": 2616118688.245123,
             "bch": 506832809.8376107,
             "bnb": 369119590.32527506,
             "eos": 349465520578.72406,
             "xrp": 206906185005.41446,
             "xlm": 993116865436.8505,
             "link": 15452130379.101921,
             "dot": 39177841386.54306,
             "yfi": 35990197.67207652,
             "usd": 228238148804.3544,
             "aed": 838318720558.3948,
             "ars": 228641902089589.44,
             "aud": 350239427675.48944,
             "bdt": 27277665984587.3,
             "bhd": 86025468903.998,
             "bmd": 228238148804.3544,
             "brl": 1318959503933.614,
             "cad": 319139697519.4098,
             "chf": 201758643494.51962,
             "clp": 221600983437123.84,
             "cny": 1652330078269.1228,
             "czk": 5460854706299.738,
             "dkk": 1610339964842.842,
             "eur": 215895942669.6103,
             "gbp": 180233275442.63208,
             "gel": 623090146235.8887,
             "hkd": 1776431376347.409,
             "huf": 88092546042653.64,
             "idr": 3.619693537987367e+15,
             "ils": 854350168130.4122,
             "inr": 19261679268230.992,
             "jpy": 35325833366972.57,
             "krw": 318366300227325.2,
             "kwd": 70172275326.1963,
             "lkr": 66411249795789.8,
             "mmk": 478843636191535.56,
             "mxn": 4602392599680.471,
             "myr": 1020909239601.8763,
             "ngn": 383348794731794.5,
             "nok": 2510818204037.36,
             "nzd": 386933959573.21185,
             "php": 13437863596317.729,
             "pkr": 63404557737849.78,
             "pln": 935921797798.6404,
             "rub": 22955060032571.293,
             "sar": 856839333381.2715,
             "sek": 2497013904321.3643,
             "sgd": 305703317699.29724,
             "thb": 7883117421553.591,
             "try": 7875038247562.232,
             "twd": 7395942864692.564,
             "uah": 9423654172156.86,
             "vef": 22853485839.78,
             "vnd": 5.798390170374619e+15,
             "zar": 4124344373437.5186,
             "xdr": 173624411605.85315,
             "xag": 7320241063.735268,
             "xau": 86828638.94964069,
             "bits": 2448598707102.301,
             "sats": 244859870710230.06
         },
         "market_cap_percentage": {
             "btc": 56.66142661456033,
             "eth": 11.585053640666647,
             "usdt": 3.9552464224535013,
             "sol": 3.554769243460773,
             "bnb": 2.7736036225777605,
             "xrp": 1.9283534695159965,
             "doge": 1.821875843019189,
             "usdc": 1.1507503701862054,
             "steth": 0.9410537510825233,
             "ada": 0.8075697933903179
         },
         "market_cap_change_percentage_24h_usd": -0.5748635941441188,
         "updated_at": 1732039959
     }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketDatalModel?
}

struct MarketDatalModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double?

    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" +  item.value.formatedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formatedWithAbbreviations()         }
        return ""
    }
    
    var bitcoinDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}

