//
//  GameLuckUserListView.m
//  LiveCommon
//
//  Created by admin on 2020/1/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "GameLuckUserListView.h"
#import <LibProjView/WishShowFlowView.h>
#import <LibTools/LibTools.h>
#import <Masonry.h>
#import <SDWebImage.h>
#import <LibProjModel/GameAwardsDTOModel.h>
#import <LibProjModel/HttpApiGame.h>
#import <LibProjModel/KLCAppConfig.h>

@interface GameLuckUserListView  ()<UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollV;
@property (nonatomic, copy)TimerBlock *timer;

@end

@implementation GameLuckUserListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBA_COLOR(@"#B9ABFF", 0.3);
    }
    return self;
}

- (void)dealloc
{
    [_timer stopTimer];
    _timer = nil;
}

///请求数据
- (void)loadData{
    kWeakSelf(self);
    [HttpApiGame getUserPrizeRecordList:-1 callback:^(int code, NSString *strMsg, NSArray<GameAwardsDTOModel *> *arr) {
        if (code == 1) {
            [weakself showData:arr];
        }else{}
    }];
}

- (void)timeStop{
    [_timer stopTimer];
    _timer = nil;
}

///根据数据开始滚动
- (void)showData:(NSArray<GameAwardsDTOModel *> *)arr{

    [_scrollV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [_timer stopTimer];
    _timer = nil;
    
    self.hidden = arr.count>0?NO:YES;
    
    if (arr.count == 0) {
        return;
    }
    
    if (arr.count == 1) {
        self.scrollV.contentSize = CGSizeMake(0, self.frame.size.height);
        UIView *subV = [self createItemArr:arr[0]];
        subV.frame = CGRectMake(0, 0 , _scrollV.frame.size.width, _scrollV.frame.size.height);
        [_scrollV addSubview:subV];
        
    }else{
        NSInteger itemNum = arr.count+2;
        
        self.scrollV.contentSize = CGSizeMake(0, self.frame.size.height*itemNum);
        
        for (int i = 0; i < arr.count; i++) {
            UIView *subV = [self createItemArr:arr[i]];
            subV.frame = CGRectMake(0, _scrollV.frame.size.height * (i+1), _scrollV.frame.size.width, _scrollV.frame.size.height);
            [_scrollV addSubview:subV];
            
            if (i == 0) {
                UIView *subV1 = [self createItemArr:arr[i]];
                subV1.frame = CGRectMake(0, _scrollV.contentSize.height-_scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height);
                [_scrollV addSubview:subV1];
            }
            if (i == arr.count-1) {
                UIView *subV2 = [self createItemArr:arr[i]];
                subV2.frame = CGRectMake(0, 0, _scrollV.frame.size.width, _scrollV.frame.size.height);
                [_scrollV addSubview:subV2];
            }
        }
        
        [self.scrollV setContentOffset:CGPointMake(0, self.scrollV.frame.size.height) animated:NO];
        kWeakSelf(self);
        [self.timer startTimerForIntervalTime:5.0 progress:^(CGFloat progress) {
            if (progress > 0) {
                [weakself.scrollV setContentOffset:CGPointMake(0, weakself.scrollV.contentOffset.y+ weakself.scrollV.frame.size.height) animated:YES];
            }
        }];
    }
}


- (TimerBlock *)timer{
    if (_timer == nil) {
        _timer = [[TimerBlock alloc] init];
    }
    return _timer;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    ///向上滚动
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height-2*scrollView.frame.size.height)) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    ///向下滚动
    //    if (scrollView.contentOffset.y <= 0) {
    //        [scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height-scrollView.frame.size.height) animated:NO];
    //    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


- (UIView *)createItemArr:(GameAwardsDTOModel *)luckUser{
    
    UIView *itemView = [[UIView alloc] init];
    itemView.backgroundColor = [UIColor clearColor];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.textColor =  kRGB_COLOR(@"#FFC904");
    nameLab.font = [UIFont systemFontOfSize:12];
    
    NSString *prizeName = luckUser.prizeName;
    NSString *pirzeNum = [NSString stringWithFormat:@"%d",luckUser.prizeNum];
    if (luckUser.prizeType == 0) {
        prizeName = [KLCAppConfig unitStr];
        pirzeNum = [NSString stringWithFormat:@"%0.0lf",luckUser.prizeNum];
    }


    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"恭喜 %@ 开出豪华大奖 %@"),luckUser.userName, prizeName];
    if (pirzeNum > 0) {
        showStr = [showStr stringByAppendingFormat:@"x%@",pirzeNum];
    }
    
    nameLab.text = showStr;
    [itemView addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(itemView);
    }];
    
    return itemView;
}


- (UIScrollView *)scrollV{
    if (_scrollV == nil) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = kRGBA_COLOR(@"#B9ABFF", 0.3);
        [self addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.userInteractionEnabled = NO;
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.backgroundColor = [UIColor clearColor];
        [imgV addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imgV);
        }];
        [imgV layoutIfNeeded];
        imgV.layer.cornerRadius = scrollView.height/2.0;
        _scrollV = scrollView;
    }
    return _scrollV;
}

@end
