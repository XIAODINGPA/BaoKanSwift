//
//  BKNewsListResponseModel.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/29.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKNewsListDataModel: NSObject {
    var befrom = ""
    var classid = ""
    var id = ""
    var morepic = ""
    var newstime = ""
    var onclik = ""
    var plnum = ""
    var title = ""
    var titlepic = ""
    var titleurl = ""
    
}

class BKNewsListResponseModel: NSObject {
    var err_msg: String? = ""
    var info: String? = ""
    var pageIndex: Int? = 1
    var pageSize: Int? = 1
    var total: Int! = 1
    var adverNewsList = ""
    var classid = ""
    var data = [BKNewsListDataModel]()
    
    
    
}
/*
 "err_msg" = success;
 info = "\U8bfb\U53d6\U4fe1\U606f\U5217\U8868\U6210\U529f\Uff01";
 pageIndex = 1;
 pageSize = 10;
 pageTotal = 1127;
 total = 11269;
 adverNewsList
 classid
 data =     (
 {
 befrom = "<null>";
 classid = 2;
 id = 71579;
 morepic =             (
 );
 newstime = 1559098371;
 onclick = 45044;
 plnum = 0;
 title = "\U767d\U9a6c\U835f\U7b2c\U5341\U4e8c\U671f\Uff1a\U5f53\U201c\U7f51\U6587\U65b0\U9510\U201d\U4eec\U9047\U4e0a\U5386\U53f2\U53e4\U57ce\U5170\U6eaa";
 titlepic = "http://www.baokan.tv/d/file/n/china/2019-05-29/febf02c523aae23924c8baa1f4c2a3e2.jpg";
 titleurl = "/n/china/20190529/71579.html";
 },
 
 );
 */
