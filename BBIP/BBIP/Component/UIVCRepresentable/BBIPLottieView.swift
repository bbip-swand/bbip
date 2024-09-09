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
    private let withBackground: Bool
    private var completion: (() -> Void)?
    
    init(
        assetName: String,
        withBackground: Bool,
        loopMode: LottieLoopMode = .repeat(.infinity),
        completion: (() -> Void)? = nil
    ) {
        self.asset = assetName
        self.withBackground = withBackground
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
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = withBackground ? UIColor.gray10.withAlphaComponent(0.6) : .clear
        
        let containerView = UIView(frame: .zero)
        containerView.addSubview(backgroundView)
        containerView.addSubview(lottieView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            lottieView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            lottieView.widthAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        return containerView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
