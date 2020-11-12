//
//  ContentView.swift
//  SwiftUIRefactoring
//
//  Created by Alena Nesterkina on 11/12/20.
//

import SwiftUI
import UIKit

class SettingsViewHostingController: UIHostingController<ContentView> {
    override init(rootView: ContentView) {
        super.init(rootView: rootView)
        title = R.string.localizable.settings_screen()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ContentView: View {
    @State private var clearCache: Bool = false
    @State private var signOut: Bool = false
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                      .font: R.font.aliceRegular(size: 40)
        ]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            CustomHeader()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
            Button(action: {
                self.signOut = true
            }) {
                Text("Sign Out")
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.custom("Alice-Regular", size: 15))
                    .background(Color(R.color.table_cell.name))
                    .cornerRadius(8)
            }
            Button(action: {}) {
                Text("Clear Cache")
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.custom("Alice-Regular", size: 15))
                    .background(Color(R.color.table_cell.name))
                    .cornerRadius(8)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .padding(.top, 5)
        .background(Color(R.color.picotee_blue.name))
    }
}

struct CustomHeader: View {
    @State var phoneNumber = "+375298939122"
    var body: some View {
        VStack(spacing: 5) {
            Image("profile_icon")
                .resizable()
                .frame(width: 70, height: 70)
                .onTapGesture {
                    print("Change image")
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Text("\(phoneNumber)")
                .foregroundColor(.white)
                .font(Font.custom("Alice-Regular", size: 15))
            Spacer()
        }
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}
