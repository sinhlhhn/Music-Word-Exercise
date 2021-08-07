//
//  SongModel.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 7/23/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import Foundation

struct SongModel {
    var name: String
    
    init() {
        name = ""
    }
    init(name:String) {
        self.name = name
    }
    
   static func  showObject()-> [SongModel] {
        var results = [SongModel]()
        let items = Song.showObject()
        for i in items {
            var item = SongModel()
            item.name = i.name ?? ""
            results.append(item)
        }
        return results
    }
    
    static func  findSong(name: String)->[SongModel]{
        var results = [SongModel]()
        let items = Song.fetchSongWithSongName(key: name)
        for i in items {
            var item = SongModel()
            item.name = i.name ?? ""
            results.append(item)
        }
        return results
    }
}
