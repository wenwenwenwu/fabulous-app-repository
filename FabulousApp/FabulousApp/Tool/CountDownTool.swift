//
//  CountDownTool.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/8/27.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

protocol CountDownToolDelegate: AnyObject {
    
    func countDownToolDidStart()
    func countDownToolDidStop()
    func countDownToolDidComplete()
    func countDownToolDidCountDown(remainSeconds: Int)
    
}

//预先实现这些协议方法是为了使协议方法可以选择实现
extension CountDownToolDelegate {
    
    func countDownToolDidStart() {}
    func countDownToolDidStop() {}
    func countDownToolDidComplete(){}
    func countDownToolDidCountDown(remainSeconds: Int) {}
    
}

enum CountDownStatus {
    case start
    case stop
    case complete
}

class CountDownTool {
    
    //MARK: - LifeCycle
    init(countDownSeconds: Int, enterBackgroundTimeCacheKey: CacheKey? = nil) {
        self.countDownSeconds = countDownSeconds
        self.enterBackgroundTimeCacheKey = enterBackgroundTimeCacheKey
    }
    
    //MARK: - Method
    func start() {
        countDownStatus = .start
    }
    
    func stop() {
        countDownStatus = .stop
    }
    
    func complete() {
        countDownStatus = .complete
    }
    
    func backgroundCountDown(){
        guard let enterBackgroundTimeCacheKey = enterBackgroundTimeCacheKey else { return }
        guard countDownStatus == .start else { return }
        let enterBackgroundTime = Date()
        CacheTool.save(value: enterBackgroundTime, forKey: enterBackgroundTimeCacheKey)
    }
    
    func syncBackgroundCountDownData(){
        guard let enterBackgroundTimeCacheKey = enterBackgroundTimeCacheKey else { return }
        guard let enterBackgroundTime = CacheTool.retrieve(valueType: Date.self, forKey: enterBackgroundTimeCacheKey) else { return }
        let different = Int(enterBackgroundTime.timeIntervalSince(Date())) //计算出上次与当前时间的间隔秒（负数）
        remainSeconds += different
        CacheTool.delete(forKey: enterBackgroundTimeCacheKey)
        
    }
    
    private func didSetIsCountDown(_ countDownStatus: CountDownStatus) {
        switch countDownStatus {
        case .start:
            remainSeconds = countDownSeconds
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
            timer?.schedule(deadline: .now(), repeating: 1)
            timer?.setEventHandler(handler: {
                DispatchQueue.main.async {
                    self.remainSeconds -= 1
                }
            })
            timer?.resume()
            delegate?.countDownToolDidStart()
        case .stop:
            timer?.cancel()
            delegate?.countDownToolDidStop()
        case .complete:
            timer?.cancel()
            delegate?.countDownToolDidComplete()
        }
    }
    
    private func willSetRemainSeconds(_ remainSeconds: Int) {
        if remainSeconds > 0 {
            delegate?.countDownToolDidCountDown(remainSeconds: remainSeconds)
        } else {
            complete()
        }
    }
    
    //MARK: - Component
    weak var delegate: CountDownToolDelegate?
    
    //MARK: - Data
    var countDownSeconds: Int
    
    var enterBackgroundTimeCacheKey: CacheKey?
    
    private var timer: DispatchSourceTimer?
    
    private var countDownStatus: CountDownStatus = .complete {
        didSet{
            didSetIsCountDown(countDownStatus)
        }
    }
    
    private var remainSeconds: Int = 0 {
        willSet {
            willSetRemainSeconds(newValue)
        }
    }
}
