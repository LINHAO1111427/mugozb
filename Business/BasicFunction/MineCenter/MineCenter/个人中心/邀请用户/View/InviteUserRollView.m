//
//  InviteUserRollView.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "InviteUserRollView.h"
#import "InviteRollTableView.h"
#import <LibProjModel/AppUserIncomeRankingDtoModel.h>
#import <LibProjView/NewPagedFlowView.h>

@interface InviteUserRollView ()<NewPagedFlowViewDataSource,NewPagedFlowViewDelegate>
///轮播
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;

@property (nonatomic, copy)NSArray *showInfoDataArr;

@end

@implementation InviteUserRollView

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setInviteArray:(NSArray *)inviteArray{
    _inviteArray = inviteArray;
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<inviteArray.count ; i+=2) {
        NSMutableArray *itemArr = [[NSMutableArray alloc] init];
        id item1 = inviteArray[i];
        item1?[itemArr addObject:item1]:nil;
        
        if (inviteArray.count > (i+1)) {
            id item2 = inviteArray[i+1];
            item2?[itemArr addObject:item2]:nil;
        }
        
        itemArr.count?[muArr addObject:itemArr]:nil;
    }
    
    _showInfoDataArr = muArr;
    [self.pageFlowView reloadData];
    [self startRoll];
}
 
- (void)startRoll{
    if (_showInfoDataArr.count) {
        [_pageFlowView startTimer];
    }
}

- (void)stoptRoll{
    [_pageFlowView stopTimer];
}

#pragma mark NewPagedFlowView Datasource

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return flowView.size;
}

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return _showInfoDataArr.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    InviteRollTableView *bannerView = (InviteRollTableView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[InviteRollTableView alloc] init];
    }
    [bannerView showInfoData:_showInfoDataArr[index]];
    return bannerView;
}


- (NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        _pageFlowView= [[NewPagedFlowView alloc] initWithFrame:self.bounds];
        _pageFlowView.orientation = NewPagedFlowViewOrientationVertical;
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.leftRightMargin = 0;
        _pageFlowView.topBottomMargin = 0;
        _pageFlowView.minimumPageAlpha = 0;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = 5;
        _pageFlowView.backgroundColor = [UIColor clearColor];
        [self addSubview:_pageFlowView];
    }
    return _pageFlowView;
}

@end
