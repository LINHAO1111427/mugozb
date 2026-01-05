//
//  VideoSession.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import "VideoSession.h"

@implementation VideoSession

- (void)dealloc
{
    [_hostingView removeFromSuperview];
    _hostingView = nil;
    _canvas = nil;
}


- (instancetype)initWithUid:(NSUInteger)uid AndHostingView:(UIView *)hostingView{
    if (self = [super init]) {
        self.uid = uid;
        self.hostingView = hostingView;
        self.hostingView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.canvas = [[ByteRTCVideoCanvas alloc] init];
        self.canvas.uid = [NSString stringWithFormat:@"%lu", (unsigned long)uid];
        self.canvas.view = self.hostingView;
        self.canvas.renderMode = ByteRTCRenderModeHidden;
    }
    return self;
}

@end
