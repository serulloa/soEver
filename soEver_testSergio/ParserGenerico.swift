//
//  ParserGenerico.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 19/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class ParserGenerico: NSObject {
    
    static let shared = ParserGenerico()
    
    @available(*, deprecated)
    func getDataFromParseUno() -> [GenericModel] {
        var arrayData = [GenericModel]()

        for c_data in (jsonDataGenerico?["feed"]["results"].arrayValue)! {
            let model = GenericModel(pId: dimeString(c_data, nombre: "id"),
                                     pName: dimeString(c_data, nombre: "name"),
                                     pArtworkUrl100: dimeString(c_data, nombre: "artworkUrl100"),
                                     pKind: dimeString(c_data, nombre: "kind"),
                                     pArtistName: dimeString(c_data, nombre: "artistName"),
                                     pReleaseDate: dimeString(c_data, nombre: "releaseDate"),
                                     pUrl: dimeString(c_data, nombre: "url"),
                                     pGenres: getGenresFromParse(json: c_data))
            arrayData.append(model)
        }

        return arrayData
    }

    @available(*, deprecated)
    func getGenresFromParse(json: JSON) -> [Genres] {
        var arrayDataGenres = [Genres]()

        for g_data in (json["genres"].arrayValue){
            let genre = Genres(pName: dimeString(g_data, nombre: "name"),
                                pUrl: dimeString(g_data, nombre: "url"))

            arrayDataGenres.append(genre)
        }

        return arrayDataGenres
    }
    
    @available(*, deprecated)
    func getDataFromParseDos() -> [GenericModel] {
        var arrayData = [GenericModel]()
        
        for c_data in (jsonDataGenerico?["feed"]["results"].arrayValue)! {
            let model = GenericModel(json: c_data)
            arrayData.append(model)
        }
        
        return arrayData
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - country: <#country description#>
    ///   - firstPath: <#firstPath description#>
    ///   - secondPath: <#secondPath description#>
    ///   - nElements: <#nElements description#>
    ///   - completion: <#completion description#>
    @available(*, deprecated)
    func getDataFromWeb(_ country : String, firstPath : String, secondPath : String, nElements : String, completion : @escaping ([GenericModel]) -> ())  {
        let format = CONSTANTES.LLAMADAS.BASE_URL_APPLE_2018
        let arguments : [CVarArg] = [country, firstPath, secondPath, nElements]
        let urlString = String(format: format, arguments: arguments)
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        
        Alamofire.request(urlRequest).responseArray(keyPath: "feed.results") {  (response: DataResponse<[GenericModel]>) in
            let projects = response.result.value
            completion(projects!)
        }
    }
    
    /// Gets the multimedia data from the apple store obfuscated URL
    ///
    /// - Parameters:
    ///   - country: country to get the data from
    ///   - firstPath: name of the category
    ///   - secondPath: name of the sub-category
    ///   - nElements: number of elements to get
    ///   - completion: @escaping ([GenericModel]) -> ()
    func getDataFromWebObf(_ country: String, firstPath : String, secondPath : String, nElements : String, completion : @escaping ([GenericModel]) -> ())  {
        let args : [CVarArg] = [country, firstPath, secondPath, nElements]
        
        let urlRequest = URLRequest(url: URL(string: String(format: Obfuscator.decode(encripted: CONSTANTES.LLAMADAS.BASE_URL_APPLE_2018_OBF, salt: CONSTANTES.SALT.SALT), arguments: args))!)
        
        Alamofire.request(urlRequest).responseArray(keyPath: "feed.results") {  (response: DataResponse<[GenericModel]>) in
            let projects = response.result.value
            completion(projects!)
        }
    }
}
