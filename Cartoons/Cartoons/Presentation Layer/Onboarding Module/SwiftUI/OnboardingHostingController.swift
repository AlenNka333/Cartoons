//
//  OnboardingHostingController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/13/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SwiftUI
import UIKit

class OnboardingHostingController: UIHostingController<OnboardingView> {
    weak var transitionDelegate: OnboardingTransitionDelegate?
    var presenter: PagePresenterProtocol?
    
    init() {
        super.init(rootView: OnboardingView())
        rootView.transitionClosure = {
            self.transitionDelegate?.transit()
        }
        view.backgroundColor = R.color.picotee_blue()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingHostingController: PageViewControllerProtocol {
}

struct OnboardingView: View {
    let universalSize = UIScreen.main.bounds
    
    @State var isAnimated = false
    
    var transitionClosure: (() -> Void)?
    var subviews: [UIHostingController<Subview>]
    
    var captions =  [R.string.localizable.onBoarding_first_logo_key(), R.string.localizable.onBoarding_second_logo_key()]
    
    @State var currentPageIndex = 0
    
    init() {
        let firstPage = UIHostingController(rootView: Subview(imageString: R.image.onb_one.name))
        firstPage.view.backgroundColor = .clear
        let secondPage = UIHostingController(rootView: Subview(imageString: R.image.tv_model.name))
        secondPage.view.backgroundColor = .clear
        
        self.subviews = [firstPage, secondPage]
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            getSinWave(interval: universalSize.width, amplitude: 200, baseline: 150 + universalSize.height / 2)
                .foregroundColor(Color(R.color.main_orange.name).opacity(0.6))
                .offset(x: isAnimated ? -1 * universalSize.width : 0)
                .animation(
                    Animation.linear(duration: 2)
                        .repeatForever(autoreverses: false)
                )
            getSinWave(interval: universalSize.width * 1.2, amplitude: 150, baseline: 200 + universalSize.height / 2)
                .foregroundColor(Color(R.color.navigation_bar_color.name).opacity(0.6))
                .offset(x: isAnimated ? -1 * (universalSize.width * 1.2) : 0)
                .animation(
                    Animation.linear(duration: 5)
                        .repeatForever(autoreverses: false)
                )
            VStack(alignment: .leading, spacing: 20) {
                PageController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                Text(captions[currentPageIndex])
                    .font(Font.custom(R.font.aliceRegular.fontName, size: 20))
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50, alignment: .leading)
                    .lineLimit(nil)
                    .padding()
                HStack {
                    PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                        .frame(width: 100, height: 50, alignment: .leading)
                    Spacer()
                    Button(action: {
                        guard let closure = transitionClosure else {
                            return
                        }
                        closure()
                    }) {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(30)
                    }
                    .padding(.trailing)
                }
            }
            
        }.onAppear {
            self.isAnimated = true
        }
    }
    
    func getSinWave(interval: CGFloat,
                    amplitude: CGFloat = 100,
                    baseline: CGFloat = UIScreen.main.bounds.height / 2) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: baseline))
            path.addCurve(
                to: CGPoint(x: 1 * interval, y: baseline),
                control1: CGPoint(x: interval * (0.35), y: amplitude + baseline),
                control2: CGPoint(x: interval * (0.65), y: -amplitude + baseline)
            )
            path.addCurve(
                to: CGPoint(x: 2 * interval, y: baseline),
                control1: CGPoint(x: interval * (1.35), y: amplitude + baseline),
                control2: CGPoint(x: interval * (1.65), y: -amplitude + baseline)
            )
            path.addLine(to: CGPoint(x: 2 * interval, y: universalSize.height))
            path.addLine(to: CGPoint(x: 0, y: universalSize.height))
        }
    }
}

// MARK: - Preview

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
