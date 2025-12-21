//
//  MJChatHeader.m
//  Message
//
//  Created by klc_tqd on 2020/5/23.
//  Copyright © 2020 . All rights reserved.
//

#import "MJChatHeader.h"
#import <LibTools/LibTools.h>
@interface MJChatHeader ()
@property(nonatomic,weak)UIActivityIndicatorView *loading;
@end
@implementation MJChatHeader

#pragma mark - 覆盖父类的方法
- (void)prepare{
    [super prepare];
    
    self.mj_h = 60;
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.loading.frame = CGRectMake(kScreenWidth/2 -10, self.mj_h -22, 20, 20);
    self.loading.hidden = NO;
}

@end
