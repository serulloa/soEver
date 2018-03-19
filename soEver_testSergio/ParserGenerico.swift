//
//  ParserGenerico.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 19/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit

class ParserGenerico: NSObject {
    func getDataFromParseUno() -> [GenericModel] {
        var arrayData = [GenericModel]()
        
        for c_data in jsonGenerico["feed"]["results"] {
            let model = GenericModel(pId: dime,
                                     pName: <#T##String#>,
                                     pArtworkUrl100: <#T##String#>,
                                     pKind: <#T##String#>,
                                     pArtistName: <#T##String#>,
                                     pReleaseDate: <#T##String#>,
                                     pUrl: <#T##String#>,
                                     pGenres: <#T##[Genres]#>)
            arrayData.append(model)
        }
        
        return arrayData
    }
}
