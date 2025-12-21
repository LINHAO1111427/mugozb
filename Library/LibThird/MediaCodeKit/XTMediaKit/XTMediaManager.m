//
//  XTMediaManager.m
//  XTMediaKit
//
//  Created by shirley on 2019/7/27.
//  Copyright © 2019 XTY. All rights reserved.
//

#import "XTMediaManager.h"


static Class<XTMediaConfig> _XTMediaConfig = nil;
static XTMediaManager *_mediaManager = nil;

@implementation XTMediaManager

+ (void)setConfig:(Class<XTMediaConfig>)config{
    _XTMediaConfig = config;
}

+ (instancetype)share{
    if (!_mediaManager) {
        _mediaManager = [[XTMediaManager alloc] init];
    }
    return _mediaManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = _XTMediaConfig;
    }
    return self;
}




@end
