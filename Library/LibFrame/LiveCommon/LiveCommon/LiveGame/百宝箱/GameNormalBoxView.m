//
//  GameNormalBoxView.m
//  LiveCommon
//
//  Created by klc_sl on 2021/5/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "GameNormalBoxView.h"
#import "GamePrizeListView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import "GameLuckProgressView.h"
#import "GameMagicBoxView.h"
#import <LibProjModel/HttpApiGame.h>
#import <LibProjView/EmptyView.h>
#import <LibProjModel/GameAwardsAndPriceDTOModel.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/GamePriceModel.h>
#import <LibProjView/TipAlertView.h>
#import "GameResultView.h"

@interface GameNormalBoxView ()
///奖品列表
@property (nonatomic, weak)GamePrizeListView *prizeView;
///购买按钮
@property (nonatomic, weak)UIView *drawBgView;
///luck进度条
@property (nonatomic, weak)GameLuckProgressView *progressView;
///宝箱
@property (nonatomic, weak)GameMagicBoxView *gameBox;

@property (nonatomic, weak)EmptyView *emptyV;

@property (nonatomic, weak)UIView *contentBgView;

@property (nonatomic, weak)UILabel *contentL;  ///说明

@property (nonatomic, copy)NSArray<GamePriceModel*>* gamePriceList;

///是否为幸运宝箱
@property (nonatomic, assign)BOOL isLuckyBox;

@end

@implementation GameNormalBoxView

- (instancetype)initWithFrame:(CGRect)frame isLuckyBox:(BOOL)luckyBox
{
    self = [super initWithFrame:frame];
    if (self) {
        _isLuckyBox = luckyBox;
        [self createUI];
        [self getGameData];
    }
    return self;
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyV = [[EmptyView alloc] init];
        emptyV.frame = self.bounds;
        emptyV.backgroundColor = [UIColor clearColor];
        emptyV.iconImgV.image = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyV.titleL.text = kLocalizationMsg(@"网络飞走了～");
        emptyV.detailL.text = kLocalizationMsg(@"点我重新加载");
        emptyV.titleL.textColor = [UIColor whiteColor];
        emptyV.detailL.textColor = [UIColor lightTextColor];
        [self addSubview:emptyV];
        kWeakSelf(self);
        [emptyV clickHandle:^{
            [weakself getGameData];
        }];
        emptyV.hidden = YES;
        _emptyV = emptyV;
    }
    return _emptyV;
}

- (void)createUI{
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:bgView];
    _contentBgView = bgView;
    
    ///奖品列表
    GamePrizeListView *prizeListV = [[GamePrizeListView alloc] init];
    [bgView addSubview:prizeListV];
    _prizeView = prizeListV;
    [prizeListV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self);
        make.height.mas_equalTo(45);
    }];

    ///抽奖按钮背景
    UIView *draw = [[UIView alloc] init];
    [bgView addSubview:draw];
    _drawBgView = draw;
    [draw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(prizeListV);
        make.bottom.equalTo(self).offset(-20);
        make.height.mas_equalTo(70);
    }];
    
    ///规则说明
    UILabel *contentL = [[UILabel alloc] init];
    contentL.textColor = [UIColor lightGrayColor];
    contentL.font = [UIFont systemFontOfSize:10];
    contentL.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:contentL];
    _contentL = contentL;
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(draw.mas_bottom);
        make.centerX.equalTo(draw);
    }];
    
    ////如果为幸运宝箱，才有幸运进度条
    if (self.isLuckyBox) {
        ///进度条
        CGFloat progW = self.width*2.0/3.0+20;
        GameLuckProgressView *progress = [[GameLuckProgressView alloc] init];
        [bgView addSubview:progress];
        _progressView = progress;
        [progress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(progW);
            make.height.mas_equalTo(15);
            make.centerX.equalTo(self);
            make.bottom.equalTo(draw.mas_top).mas_equalTo(-35);
        }];
        [progress layoutIfNeeded];
    }

    ///宝箱
    GameMagicBoxView *gameBox = [[GameMagicBoxView alloc] initWithIsLuckyBox:_isLuckyBox];
    [bgView addSubview:gameBox];
    _gameBox = gameBox;
    [gameBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(prizeListV.mas_bottom).offset(10);
        make.bottom.equalTo(draw.mas_top).offset(-60);
        make.left.right.equalTo(bgView);
    }];
}

///显示抽奖按钮
- (void)showDrawView:(NSArray<GamePriceModel *> *)items{
    self.gamePriceList = items;
    [_drawBgView layoutIfNeeded];
    [_drawBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (items.count == 0) {
        ///没有数据时
        UIView *bgV = [[UIView alloc] initWithFrame:_drawBgView.bounds];
        [self addSubView:bgV tag:999 count:1 coin:100.000];
        [_drawBgView addSubview:bgV];
    }else{
        CGFloat itemW = _drawBgView.frame.size.width/(items.count*1.0);
        for (int i = 0; i < items.count; i++) {
            GamePriceModel *priceModel = items[i];
            UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(i*itemW, 0, itemW, _drawBgView.height)];
            [self addSubView:bgV tag:i count:priceModel.gameNum coin:priceModel.useCoin];
            [_drawBgView addSubview:bgV];
        }
    }
}

- (void)addSubView:(UIView *)superV tag:(int)tag count:(int)count coin:(double)coin{
    UIButton *btn = [UIButton buttonWithType:0];
    btn.tag = 33778+tag;
    btn.layer.masksToBounds = YES;
    [btn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"抽%d次"),count] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"banner_rechange_bg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(drawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [superV addSubview:btn];
    
    UILabel *coinL = [[UILabel alloc] init];
    coinL.font = [UIFont systemFontOfSize:12];
    coinL.textColor = [UIColor whiteColor];
    coinL.attributedText = [[NSString stringWithFormat:@"%.0lf",coin] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
    [superV addSubview:coinL];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superV).mas_offset(18);
        make.centerX.equalTo(superV);
        make.top.equalTo(superV);
        make.height.mas_equalTo(32);
        make.bottom.equalTo(coinL.mas_top).mas_offset(-7);
    }];
    
    [coinL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
    }];
    
    [btn layoutIfNeeded];
    btn.layer.cornerRadius = btn.height/2.0;
}


///游戏奖项
- (void)getGameData{
    kWeakSelf(self);
    [HttpApiGame getGamePriceAndAwardsList:_isLuckyBox?2:1 callback:^(int code, NSString *strMsg, GameAwardsAndPriceDTOModel *model) {
        if (code == 1) {
            [weakself showInfoData:model];
        }
        weakself.emptyV.titleL.text = strMsg;
        weakself.emptyV.hidden = (code == 1);
        weakself.contentBgView.hidden =!weakself.emptyV.hidden;
    }];
}


- (void)showInfoData:(GameAwardsAndPriceDTOModel *)dtoModel{
    self.prizeView.items = dtoModel.gameAwardsList;
    if (dtoModel.specialNote.length>0) {
        self.contentL.text = dtoModel.specialNote;
    }
    [self showDrawView:dtoModel.gamePriceList];
    [_progressView setTotalNum:dtoModel.luckyPrizeNum];
    [_progressView setLuckNum:dtoModel.userLuckyNum];
    [_gameBox closeBox];
}


///点击某一个Btn
- (void)drawBtnClick:(UIButton *)btn{
    
    NSInteger index = btn.tag-33778;
    if (self.gamePriceList.count > index) {
        GamePriceModel *price = self.gamePriceList[index];
        [self drawPrizeRequest:price];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"网络飞走了～")];
    }
}

///抽奖
- (void)drawPrizeRequest:(GamePriceModel *)priceModel{
    _drawBgView.userInteractionEnabled = NO;
    kWeakSelf(self);
    
    ///开始
    [self.gameBox shakeBox];
    [HttpApiGame starPlayGame:-1 gamePriceId:priceModel.id_field type:_isLuckyBox?2:1 callback:^(int code, NSString *strMsg, GameUserLuckDrawDTOModel *model) {
        weakself.drawBgView.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
        if (code == 1) {
            weakself.drawBgView.userInteractionEnabled = NO;
            [weakself.gameBox openBox:^{
                [weakself showDrawReault:model];
            }];
        }else if (code == -1){
            [weakself.gameBox closeBox];
            [TipAlertView showTitle:strMsg subTitle:^(UILabel * _Nonnull subTitleL) {
                subTitleL.text = kLocalizationMsg(@"先去充值吧!");
            } sureBtnTitle:kLocalizationMsg(@"立即充值") btnClick:^{
                [weakself gotoRechange];
            } cancel:nil];
        }else{
            [weakself.gameBox closeBox];
            [SVProgressHUD showInfoWithStatus:strMsg];
            [weakself resetData];
        }
    }];
}


- (void)showDrawReault:(GameUserLuckDrawDTOModel *)dtoModel{
    
    self.drawBgView.userInteractionEnabled = YES;
    
    [_progressView setLuckNum:dtoModel.userGameNum];
    
    NSArray *arr = dtoModel.gamePrizeRecordList;
    
    if (arr>0 && self.reloadPrizeList) {
        self.reloadPrizeList();
    }
    kWeakSelf(self);
    [GameResultView showResult:arr userLastCoin:dtoModel.coin closeBlock:^{
        [weakself resetData];
    }];
}


- (void)gotoRechange{
    [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
}

///重置
- (void)resetData{
    [self.gameBox closeBox];
}


@end
