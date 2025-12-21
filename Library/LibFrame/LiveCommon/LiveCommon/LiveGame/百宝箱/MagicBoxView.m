//
//  MagicBoxView.m
//  klcProject
//
//  Created by klc_sl on 2020/7/21.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MagicBoxView.h"
#import "GameRuleView.h"
#import "GameRecordView.h"
#import "GameMinePrizeView.h"

#import "GameLuckUserListView.h"

#import <LibProjView/PopView.h>
#import <LibProjView/PopTableListView.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

#import "GameNormalBoxView.h"


@interface MagicBoxView ()<UIScrollViewDelegate>

@property (nonatomic, weak)UILabel *titleL;

@property (nonatomic, weak)UIPageControl *pageC;
///中奖
@property (nonatomic, weak)GameLuckUserListView *luckListView;

@property (nonatomic, weak)GameNormalBoxView *goldBoxV;

@property (nonatomic, weak)GameNormalBoxView *luckyBoxV;


@end

@implementation MagicBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)dealloc
{
    [self stopGame];
}


///创建更多功能按钮
- (void)createFuncItem:(UIView *)superV{
    UIButton *moreBtn = [UIButton buttonWithType:0];
    [moreBtn setImage:[UIImage imageNamed:@"game_func_more"] forState:UIControlStateNormal];
    [moreBtn setContentEdgeInsets:UIEdgeInsetsMake(7, 14, 7, 0)];
    moreBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    moreBtn.frame = CGRectMake(self.width-15-7-30, 15, 30, 30);
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [superV addSubview:moreBtn];
}

- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    ///背景图
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(-5, -5, self.width+10, self.height+10)];
    bgImage.contentMode = UIViewContentModeScaleToFill;
    bgImage.image = [UIImage imageNamed:@"game_box_bg"];
    [self addSubview:bgImage];
    bgImage.alpha = 0.80;
    
    ///标题
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake((self.width-150)/2.0, 22, 150, 50)];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.numberOfLines = 0;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor whiteColor];
    [self addSubview:titleL];
    _titleL = titleL;
    
    ///功能按钮
    [self createFuncItem:self];
    
    ///最新10条奖项
    GameLuckUserListView *luckyListV = [[GameLuckUserListView alloc] initWithFrame:CGRectMake(12, 80, self.width-24, 30)];
    luckyListV.layer.masksToBounds = YES;
    luckyListV.layer.cornerRadius = 15.0;
    [self addSubview:luckyListV];
    _luckListView = luckyListV;
    [luckyListV loadData];
    
    ///百宝箱
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(luckyListV.x, luckyListV.maxY+10, luckyListV.width, self.height-kSafeAreaBottom-(luckyListV.maxY+10))];
    scrollV.contentSize = CGSizeMake(scrollV.width*2.0, 0);
    scrollV.pagingEnabled = YES;
    scrollV.delegate = self;
    scrollV.clipsToBounds = YES;
    scrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollV];
    [self insertSubview:scrollV aboveSubview:bgImage];

    ///宝箱信息
    kWeakSelf(self);
    GameNormalBoxView *goldBox = [[GameNormalBoxView alloc] initWithFrame:CGRectMake(0, 0, scrollV.width, scrollV.height) isLuckyBox:NO];
    goldBox.reloadPrizeList = ^{
        [weakself loadShowData];
    };
    [scrollV addSubview:goldBox];
    _goldBoxV = goldBox;
    
    GameNormalBoxView *luckyBox = [[GameNormalBoxView alloc] initWithFrame:CGRectMake(scrollV.width, 0, scrollV.width, scrollV.height) isLuckyBox:YES];
    luckyBox.reloadPrizeList = ^{
        [weakself loadShowData];
    };
    [scrollV addSubview:luckyBox];
    _luckyBoxV = luckyBox;
    
    ///设置默认标题
    [self showGameBoxTitle:YES];
    
    ///点点
    UIPageControl *page = [[UIPageControl alloc] init];
    page.currentPage = 0;
    page.numberOfPages = 2;
    page.currentPageIndicatorTintColor = kRGB_COLOR(@"#FF56E8");
    page.tintColor = [UIColor whiteColor];
    [self addSubview:page];
    [page setCurrentPage:0];
    _pageC = page;
    [page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.centerX.equalTo(luckyListV);
        make.bottom.equalTo(scrollV).mas_equalTo(-100);
        make.height.mas_equalTo(20);
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageC.currentPage = (scrollView.contentOffset.x>(scrollView.width/2.0))?1:0;
    [self showGameBoxTitle:_pageC.currentPage?NO:YES];
}

- (void)showGameBoxTitle:(BOOL)currentIsGold{
    if (currentIsGold) {
        _titleL.text = kLocalizationMsg(@"黄金宝箱");
        _titleL.font = [UIFont systemFontOfSize:20];
        _titleL.textColor = kRGB_COLOR(@"#FFD45E");
    }else{
        
        NSString *titleStr = kLocalizationMsg(@"幸运宝箱");
        _titleL.font = [UIFont systemFontOfSize:20];
        _titleL.textColor = [UIColor whiteColor];
        _titleL.text = titleStr;
        if (_luckyBoxV.luckyEndTime.length > 0 && _luckyBoxV.LuckyStartTime.length > 0) {
            _titleL.font = [UIFont systemFontOfSize:16];
            NSString *showStr = [titleStr stringByAppendingFormat:@"\n%@~%@",_luckyBoxV.LuckyStartTime, _luckyBoxV.luckyEndTime];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:showStr];
            [attr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange([titleStr length], showStr.length-titleStr.length)];
            _titleL.attributedText = attr;
        }
    }
}


///更多按钮
- (void)moreBtnClick:(UIButton *)btn{
    PopTableListView *listV = [[PopTableListView alloc] initWithTitles:@[kLocalizationMsg(@"黄金宝箱规则"),kLocalizationMsg(@"幸运宝箱规则"),kLocalizationMsg(@"抽奖记录"),kLocalizationMsg(@"我的奖品")] imgNames:nil];
    listV.width = 120;
    listV.backgroundColor = [UIColor whiteColor];
    listV.layer.masksToBounds = YES;
    listV.layer.cornerRadius = 4.0;
    listV.seleBlock = ^(int64_t seleIndex) {
        switch (seleIndex) {
            case 0:  ///黄金宝箱规则
            {
                [GameRuleView showRule:1 title:kLocalizationMsg(@"黄金宝箱规则")];
                
            }
                break;
            case 1:  ///幸运宝箱规则
            {
                [GameRuleView showRule:2 title:kLocalizationMsg(@"幸运宝箱规则")];
            }
                break;
            case 2:  ///抽奖记录
            {
                [GameRecordView showRecord];
            }
                break;
            case 3:  ///我的奖品
            {
                [GameMinePrizeView showMinePrize];
            }
                break;
            default:
            {
                
            }
                break;
        }
        [PopView hidenPopView];
    };
    
    [PopView popUpContentView:listV direct:PopViewDirection_PopUpBottom onView:btn offset:-33 triangleView:[UIView new] animation:YES];
    
}


- (void)resetGameInfo{
    [self.goldBoxV resetData];
    [self.luckyBoxV resetData];
}

- (void)loadShowData{
    [_luckListView loadData];
}

- (void)stopGame{
    [self resetGameInfo];
    [_luckListView timeStop];
}



+ (void)showMagicBox:(int64_t)uid{
    MagicBoxView *bgView = [[MagicBoxView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-kNavBarHeight-kTabBarHeight-5-25)];
    [bgView cornerRadii:CGSizeMake(8.0, 8.0) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    [[PopupTool share] createPopupViewWithLinkView:bgView allowTapOutside:YES popupBgViewAction:@selector(dismissView) popupBgViewTarget:bgView cover:NO];
    [[PopupTool share] animationShowPopupView:bgView];
}

- (void)dismissView{
    [self stopGame];
    [[PopupTool share] closePopupView:self animate:YES];
}


@end
