//
//  File.swift
//  soEver_testSergio
//
//  Created by Sergio Ulloa on 11/6/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import Foundation

class Obfuscator {
    
    static func encode(string: String, salt: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](salt.utf8)
        let length = cipher.count
        
        var encrypted = [UInt8]()
        
        for t in text.enumerated() {
            encrypted.append(t.element ^ cipher[t.offset % length])
        }
        
        return encrypted;
    }
    
    static func decode(encripted: [UInt8], salt: String) -> String {
        let cipher = [UInt8](salt.utf8)
        let length = cipher.count
        
        var decrypted = [UInt8]()
        
        for k in encripted.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        
        return String(bytes: decrypted, encoding: String.Encoding.utf8)!
    }
    
}
