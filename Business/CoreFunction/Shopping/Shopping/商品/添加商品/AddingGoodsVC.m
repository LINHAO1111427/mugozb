//
//  AddingGoodsVC.m
//  Shopping
//
//  Created by kalacheng on 2020/6/29.
//  Copyright © 2020 klc. All rights reserved.
//

#import "AddingGoodsVC.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "OtherChannelView.h"
#import "MyChannelView.h"
#import <LibProjView/ZGQActionSheetView.h>
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjModel/ShopGoodsChannelModel.h>
 

@interface AddingGoodsVC ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *channelL;

@property(nonatomic,strong)OtherChannelView *otherV;//三方商品
@property(nonatomic,strong)MyChannelView *myChannelV;//官方商品

@property(nonatomic,strong)UIButton *previewBtn;
@property(nonatomic,strong)UIButton *addBtn;

@property (nonatomic, copy)NSArray *channelList;

@end

@implementation AddingGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"添加商品");
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodsAttriAddSuccess:) name:@"goodsAttriAddSuccess" object:nil];
    [self creatSubView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}
- (void)tap{
    [self.view endEditing:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"goodsAttriAddSuccess" object:nil];
}
- (void)creatSubView{
    kWeakSelf(self);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 30)];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UILabel *channelNameL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, headerView.height)];
    channelNameL.text = kLocalizationMsg(@"商品渠道");
    channelNameL.textColor = kRGB_COLOR(@"#333333");
    channelNameL.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:channelNameL];
    
    UIView *channelbgV = [[UIView alloc] initWithFrame:CGRectMake(channelNameL.maxX, 0, 220, headerView.height)];
    channelbgV.layer.cornerRadius = 15;
    channelbgV.layer.masksToBounds = YES;
    channelbgV.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [headerView addSubview:channelbgV];
    [channelbgV klc_whenTapped:^{
        [weakself channelbgVTap];
    }];

    UILabel *channelL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    channelL.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    channelL.textColor = kRGB_COLOR(@"#9BA2AC");
    channelL.font = [UIFont systemFontOfSize:13];
    [channelbgV addSubview:channelL];
    self.channelL = channelL;
    
    UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(channelbgV.width - 30, 8, 14, 14)];
    iconImageV.image = [UIImage imageNamed:@"shop_xiajiantou"];
    [channelbgV addSubview:iconImageV];
    
    
    [self.view addSubview:self.otherV];
    [self.view addSubview:self.myChannelV];
    
    [self.view addSubview:self.previewBtn];
    [self.view addSubview:self.addBtn];
    
    if ([self.isModify boolValue]) {
        self.navigationItem.title = kLocalizationMsg(@"编辑商品");
        self.channelL.text = self.model.channelName;
        if (self.model.channelId == 1) {//官方
            self.otherV.hidden = YES;
            self.myChannelV.hidden = NO;
            self.myChannelV.isModify = YES;
            if (self.model.attrName.length > 0) {
                [self.myChannelV priceIsHidden:YES attrStr:self.model.attrName];
            }else{
                [self.myChannelV priceIsHidden:NO attrStr:@""];
            }
            self.myChannelV.model = self.model;
        }else{
            self.otherV.isModify = YES;
            self.otherV.hidden = NO;
            self.myChannelV.hidden = YES;
            self.otherV.model = self.model;
        }
    }else{
        [self getChannelList];
    }
}

- (void)getChannelList{
    kWeakSelf(self);
    [HttpApiShopGoods getChannelList:^(int code, NSString *strMsg, NSArray<ShopGoodsChannelModel *> *arr) {
        if (code == 1) {
            weakself.channelList = arr;
            ShopGoodsChannelModel *model = arr.firstObject;
            weakself.myChannelV.channelId = model.id_field;
            weakself.otherV.channelId = model.id_field;
            [weakself selectOneChannel:model.id_field channelName:model.goodsChannel];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_myChannelV keyboardNotification:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_myChannelV keyboardNotification:NO];
}


//选择渠道
-(void)channelbgVTap{
    if ([self.isModify boolValue]) {
        return;
    }
    [self showChannelList:self.channelList];
}

- (void)goodsAttriAddSuccess:(NSNotification *)notice{
    NSDictionary *dict = [notice object];
    int64_t goodsId = [dict[@"goodsId"] intValue];
    NSString *attribute1 = dict[@"attribute1"];
    NSString *attribute2 = dict[@"attribute2"];
     
    NSString *str;
    if (attribute2.length > 0) {
        str = [NSString stringWithFormat:@"%@x%@",attribute1,attribute2];
    }else{
        str = attribute1;
    }
    [self.myChannelV priceIsHidden:YES attrStr:str];
    self.myChannelV.goodsId = goodsId;
}

- (void)showChannelList:(NSArray<ShopGoodsChannelModel *> *)arr{
   // NSLog(@"过滤文字%s"),__func__);

    NSMutableArray *itemS = [[NSMutableArray alloc] initWithCapacity:1];
    for (ShopGoodsChannelModel *channelModel in arr) {
        [itemS addObject:channelModel.goodsChannel];
    }
    kWeakSelf(self);
    __block NSArray *itemArr = arr;
    ZGQActionSheetView *sheetView = [[ZGQActionSheetView alloc] initWithOptions:itemS completion:^(NSInteger index) {
        if (itemArr.count > index) {
            ShopGoodsChannelModel *channelModel = itemArr[index];
            [weakself selectOneChannel:channelModel.id_field channelName:channelModel.goodsChannel];
        }
    } cancel:^{
       // NSLog(@"过滤文字取消"));
    }];
    [sheetView show];
}


///选择某一个渠道
- (void)selectOneChannel:(int64_t)channelId channelName:(NSString *)channelName{
    self.channelL.text = channelName;
    if (channelId == 1) { ///官方店
        self.otherV.hidden = YES;
        self.myChannelV.hidden = NO;
        self.myChannelV.channelId = channelId;
    }else{  ///其他
        self.otherV.channelId = channelId;
        self.otherV.hidden = NO;
        self.myChannelV.hidden = YES;
    }
}


-(OtherChannelView *)otherV{
    if (!_otherV) {
        _otherV = [[OtherChannelView alloc] initWithFrame:CGRectMake(0, self.headerView.maxY + 10, kScreenWidth, kScreenHeight - kSafeAreaBottom-kNavBarHeight -60)];
        _otherV.hidden = YES;
        kWeakSelf(self);
        _otherV.addGoodsSuccess = ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        };
    }
    return _otherV;
    
}

-(MyChannelView *)myChannelV{
    if (!_myChannelV) {
        _myChannelV = [[MyChannelView alloc] initWithFrame:CGRectMake(0, self.headerView.maxY + 10, kScreenWidth, kScreenHeight -kSafeAreaBottom-kNavBarHeight -60)];
        _myChannelV.hidden = YES;
        kWeakSelf(self);
        _myChannelV.addGoodsSuccess = ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        };
    }
    return _myChannelV;
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
        return YES;
    }
}
@end
