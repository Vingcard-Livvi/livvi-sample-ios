//
//  LKCrypto.h
//  LKCrypto
//
//  Created by Daniel Sandoval on 02/08/17.
//  Copyright © 2017 Loop CE. All rights reserved.
//

#ifndef LKCrypto_h
#define LKCrypto_h

// In this header, you should import all the public headers of your framework using statements like #import <LKCrypto/PublicHeader.h>

#ifdef SPM
#import "../LKSpeckUtil.h"
#import "../LKCryptoMessages.h"
#else
#import <LKCrypto/LKSpeckUtil.h>
#import <LKCrypto/LKCryptoMessages.h>
#endif

#endif
