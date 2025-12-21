//
//  PLayGiftAnimationObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/31.
//  Copyright © 2020 . All rights reserved.
//

#import "PLayGiftAnimationObj.h"
#import "ShowAnimationPicView.h"
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjectCache.h>

@interface PLayGiftAnimationObj ()

@property (nonatomic, strong)NSMutableArray *giftItems;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)ShowAnimationPicView *giftView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation PLayGiftAnimationObj

- (void)dealloc
{
    _isAnimation = YES;
    [_giftItems removeAllObjects];
    _giftItems = nil;
    [_giftView removeFromSuperview];
}


- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}


- (void)playGiftAnimation:(ApiGiftSenderModel *)giftModel{
    if (giftModel.giftswf.length > 0) {
        [self.giftItems addObject:giftModel];
        [self playNextGift];
    }
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_giftItems.count > 0) {
        _isAnimation = YES;
        ApiGiftSenderModel *model = _giftItems.firstObject;
        [self playAnimationView:model];
        [_giftItems removeObjectAtIndex:0];
    }else{
        [self.giftView removeFromSuperview];
    }
    
}


- (void)playAnimationView:(ApiGiftSenderModel *)model{
    NSString *filePath = model.giftswf;
   // NSLog(@"过滤文字swf == %@ time =%.0f"),model.giftswf,model.swftime);
    kWeakSelf(self);
    [self.giftView playAnimationFilePath:filePath finishBlock:^{
        weakself.isAnimation = NO;
        [weakself playNextGift];
    }];
}


- (NSMutableArray *)giftItems{
    if (!_giftItems) {
        _giftItems = [[NSMutableArray alloc] init];
    }
    return _giftItems;
}

- (ShowAnimationPicView *)giftView{
    if (!_giftView) {
        ShowAnimationPicView *giftView = [[ShowAnimationPicView alloc] initWithFrame:self.superV.bounds];
        [self.superV addSubview:giftView];
        [self.superV sendSubviewToBack:giftView];
        _giftView = giftView;
    }
    return _giftView;
}


@end
