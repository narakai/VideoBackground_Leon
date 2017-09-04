//
//  ViewController.swift
//  VideoBackground_Leon
//
//  Created by lai leon on 2017/9/4.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

let YHRect = UIScreen.main.bounds
let YHHeight = YHRect.size.height
let YHWidth = YHRect.size.width

let loginBtnRect = CGRect(x: 30, y: YHHeight - 150, width: YHWidth - 60, height: 50)
let registerBtnRect = CGRect(x: 30, y: YHHeight - 75, width: YHWidth - 60, height: 50)


class ViewController: UIViewController {
    let playerVC: AVPlayerViewController = {
        let playerVC = AVPlayerViewController()
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        playerVC.player = AVPlayer(url: url)//指定播放源
        playerVC.showsPlaybackControls = false//是否显示工具栏
        playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill//视频画面适应方式
        playerVC.view.frame = YHRect
        playerVC.view.alpha = 0
        return playerVC
    }()

    let loginBtn: UIButton = {
        let loginBtn = UIButton(frame: loginBtnRect)
        loginBtn.customBtn(customTitle: "登录")
        loginBtn.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        return loginBtn
    }()

    let registerBtn: UIButton = {
        let registerBtn = UIButton(frame: registerBtnRect)
        registerBtn.customBtn(customTitle: "注册")
        registerBtn.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        return registerBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        setMoviePlayer()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(loginBtn)
        view.addSubview(registerBtn)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setMoviePlayer() {
        view.addSubview(playerVC.view)
        view.sendSubview(toBack: playerVC.view)
        UIView.animate(withDuration: 1, animations: {
            self.playerVC.view.alpha = 1
            self.playerVC.player?.play()
        })
        //监听视频播放完的状态
        NotificationCenter.default.addObserver(self, selector: #selector(repeatPlay),
                name: .AVPlayerItemDidPlayToEndTime, object: playerVC.player?.currentItem)
        //监听home暂停事件
        NotificationCenter.default.addObserver(self, selector: #selector(resumePlay),
                name: .UIApplicationWillEnterForeground, object: nil)
    }

    func buttonTap(_ sender: UIButton) {
        print("点击的按钮：" + sender.currentTitle!)
    }

    func repeatPlay() {
        playerVC.player?.seek(to: kCMTimeZero)
        playerVC.player?.play()
    }

    func resumePlay() {
        playerVC.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension ViewController: AVPlayerViewControllerDelegate {
//
//}
