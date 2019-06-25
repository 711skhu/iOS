//
//  Timetable.swift
//  Forest
//
//  Created by wookeon on 25/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Foundation

struct Timetable {
    var _time: String
    var _contents: String
    var _check: Bool
    var _possible: Bool
    
    init(time: String, contents: String, check: Bool, possible: Bool) {
        self._time = time
        self._contents = contents
        self._check = check
        self._possible = possible
    }
}
