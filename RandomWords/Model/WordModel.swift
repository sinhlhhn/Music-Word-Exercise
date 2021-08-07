//
//  WordModel.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 7/27/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
struct WordModel {
    var eng: String
    var vn: String
    var img: String
    var song: Song
    
    init () {
        eng = ""
        vn = ""
        img = ""
        song = Song()
    }
    
    init (eng:String, vn:String, img:String,song:Song) {
        self.eng = eng
        self.vn = vn
        self.img = img
        self.song = song
    }
    
    static func showObject() -> [WordModel]{
        var results = [WordModel]()
        let items = Word.showObject()
        for i in items {
            var item = WordModel()
            item.eng = i.eng ?? ""
            item.vn = i.vn ?? ""
            item.img = i.img ?? ""
            item.song = i.song ?? Song()
            results.append(item)
        }
        return results
    }
    static func findWord(song: SongModel) -> [WordModel] {
        var results = [WordModel]()
        let songNeedFind = Song.fetchSongWithSongName(key: song.name)
        let items = Word.fetchObjectWithSongName(key: songNeedFind[0])
        for i in items {
            var item = WordModel()
            item.eng = i.eng ?? ""
            item.vn = i.vn ?? ""
            item.img = i.img ?? ""
            item.song = i.song ?? Song()
            results.append(item)
        }
        return results
    }
}
