//
//  LiveShoppingListShowView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveShoppingListShowView.h"
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import "LiveShppingItemsCell.h"
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjModel/ShopLiveGoodsModel.h>
#import <LibProjBase/LibProjBase.h>
#import "LiveShppingItemsCell.h"
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjView/EmptyView.h>

@interface LiveShoppingListShowView () <UITableViewDelegate,UITableViewDataSource,LiveShppingItemsCellDelegate>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, copy)NSArray *itemsArr;

@property (nonatomic, weak)UIImageView *logoImgV;

@property (nonatomic, weak)UIButton *shoppingNameBtn;

@property (nonatomic, weak)EmptyView *emptyV;

@property (nonatomic, assign)int64_t shoppingId;

@end

@implementation LiveShoppingListShowView


+ (void)showGoodsList{
    
    CGFloat viewH = kScreenHeight * 3/5.0;
    LiveShoppingListShowView *listShowV = [[LiveShoppingListShowView alloc] initWithFrame:CGRectMake(0, kScreenHeight-viewH, kScreenWidth, viewH)];
    [listShowV createUI];
    [FunctionSheetBaseView showView:listShowV cover:NO];
    
}

- (void)getLiveGoods{
    kWeakSelf(self);
    [HttpApiShopGoods getLiveGoods:[LiveManager liveInfo].anchorId callback:^(int code, NSString *strMsg, ShopLiveGoodsDTOModel *model) {
        if (code == 1) {
            weakself.shoppingId = model.businessId;
            [weakself.logoImgV sd_setImageWithURL:[NSURL URLWithString:model.businessLogo]];
            [weakself.shoppingNameBtn setTitle:model.businessName forState:UIControlStateNormal];
            weakself.itemsArr = model.liveGoodsList;
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)createUI{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    [self addSubview:headerV];
    
    ///图标
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 25, 25)];
    icon.centerY = headerV.height/2.0;
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = icon.height/2.0;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    [headerV addSubview:icon];
    _logoImgV = icon;
    
    ///商店名称
    UIButton *nameBtn = [UIButton buttonWithType:0];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headerV addSubview:nameBtn];
    [nameBtn addTarget:self action:@selector(clickShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _shoppingNameBtn = nameBtn;
    
    ///arrow箭头
    UIButton *arrowBtn = [UIButton buttonWithType:0];
    [arrowBtn setImage:[UIImage imageNamed:@"next_zhankai_gray"] forState:UIControlStateNormal];
    arrowBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [headerV addSubview:arrowBtn];
    
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).mas_offset(10);
        make.centerY.equalTo(icon);
        make.right.equalTo(arrowBtn.mas_left).inset(5);
    }];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(11, 11));
        make.centerY.equalTo(nameBtn);
    }];
    
    //左侧关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(kScreenWidth-headerV.height, 0, headerV.height, headerV.height);
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [closeBtn addTarget:self action:@selector(closetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:closeBtn];
    
    ///内容
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headerV.maxY, self.width, self.height-headerV.height) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.dataSource = self;
    tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableV registerClass:[LiveShppingItemsCell class] forCellReuseIdentifier:@"LiveShppingItemsCellIdentifer"];
    [self addSubview:tableV];
    _tableV = tableV;
    
    [self getLiveGoods];
}
- (void)closetBtnClick:(UIButton *)btn{
    [FunctionSheetBaseView deletePopView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveShppingItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveShppingItemsCellIdentifer" forIndexPath:indexPath];
    ShopLiveGoodsModel *goods = _itemsArr[indexPath.row];
    cell.goods = goods;
    cell.deleagte = self;
    kWeakSelf(goods);
    kWeakSelf(self);
    [cell klc_whenTapped:^{
        [LiveComponentMsgMgr sendMsg:LM_ShoppingGoodsDetail msgDic:@{@"goodId":@(weakgoods.goodsId)}];
        [FunctionSheetBaseView deletePopView:weakself];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ShopLiveGoodsModel *goodsModel = _itemsArr[indexPath.row];
//    [LiveComponentMsgMgr sendMsg:LM_ShoppingGoodsDetail msgDic:@{@"goodId":@(goodsModel.goodsId)}];
//     [[PopupTool share] closePopupView:self];
}

///查看商店名称
- (void)clickShopBtnClick:(UIButton *)btn{
    if (self.shoppingId) {
        [LiveComponentMsgMgr sendMsg:LM_StoreHomePage msgDic:@{@"businessId":@(self.shoppingId)}];
        [[PopupTool share] closePopupView:self];
    }
}

#pragma mark - LiveShppingItemsCellDelegate
- (void)LiveShppingItemsCellGotoBuy:(ShopLiveGoodsModel *)good{

    if (good.channelId == 1) {
        
        [LiveComponentMsgMgr sendMsg:LM_ShoppingGoodsDetail msgDic:@{@"goodId":@(good.goodsId)}];
        [[PopupTool share] closePopupView:self];

    }else{
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:good.productLinks]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:good.productLinks]];
        }
    }
}

@end
