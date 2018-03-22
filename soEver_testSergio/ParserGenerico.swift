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
    var json : String?
    
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
    
    func getDataFromWeb(_ completion : @escaping ([GenericModel]) -> ())  {
        let format = CONSTANTES.LLAMADAS.BASE_URL_APPLE_2018
        let arguments : [CVarArg] = ["es", CONSTANTES.ARGUMENTOS.MOVIES_FIRST_PATH, CONSTANTES.ARGUMENTOS.MOVIES_SECOND_PATH, "10"]
        let urlString = String(format: format, arguments: arguments)
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        
        Alamofire.request(urlRequest).responseArray(keyPath: "feed.results") {  (response: DataResponse<[GenericModel]>) in
            let projects = response.result.value
            completion(projects!)
        }
    }
}
