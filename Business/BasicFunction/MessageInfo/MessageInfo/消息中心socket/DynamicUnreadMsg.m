//
//  DynamicUnreadMsg.m
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DynamicUnreadMsg.h"
#import <TXImKit/TXImKit.h>

@implementation DynamicUnreadMsg

- (void)onUserVideoCommentCount:(ApiSendVideoUnReadNumberModel* )apiSendVideoUnReadNumber{
    if (self.noReadBlock) {
        self.noReadBlock(apiSendVideoUnReadNumber.number);
    }
}

@end
