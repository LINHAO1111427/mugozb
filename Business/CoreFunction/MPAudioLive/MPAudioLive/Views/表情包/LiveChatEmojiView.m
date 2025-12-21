//
//  LiveChatEmojiView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/30.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveChatEmojiView.h"
#import <LiveCommon/LiveManager.h>
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <SDWebImage.h>

@interface LiveChatEmojiView ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scorllview;
@property (nonatomic,copy) NSArray *emojArray;
@property (weak, nonatomic) UIPageControl *pageControl;

@end

@implementation LiveChatEmojiView

+ (void)showEmoji{
    
    LiveChatEmojiView *emoji = [[LiveChatEmojiView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
    [emoji createUI];
}

- (void)createUI{
    
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    scrollV.backgroundColor = [UIColor whiteColor];
    scrollV.pagingEnabled = YES;
    scrollV.delegate = self;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollV];
    _scorllview = scrollV;
    //设置底部页数指示标志
    UIPageControl *pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 220, self.width, 20)];
    pageC.currentPageIndicatorTintColor = [UIColor blackColor];
    pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageC.userInteractionEnabled = YES;
    pageC.currentPage = 0;
    //添加点击事件
    [pageC addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageC];
    _pageControl = pageC;
    

    [FunctionSheetBaseView showView:self cover:NO];
    [self setUpView];
}


- (void)setUpView{
    kWeakSelf(self);
    [HttpApiHttpVoice getStrickerList:^(int code, NSString *strMsg, NSArray<AppStrickerModel *> *arr) {
        if (code == 1) {
            weakself.emojArray = arr;
            [weakself createItemView];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)createItemView{
    NSInteger num = 1;
    if (self.emojArray.count > 0) {
        num = (self.emojArray.count-1)/8+1;
    }
    self.pageControl.numberOfPages = num;
    self.scorllview.contentSize = CGSizeMake(self.width*num, 220);
    CGFloat space = (self.width-4*50)/8.0;
    for (int i = 0; i < num; i++) {
        UIView *bagV = [[UIView alloc]initWithFrame:CGRectMake(i*self.width, 0, self.width, 220)];
        bagV.backgroundColor = [UIColor clearColor];
        [self.scorllview addSubview:bagV];
        NSInteger maxNum = (i+1)*8;
        if (maxNum >self.emojArray.count) {
            maxNum = self.emojArray.count;
        }
        for (int t = i*8; t < maxNum; t++) {
            kWeakSelf(self);
            NSInteger row = (t-i*8)/4;
            NSInteger col = (t-i*8)%4;
            AppStrickerModel *strickerModel = self.emojArray[t];
            kWeakSelf(strickerModel);
            UIButton *emojBtn = [[UIButton alloc]initWithFrame:CGRectMake(space+col *(50+2*space), 30+100*row, 50, 50)];
            [emojBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:strickerModel.url] forState:UIControlStateNormal];
            [emojBtn klc_whenTapped:^{
                [weakself emojBtnClick:weakstrickerModel];
            }];
            [bagV addSubview:emojBtn];
            
            UILabel *titleLbel = [[UILabel alloc]initWithFrame:CGRectMake(space/2.0+col *(50+2*space), 85+100*row, 50+space, 20)];
            titleLbel.textColor = [UIColor blackColor];
            titleLbel.font = [UIFont systemFontOfSize:13];
            titleLbel.textAlignment = NSTextAlignmentCenter;
            titleLbel.text = strickerModel.name;
            [bagV addSubview:titleLbel];
        }
    }
}


- (void)emojBtnClick:(AppStrickerModel *)model{
    kWeakSelf(self);
    [HttpApiHttpVoice sendSticker:[LiveManager liveInfo].roomId strickerId:model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }else{
            [FunctionSheetBaseView deletePopView:weakself];
        }
    }];
}



//改变页码的方法实现
- (void)changePage:(id)sender{
    [self.scorllview setContentOffset:CGPointMake(self.pageControl.currentPage * self.scorllview.frame.size.width, 0) animated:YES];
}

#pragma mark -----UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage =   self.scorllview.contentOffset.x / self.scorllview.frame.size.width;
}




@end
