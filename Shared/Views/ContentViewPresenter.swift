//
//  ContentViewPresenter.swift
//  SampleiOS (iOS)
//
//  Created by Vingcard on 31/07/2025.
//

import Foundation

@MainActor
class ContentViewPresenter: ObservableObject, LKScannerProtocol
{
    @Published var visibleDevices: [LKScanResult] = [LKScanResult]()
    @Published var isUnlocking: Bool = false

    private let _unlockDeviceInteractor = LKUnlockDeviceInteractor()
    private let _scanDevices = LKScanDevices.instance

    // MARK: - Private Door Properties
    var serialBase32: String = "LLKFAACAAAEAAU7E"
    var userKey: String = "350bWmkQSSWSadjvxf0orVlIIWqAEkHWE09kkYd3t3k="
    var lockData: String = " "
    var lockMac: String = " "

    func onAppear()
    {
        _scanDevices.subscribe(self)
    }

    func onDisappear()
    {
        _scanDevices.unsubscribe(self)
    }

    func setDevices(_ devices: [LKScanResult])
    {
        self.visibleDevices.removeAll()
        self.visibleDevices.append(contentsOf: devices)
    }

    func unlockTapped(device: LKScanResult)
    {
        guard device.lockMac == lockMac || device.serial?.serialBase32 == serialBase32 else {
            print("Device does not match the expected lockMac or serialBase32.")
            return
        }

        self.isUnlocking = true

        _unlockDeviceInteractor.unlock(serialBase32: serialBase32,
                                       lockMac: lockMac,
                                       userKey: userKey,
                                       lockData: lockData) { result in
            Task {
                self.isUnlocking = false
                switch result {
                case .failure(let error):
                    print("Error unlocking device: \(error)")
                case .success:
                    print("Door Opened")
                }
            }
        }
    }

    nonisolated func didUpdateVisible(_ devices: [LKScanResult])
    {
        Task {
            await self.setDevices(devices)
        }
    }
}
