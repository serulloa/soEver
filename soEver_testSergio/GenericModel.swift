//
//  GenericModel.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 19/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import Foundation
import SwiftyJSON


struct GenericModel {
    var id : String?
    var name : String?
    var artworkUrl100 : String?
    var kind : String?
    var artistName : String?
    var releaseDate : String?
    var url : String?
    var genres : [Genres]?
    
    @available(*, deprecated)
    init(pId : String, pName : String, pArtworkUrl100 : String, pKind : String, pArtistName : String, pReleaseDate : String, pUrl : String, pGenres : [Genres]) {
        
        self.id = pId
        self.name = pName
        self.artworkUrl100 = pArtworkUrl100
        self.kind = pKind
        self.artistName = pArtistName
        self.releaseDate = pReleaseDate
        self.url = pUrl
        self.genres = pGenres
    }
    
    init(json : JSON) {
        self.id = dimeString(json, nombre: "id")
        self.name = dimeString(json, nombre: "name")
        self.artworkUrl100 = dimeString(json, nombre: "artworkUrl100").replacingOccurrences(of:"200x200", with:"600x600")
        self.kind = dimeString(json, nombre: "kind")
        self.artistName = dimeString(json, nombre: "artistName")
        self.releaseDate = dimeString(json, nombre: "releaseDate")
        self.url = dimeString(json, nombre: "url")
        self.genres = [Genres.init(json: json["genres"])]
    }
}

struct Genres {
    var name : String?
    var url : String?
    
    init(json : JSON) {
        name = dimeString(json, nombre: "name")
        self.url = dimeString(json, nombre: "url")
    }
}