//
//  TweetListModel.swift
//  SwiftMVC
//
//  Created by JotaroSugiyama on 2023/02/02.
//

import Foundation
import UIKit
 
// ツイート自体のデータモデルも作る
class TweetDataModel {
    let tweet: String
    
    init(initTweetText: String) {
        tweet = initTweetText
    }
}

class TweetListModel: NSObject,UITableViewDataSource {
    
    // Modelを監視するクラス
    let notificationCenter = NotificationCenter()
    
    // Modelで管理する配列に初期値を設定する。
    private(set) var tweetList: [TweetDataModel] = [
        TweetDataModel.init(initTweetText:"Tweet: 0番目"),
        TweetDataModel.init(initTweetText:"Tweet: 1番目"),
        TweetDataModel.init(initTweetText:"Tweet: 2番目")
    ] {
        didSet{
            // Modelで管理している配列に変化があった場合に呼び出されて、通知する。
            notificationCenter.post(name: .init(rawValue: "changeTweetList"), object: nil, userInfo: ["list" : tweetList])
        }
    }
    
    // 配列に新しいツイートを追加する。
    func addTweetList() {
        let tweetText = "Tweet: \(self.tweetList.count)番目"
        self.tweetList.append(TweetDataModel.init(initTweetText: tweetText))
    }
    
    
    // MARK: UITableViewDatasoruce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let tweetModel = self.tweetList[indexPath.row]
        cell.textLabel?.text = tweetModel.tweet
        return cell
    }
}
