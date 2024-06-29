//
//  PageModel.swift
//  PinchApp
//
//  Created by Ramachandran Varadaraju on 29/06/24.
//

import Foundation
import SwiftUI

struct Page: Identifiable{
    let id: Int
    let imageName: String
    
    var thumbnailName: String{
        return "thumb-\(imageName)" 
    }
}
