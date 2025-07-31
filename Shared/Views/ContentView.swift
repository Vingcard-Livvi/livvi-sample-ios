//
//  ContentView.swift
//  SampleiOS (iOS)
//
//  Created by Vingcard on 31/07/2025.
//

import SwiftUI

struct ContentView: View
{
    @StateObject private var viewModel = ContentViewPresenter()

    var body: some View {
        NavigationView {
            if (viewModel.visibleDevices.count == 0) {
                HStack(alignment: .center) {
                    Text("No items to display").font(.system(size: 17)).bold()
                }
            } else {
                List(viewModel.visibleDevices) { device in
                    ReachableDeviceView(device: device,
                                        unlockAction: viewModel.unlockTapped(device:))
                }.overlay {
                    if viewModel.isUnlocking {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                            .overlay {
                                VStack(spacing: 20) {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(1.5)
                                    Text("Trying to Unlock Device, please wait.")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)
                                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                        .shadow(radius: 10)
                                )
                            }
                    }
                }.animation(.default, value: viewModel.isUnlocking)
                .navigationTitle("Visible Devices")
            }
        }.onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
