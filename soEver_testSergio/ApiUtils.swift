//
//  ApiUtils.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 14/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

let CONSTANTES = Constantes()
var jsonDataGenerico : JSON?
var imagenSeleccionada : UIImage?
var diccionarioImagenes = [String : UIImage?]()

struct Constantes {
    let COLORES = Colores()
    let LLAMADAS = Llamadas()
    let ARGUMENTOS = Argumentos()
    let NSUSERDEFAULT = CustomUserDefault()
    let SALT = Salt()
}

struct Salt {
    let SALT = "PRUEBA1"//randomString(length: 200)
}

struct Colores {
    let COLOR_NAV_TAB = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    let COLOR_TEXT_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct Llamadas {
//    let BASE_URL_APPLE = "https://rss.itunes.apple.com/api/v1/%@/%@/%@/%@/%@/%@.json"
    let BASE_URL_APPLE_2018 = "https://rss.itunes.apple.com/api/v1/%@/%@/%@/all/%@/explicit.json"
    let BASE_URL_APPLE_2018_OBF: [UInt8] = [56, 38, 33, 53, 49, 123, 30, 127, 32, 38, 54, 108, 40, 69, 37, 60, 48, 54, 108, 32, 65, 32, 62, 48, 107, 33, 46, 92, 127, 51, 37, 44, 109, 55, 0, 127, 119, 21, 106, 103, 1, 30, 117, 18, 122, 36, 46, 45, 30, 117, 18, 122, 32, 58, 49, 93, 57, 49, 60, 49, 108, 43, 66, 63, 60]
}

struct Argumentos {
    let APPS_IOS_FIRST_PATH = "ios-apps"
    let APPS_IOS_SECOND_PATH = "new-apps-we-love"
    let BOOKS_FIRST_PATH = "books"
    let BOOKS_SECOND_PATH = "top-free"
    let MOVIES_FIRST_PATH = "movies"
    let MOVIES_SECOND_PATH = "top-movies"
    let VIDEOS_FIRST_PATH = "music-videos"
    let VIDEOS_SECOND_PATH = "top-music-videos"
}

struct CustomUserDefault {
    let USER_DEFAULT = UserDefaults.standard
    let KEY_DESCRIP_POST = "descripcion"
    let KEY_IMAGE_POST = "imagen"
}
