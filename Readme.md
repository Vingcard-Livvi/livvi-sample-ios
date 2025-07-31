# Livvi Integration Sample Project

This project is a sample of how to integrate the Livvi BLE communication technology with your iOS project.

## Vingcard Livvi

Vingcard is the leading provider for access control systems for the hospitality industry. The Livvi system
is an access control system that specializes in the multifamily industry, providing hardware and software
for remotely-managed properties.

If you're interested in learning more, reach out to support.livvi@vingcard.com.

## Getting Started

This sample project depends on the Livvi frameworks, that are not present on this repository.
You will need to request access to the Livvi SDK and Frameworks by contacting support.livvi@vincard.com.

1. Add the Frameworks we provided and [TTLock framework](https://github.com/ttlock/iOS_SDK_Demo/tree/master/TTLockFrameworks)
under **/Frameworks** folder and make sure they show up in the project.
2. Make sure the frameworks are set to be copied to the target. You can do this by selecting the frameworks
in the Project Navigator, then checking the **Target Membership** in the File Inspector on the right side of Xcode;
3. Go to Build Settings, change from Basic to All and search for **Other Linker Flags** and add **-ObjC**,
which is necessary to load Objective-C Categories into Swift Code;
4. If you want a head start, copy all files under **SampleiOS > Shared > LKFiles**, into your project;

## Third-party devices

Since the Livvi platform also supports third-party devices such as TTLock, the example in this repository
contemplates controlling both Livvi and TTLock devices.

## Controling the Locks

1. In order to scan for devices, your class will need to implement the LKScannerProtocol and request for notifications
about reachable devices by providing a listener to the LKScanDevices instance.

```swift
class Example: LKScannerProtocol
{
    private var visibleDevices: [LKScanResult] = [LKScanResult]()
    private let _unlockDeviceInteractor = LKUnlockDeviceInteractor()
    private let _scanner = LKScanDevices.instance

    func onAppear()
    {
        _scanDevices.subscribe(self)
    }
}
```

4. Finally, you will need to implement the `func didUpdateVisible(_ devices: [LKScanResult])` method, which will run
every time a new device is detected or gets out of reach.
It receives an array of `LKScanResult` containing the visible devices at the scan time.

5. After you make sure your device is reachable, you may use commands.
You may check if a door is in the reachable devices by requesting to the scanner a visible device using the serial
or the lockMac:

```swift
    let device = _scanner.get(serialBase32: serialBase32, lockMac: lockMac)
```

7. To send an Unlock command to any lock you must have the fields: `lockData`, `lockMac`, `serial`, `userKey`.
Some of the fields could be null accordingly to the lock type. The field Serial may come as base64 and/or base32
encoding depending on how you fetch data from the API. **By default, the Scanner and Unlock classes uses the serial as Base32.**

8. To send a Unlock command to a locker you simple need to call the function on the UnlockInteractor Class.

```swift
_unlockDeviceInteractor.unlock(serialBase32: serialBase32,
                                       lockMac: lockMac,
                                       userKey: userKey,
                                       lockData: lockData) { result in
                switch result {
                case .failure(let error): break
                case .success(let device): print("Door Opened")
                }
        }
``` 

If the door is not in range, you will receive and error informing about it on the result callback.
All possible values of results can be found at LKUnlockDeviceInteractor.swift file.

### Retrieving data from server

Documentation on Livvi server APIs can be found at [https://docs.livvi.vingcard.com](https://docs.livvi.vingcard.com).

Interacting with the Livvi server API should be done as a cloud-to-cloud integration, and never directly from the
end-user device.

To retrieve door keys in order to issue commands to the locks, you should call the
[GET /corp/site/doors](https://docs.livvi.vingcard.com/api-documentation#tag/corporation-controller/get/corp/site/doors)
endpoint and use the `getDoorKeys` parameter as `true`.


## License

**This license is valid for the source-code in this sample repository only.
It does not apply to the Livvi BLE communication frameworks, which are proprietary.**

MIT License

Copyright (c) 2025 Vingcard

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions
of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
