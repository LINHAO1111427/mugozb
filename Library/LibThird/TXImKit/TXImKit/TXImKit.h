//
//  TXImKit.h
//  TXImKit
//
//  Created by SWH05 on 2022/4/27.
//

#import <Foundation/Foundation.h>
 
//! Project version number for TXImKit.
FOUNDATION_EXPORT double TXImKitVersionNumber;

//! Project version string for TXImKit.
FOUNDATION_EXPORT const unsigned char TXImKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TXImKit/PublicHeader.h>

#define kLocalizationMsg(key) NSLocalizedString(key, nil)

#import <TXImKit/ImConfig.h>
#import <TXImKit/IMReceiver.h>
#import <TXImKit/ImSdkHander.h>
#import <TXImKit/ImMsgHander.h>
#import <TXImKit/ImConversationHander.h>

#import <TXImKit/ImMessage.h>
#import <TXImKit/ImExtraInfo.h>
#import <TXImKit/IMSocketIns.h>
#import <TXImKit/ImSendResult.h>
