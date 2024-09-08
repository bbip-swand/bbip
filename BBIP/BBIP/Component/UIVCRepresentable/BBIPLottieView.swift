//
//  BBIPLottieView.swift
//  BBIP
//
//  Created by 이건우 on 9/8/24.
//

import UIKit
import SwiftUI
import Lottie

struct BBIPLottieView: UIViewRepresentable {
    private let asset: String
    private let loopMode: LottieLoopMode
    private var completion: (() -> Void)?
    
    init(
        assetName: String,
        loopMode: LottieLoopMode = .repeat(.infinity),
        completion: (() -> Void)? = nil
    ) {
        self.asset = assetName
        self.loopMode = loopMode
        self.completion = completion
    }
    
    func makeUIView(context: Context) -> UIView {
        let lottieView = LottieAnimationView(animation: .named(asset))
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.loopMode = loopMode
        lottieView.contentMode = .scaleAspectFit
        lottieView.play(completion: { finished in
            if finished {
                completion?()
            }
        })
        
        let containerView = UIView(frame: .zero)
        containerView.addSubview(lottieView)
        NSLayoutConstraint.activate([
            lottieView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            lottieView.widthAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        return containerView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
