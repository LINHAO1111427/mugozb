//
//  ShortVideoUnreadMsg.m
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShortVideoUnreadMsg.h"

@implementation ShortVideoUnreadMsg

- (void)onUserShortVideoCommentCount:(ApiSendVideoUnReadNumberModel *)apiSendShortVideoUnReadNumber{
    if (self.noReadBlock) {
        self.noReadBlock(apiSendShortVideoUnReadNumber.number);
    }
}

@end
