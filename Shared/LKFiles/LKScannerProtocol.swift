//
//  LKScannerProtocol.swift
//  SampleiOS (iOS)
//
//  Created by Vingcard on 31/07/2025.
//

import Foundation

protocol LKScannerProtocol: AnyObject
{
    func didUpdateVisible(_ devices: [LKScanResult])
}
