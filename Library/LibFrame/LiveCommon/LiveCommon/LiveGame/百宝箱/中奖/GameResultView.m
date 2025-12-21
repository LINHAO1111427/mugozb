//
//  GameResultView.m
//  klcProject
//
//  Created by klc_sl on 2020/7/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "GameResultView.h"
#import <LibProjBase/PopupTool.h>
#import "GameResultPrizeItemCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>

@interface GameResultView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy)NSArray *items;

@property (nonatomic, copy)void (^closeBlock)(void);

@end

@implementation GameResultView

+ (void)showResult:(NSArray *)items userLastCoin:(double)coin closeBlock:(void (^)(void))closeBlock {
    GameResultView *resultV = [[GameResultView alloc] init];
    resultV.items = items;
    resultV.closeBlock = closeBlock;
    [resultV createUI:coin];
    
}

- (void)dismissBtn{
    if (_closeBlock) {
        _closeBlock();
    }
    [[PopupTool share] closePopupView:self];
}

- (void)createUI:(double)coin{
    
    CGFloat viewH = 377;
    CGFloat viewW = 319;
    if (_items.count > 0) {
        viewH = 477;
    }
    viewH = 477;
    
    if (kScreenWidth <= 320) {
        CGFloat scale = viewW/viewH;
        viewW = kScreenWidth-30;
        viewH = viewW/scale;
    }
    
    self.frame = CGRectMake((kScreenWidth-viewW)/2.0, (kScreenHeight-viewH)/2.0, viewW, viewH);
    
    ///背景图
    UIImageView *imgBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, viewH-70)];
    imgBgV.image = [UIImage imageNamed:@"game_result_bg"];
    imgBgV.userInteractionEnabled = YES;
    [self addSubview:imgBgV];
    
    ///关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake((self.width-36)/2.0, self.height-36, 36, 36);
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"game_result_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismissBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    ///线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake((self.width-2)/2.0, self.height-closeBtn.height-50, 2, 50)];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    [self sendSubviewToBack:line];
    
    ///底图上的视图
    {
        ///继续抽奖
        UIButton *continueBtn = [UIButton buttonWithType:0];
        continueBtn.frame = CGRectMake((self.width-108)/2.0, imgBgV.height-55, 108, 34);
        [continueBtn setBackgroundImage:[UIImage imageNamed:@"game_result_btn"] forState:UIControlStateNormal];
        [continueBtn setTitle:_items.count>0?kLocalizationMsg(@"继续抽奖"):kLocalizationMsg(@"再抽一次") forState:UIControlStateNormal];
        [continueBtn setTitleColor:kRGB_COLOR(@"#D23362") forState:UIControlStateNormal];
        continueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [continueBtn addTarget:self action:@selector(dismissBtn) forControlEvents:UIControlEventTouchUpInside];
        [imgBgV addSubview:continueBtn];
        
        UILabel *lastCoinL = [[UILabel alloc] initWithFrame:CGRectMake(0, continueBtn.y-25, imgBgV.width, 10)];
        lastCoinL.text = [NSString stringWithFormat:kLocalizationMsg(@"账户余额：%0.0lf%@"),coin, kUnitStr];
        lastCoinL.font = [UIFont systemFontOfSize:10];
        lastCoinL.textColor = [UIColor whiteColor];
        lastCoinL.textAlignment = NSTextAlignmentCenter;
        [imgBgV addSubview:lastCoinL];
        
        ///中奖个数
        UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(0, lastCoinL.y-20, imgBgV.width, 15)];
        contentL.text = _items.count>0?[NSString stringWithFormat:kLocalizationMsg(@"共获得%zi个奖品"),_items.count]:kLocalizationMsg(@"差一点就抽到奖品了");
        contentL.font = [UIFont systemFontOfSize:14];
        contentL.textColor = [UIColor whiteColor];
        contentL.textAlignment = NSTextAlignmentCenter;
        [imgBgV addSubview:contentL];
        
        ///标题
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.width, 28)];
        titleL.text = _items.count>0?kLocalizationMsg(@"恭喜您，中奖啦"):kLocalizationMsg(@"再接再厉");
        titleL.font = [UIFont systemFontOfSize:27];
        [imgBgV addSubview:titleL];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:3.0/255.0 green:3.0/255.0 blue:3.0/255.0 alpha:0.19];
        shadow.shadowOffset = CGSizeMake(0,2);
        NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:titleL.text attributes: @{
            NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0],
            NSShadowAttributeName: shadow,
        }];
        titleL.attributedText = muStr;
        titleL.textAlignment = NSTextAlignmentCenter;
        
        ///黄色环
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((imgBgV.width-235)/2.0, titleL.maxY+15, 235, 34)];
        imgV.image = [UIImage imageNamed:@"game_result_line"];
        [imgBgV addSubview:imgV];
        
        ///列表
        CGFloat pointY = imgV.y+11;
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake((imgBgV.width-200)/2.0, pointY, 200, contentL.y-pointY-10)];
        bgV.backgroundColor = [UIColor whiteColor];
        [bgV cornerRadii:CGSizeMake(4.0, 4.0) byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)];
        [imgBgV addSubview:bgV];
        
        ///详情
        _items.count>0?[self showListView:bgV]:[self showFailView:bgV];
    }
    
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:YES popupBgViewAction:@selector(dismissBtn) popupBgViewTarget:self cover:YES];
    
}

- (void)showFailView:(UIView *)superV{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"game_result_fail"]];
    imgV.frame = CGRectMake((superV.width-145)/2.0, (superV.height-86)/2.0+15, 145, 86);
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [superV addSubview:imgV];
}

- (void)showListView:(UIView *)superV{
    UITableView *listV = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, superV.width-10, superV.height-10) style:UITableViewStylePlain];
    listV.dataSource = self;
    listV.delegate = self;
    listV.separatorStyle = UITableViewCellSeparatorStyleNone;
    listV.showsVerticalScrollIndicator = NO;
    [listV registerClass:[GameResultPrizeItemCell class] forCellReuseIdentifier:@"GameResultPrizeItemCellIdentifier"];
    [superV addSubview:listV];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GameResultPrizeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameResultPrizeItemCellIdentifier" forIndexPath:indexPath];
    cell.model = _items[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52.0;
}


@end
