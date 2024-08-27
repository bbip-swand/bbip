//
//  GridButtonContent.swift
//  BBIP
//
//  Created by 이건우 on 8/27/24.
//

import Foundation

struct GridButtonContent {
    let imgName: String
    let text: String
    
    init(
        imgName: String,
        text: String
    ) {
        self.imgName = imgName
        self.text = text
    }
}

extension GridButtonContent {
    static func generateInterestContent() -> [GridButtonContent] {
        return [
            GridButtonContent(imgName: "mockImg", text: "전공과목"),
            GridButtonContent(imgName: "mockImg", text: "자기계발"),
            GridButtonContent(imgName: "mockImg", text: "어학(토익 등)"),
            GridButtonContent(imgName: "mockImg", text: "자격증"),
            GridButtonContent(imgName: "mockImg", text: "면접"),
            GridButtonContent(imgName: "mockImg", text: "개발"),
            GridButtonContent(imgName: "mockImg", text: "디자인"),
            GridButtonContent(imgName: "mockImg", text: "취미"),
            GridButtonContent(imgName: "mockImg", text: "기타")
        ]
    }
    
    static func generateJobContent() -> [GridButtonContent] {
        return [
            GridButtonContent(imgName: "mockImg", text: "대학생"),
            GridButtonContent(imgName: "mockImg", text: "취준생"),
            GridButtonContent(imgName: "mockImg", text: "직장인"),
            GridButtonContent(imgName: "mockImg", text: "기타")
        ]
    }
}
