//
//  WishShowFlowView.m
//  LiveCommon
//
//  Created by admin on 2020/1/15.
//  Copyright © 2020 . All rights reserved.
//

#import <LibProjView/WishShowFlowView.h>
#import <LibTools/LibTools.h>
#import <Masonry.h>
#import <SDWebImage.h>
#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <LibProjModel/HttpApiAnchorWishList.h>

@interface WishShowFlowView  ()<UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollV;
@property (nonatomic, copy)TimerBlock *timer;

@end

@implementation WishShowFlowView



- (void)dealloc
{
    [_timer stopTimer];
    _timer = nil;
}

+ (instancetype)register{
    return [[WishShowFlowView alloc] init];
}

- (void)setWishList:(NSArray<ApiUsersLiveWishModel *> *)wishList {
    _wishList = wishList;
    
    [_scrollV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [_timer stopTimer];
    _timer = nil;
    
    self.hidden = wishList.count>0?NO:YES;
    
    
    if (self.reloadDataBlock) {
        self.reloadDataBlock(wishList);
    }
    
    
    if (wishList.count == 0) {
        return;
    }
    
    if (wishList.count == 1) {
        self.scrollV.contentSize = CGSizeMake(0, self.frame.size.height);
        UIView *subV = [self createItemArr:wishList[0]];
        subV.frame = CGRectMake(0, 0 , _scrollV.frame.size.width, _scrollV.frame.size.height);
        [_scrollV addSubview:subV];
        
    }else{
        NSInteger itemNum = wishList.count+2;
        
        self.scrollV.contentSize = CGSizeMake(0, self.frame.size.height*itemNum);
        
        for (int i = 0; i < wishList.count; i++) {
            UIView *subV = [self createItemArr:wishList[i]];
            subV.frame = CGRectMake(0, _scrollV.frame.size.height * (i+1), _scrollV.frame.size.width, _scrollV.frame.size.height);
            [_scrollV addSubview:subV];
            
            if (i == 0) {
                UIView *subV1 = [self createItemArr:wishList[i]];
                subV1.frame = CGRectMake(0, _scrollV.contentSize.height-_scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height);
                [_scrollV addSubview:subV1];
            }
            if (i == wishList.count-1) {
                UIView *subV2 = [self createItemArr:wishList[i]];
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


- (UIView *)createItemArr:(ApiUsersLiveWishModel *)wishModel{
    
    UIView *itemView = [[UIView alloc] init];
    itemView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImgV = [[UIImageView alloc] init];
    bgImgV.contentMode = UIViewContentModeScaleAspectFit;
    [itemView addSubview:bgImgV];
    [bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(itemView);
    }];
    
    if (wishModel.sendNum == 0) {
        bgImgV.image = [UIImage imageNamed:@"wish_list_empty"];
    }else if (wishModel.sendNum >= wishModel.num){
        bgImgV.image = [UIImage imageNamed:@"wish_list_full"];
    }else{
        bgImgV.image = [UIImage imageNamed:@"wish_list_little"];
    }
    
    
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.masksToBounds = YES;
    [icon sd_setImageWithURL:[NSURL URLWithString:wishModel.gifticon]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [itemView addSubview:icon];
    
    UILabel *numLab = [[UILabel alloc] init];
    numLab.textColor = [UIColor whiteColor];
    numLab.font = [UIFont systemFontOfSize:12];
    numLab.textAlignment = NSTextAlignmentRight;
    numLab.text = [NSString stringWithFormat:@"%d/%d",wishModel.sendNum,wishModel.num];
    [itemView addSubview:numLab];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:12];
    nameLab.text = wishModel.giftname;
    [itemView addSubview:nameLab];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.centerY.equalTo(itemView);
        make.left.equalTo(itemView).mas_offset(2);
    }];
    
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(itemView).mas_offset(-3);
        make.left.equalTo(nameLab.mas_right).mas_offset(2);
        make.centerY.equalTo(itemView);
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(itemView);
        make.left.equalTo(icon.mas_right).mas_offset(2);
    }];

    [icon layoutIfNeeded];
    icon.layer.cornerRadius = icon.height/2.0;
    
    return itemView;
}


- (UIScrollView *)scrollV{
    if (_scrollV == nil) {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sss"]];
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

- (void)loadWishList:(int64_t)userId{
    kWeakSelf(self);
    [HttpApiAnchorWishList getWishList:userId callback:^(int code, NSString *strMsg, NSArray<ApiUsersLiveWishModel *> *arr) {
        if (code == 1 && arr.count>0) {
            weakself.wishList = arr;
        }
    }];
}
- (void)loadWishList:(int64_t)userId block:(void(^)(BOOL success))block{
    kWeakSelf(self);
    [HttpApiAnchorWishList getWishList:userId callback:^(int code, NSString *strMsg, NSArray<ApiUsersLiveWishModel *> *arr) {
        if (code == 1 && arr.count>0) {
            weakself.wishList = arr;
        }
         block(YES);
    }];
}

@end
