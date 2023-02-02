//
//  TweetViewController.swift
//  SwiftMVC
//
//  Created by JotaroSugiyama on 2023/02/02.
//

import UIKit

class TweetViewController: UIViewController {
    
    var myModel: TweetListModel? {
        // セットされるたびにdidSetが動作する
        didSet {
            // ViewとModelとを結合し、Modelの監視を開始する
            registerModel()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = TweetListView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myModel = TweetListModel()
        settingTableView()
    }
    
    private func settingTableView () {
        let tweetListView = self.view as! TweetListView
        tweetListView.tableView.delegate = self
        tweetListView.tableView.dataSource = self.myModel
        // TableViewに表示するCellを登録する
        tweetListView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func registerModel() {
        guard let model = myModel else { return }
        
        // 配列が変化したらnotificationCenterで通知を受け取る。
        model.notificationCenter.addObserver(forName: .init(rawValue: "changeTweetList"),
                                             object: nil,
                                             queue: nil,
                                             using: {
            [unowned self] notification in
            let tweetListView = self.view as! TweetListView
            
            tweetListView.tableView.reloadData()
        })
    }
    
    // TableViewのセルのタップを検知して、Modelの配列追加する処理を呼び出す。
    @objc func onTapTableViewCell() { myModel?.addTweetList() }
}

// TableViewを描画・処理する為に最低限必要なデリゲートメソッド、データソース
extension TweetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Modelでタップされた時の追加処理を行う。
        self.onTapTableViewCell()
    }
}
