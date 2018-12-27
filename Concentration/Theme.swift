//
//  Theme.swift
//  Concentration
//
//  Created by class on 2018/12/25.
//  Copyright © 2018 study. All rights reserved.
//

import UIKit

class Theme{
    var emojis:[String]
    var cardBackColor:UIColor
    var backgroundColor:UIColor
    
   
    init(emojis:[String], cardBackColor:UIColor,  backgroundColor:UIColor ) {
        self.emojis = emojis
        self.cardBackColor  =  cardBackColor;
        self.backgroundColor = backgroundColor;
    }
    
}


