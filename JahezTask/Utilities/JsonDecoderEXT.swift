//
//  JsonDecoderEXT.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Foundation

extension JSONDecoder {
    static var defaultDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
