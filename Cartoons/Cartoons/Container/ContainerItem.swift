//
//  ServiceContainerItem.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

public class ContainerItem {
    let content: Any
    let identifier: AnyHashable?
    
    init(content: Any, identifier: AnyHashable?) {
        self.content = content
        self.identifier = identifier
    }
}
