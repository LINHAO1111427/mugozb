//
//  CoversationShopChatView.m
//  Message
//
//  Created by ssssssss on 2020/11/19.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShopChatMessageView.h"
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import "MessageContentObj.h"

@interface ShopChatMessageView()

@property (nonatomic, weak)UILabel *titleLab;//标题

@property (nonatomic, weak)UIImageView *commodityImageV;//商品图片
@property (nonatomic, weak)UILabel *commodityNameL;//商品名称
@property (nonatomic, weak)UILabel *commodityNumL;//商品个数
@property (nonatomic, weak)UILabel *commodityCostL;//商品金额
@property (nonatomic, weak)UIView *bottomView;

@property (nonatomic, assign)CGFloat bottomViewH;


@property(nonatomic,strong)ShopMessageModel *shopModel;


@end


@implementation ShopChatMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}


- (void)createUI{
    
    UIButton *bgControl = [UIButton buttonWithType:0];
    bgControl.layer.masksToBounds = YES;
    bgControl.layer.cornerRadius = 10;
    [bgControl addTarget:self action:@selector(commodityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgControl];
    [bgControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:15];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.textColor = kRGB_COLOR(@"#333333");
    [self addSubview:titleLab];
    self.titleLab = titleLab;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(10);
        make.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];

    UIView *commodityInfoView = [[UIView alloc] init];
    commodityInfoView.backgroundColor = kRGB_COLOR(@"#F7F7F7");
    commodityInfoView.layer.cornerRadius = 10;
    commodityInfoView.clipsToBounds = YES;
    commodityInfoView.userInteractionEnabled = NO;
    [self addSubview:commodityInfoView];
    [commodityInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(10);
        make.top.equalTo(titleLab.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    UIImageView *commodityImageV = [[UIImageView alloc] init];
    commodityImageV.contentMode = UIViewContentModeScaleAspectFill;
    commodityImageV.clipsToBounds = YES;
    commodityImageV.layer.cornerRadius = 10;
    [commodityInfoView addSubview:commodityImageV];
    self.commodityImageV = commodityImageV;
    [commodityImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.left.bottom.equalTo(commodityInfoView);
    }];
    
    UILabel *commodityNameL = [[UILabel alloc] init];
    commodityNameL.textAlignment = NSTextAlignmentLeft;
    commodityNameL.font = [UIFont systemFontOfSize:14];
    commodityNameL.textColor = kRGB_COLOR(@"#333333");
    [commodityInfoView addSubview:commodityNameL];
    self.commodityNameL = commodityNameL;
    [commodityNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commodityImageV.mas_right).inset(5);
        make.top.right.equalTo(commodityInfoView).inset(5);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *commodityCostL = [[UILabel alloc] init];
    commodityCostL.textAlignment = NSTextAlignmentRight;
    commodityCostL.font = [UIFont systemFontOfSize:12];
    [commodityCostL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    commodityCostL.textColor = kRGB_COLOR(@"#999999");
    [commodityInfoView addSubview:commodityCostL];
    self.commodityCostL = commodityCostL;
    [commodityCostL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commodityNameL.mas_bottom);
        make.right.bottom.equalTo(commodityInfoView).inset(5);
    }];
    
    UILabel *commodityNumL = [[UILabel alloc] init];
    commodityNumL.textAlignment = NSTextAlignmentLeft;
    commodityNumL.font = [UIFont systemFontOfSize:12];
    commodityNumL.textColor = kRGB_COLOR(@"#999999");
    [commodityInfoView addSubview:commodityNumL];
    self.commodityNumL = commodityNumL;
    [commodityNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commodityNameL);
        make.right.equalTo(commodityCostL.mas_left).inset(5);
        make.centerY.equalTo(commodityCostL);
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.userInteractionEnabled = NO;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(10);
        make.top.equalTo(commodityInfoView.mas_bottom);
    }];
}


- (void)showShopMessageInfo:(ShopMessageModel *)shopModel isOwner:(BOOL)isOwner {
    _shopModel = shopModel;

    self.commodityCostL.hidden = YES;
    switch (shopModel.orderStatus) {
        case 1: //待卖家发货
        case 2: //待买家收货
            self.commodityCostL.hidden = NO;
            break;
        case 3: //申请退款待审核
        case 4: //申请退款审核失败
        case 5: //待买家发货
        case 6: //待卖家收货
        case 7: //退款完成
        case 8://催单
        case 9://卖家确认收货
        default:
            break;
    }
    self.titleLab.text = self.shopModel.orderTitle;
    
    [self.commodityImageV sd_setImageWithURL:[NSURL URLWithString:shopModel.productImage] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    self.commodityNameL.text = shopModel.productName.length > 0?shopModel.productName:@"";
    self.commodityNumL.text = [NSString stringWithFormat:kLocalizationMsg(@"共%d件"),shopModel.productNum];
    self.commodityCostL.text = [NSString stringWithFormat:kLocalizationMsg(@"总金额:¥%.2f"),shopModel.totalAmout];

    [self updateBottmUI:YES isOwner:isOwner];
    
}

- (void)updateBottmUI:(BOOL)isShowUI isOwner:(BOOL)isOwner{

    NSString *title = @"";
    NSString *subText = @"";
    NSString *content = @"";
    NSString *tips = @"";
    NSString *images = @"";
    BOOL hasHandleBtn = NO;
    
    if (self.shopModel.orderStatus == 1) {//待卖家发货
        
        title = [NSString stringWithFormat:kLocalizationMsg(@"收货人：%@"),self.shopModel.name];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"电话：%@"),self.shopModel.phoneNum];
        content = [NSString stringWithFormat:kLocalizationMsg(@"地址：%@"),self.shopModel.address];
        
        if (!isOwner) {
            //提示
            tips = [NSString stringWithFormat:kLocalizationMsg(@"%@内未发货订单将自动取消"),self.shopModel.tips];
            hasHandleBtn = YES;
        }
        
    }else if(self.shopModel.orderStatus == 2){//待买家收货
        if (!isOwner) {
            hasHandleBtn = YES;
        }
    }else if(self.shopModel.orderStatus == 3){//申请退款待审核
        title = [NSString stringWithFormat:kLocalizationMsg(@"退款类型：%@"),self.shopModel.refundType == 1?kLocalizationMsg(@"仅退款"):kLocalizationMsg(@"退货退款")];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"退款金额：¥%.2f"),self.shopModel.totalAmout];
        content = self.shopModel.refundNotes;

        //图片
        if (self.shopModel.refundNotesImages.length > 0 && self.shopModel.refundType == 2) {
            images = self.shopModel.refundNotesImages;
        }
        //提示
        tips = [NSString stringWithFormat:kLocalizationMsg(@"%@未处理将自动同意退款申请"),self.shopModel.tips];
        if (!isOwner) {
            hasHandleBtn = YES;
        }
    }else if(self.shopModel.orderStatus == 4){//申请退款审核失败
        
        title = [NSString stringWithFormat:kLocalizationMsg(@"退款类型：%@"),self.shopModel.refundType == 1?kLocalizationMsg(@"仅退款"):kLocalizationMsg(@"退货退款")];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"退款金额：¥%.2f"),self.shopModel.totalAmout];
        content = self.shopModel.reason;

    }else if(self.shopModel.orderStatus == 5){//待买家发货
        title = [NSString stringWithFormat:kLocalizationMsg(@"退款类型：%@"),self.shopModel.refundType == 1?kLocalizationMsg(@"仅退款"):kLocalizationMsg(@"退货退款")];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"退款金额：¥%.2f"),self.shopModel.totalAmout];
                
        //提示
        if (self.shopModel.refundType == 1) {
//            tips = [NSString stringWithFormat:kLocalizationMsg(@"您的退款将于%@内退回付款账户"),self.shopModel.tips];
        }else{
            tips = [NSString stringWithFormat:kLocalizationMsg(@"请您于%@内将货物退回并填写物流单号，超时订单自动取消退款"),self.shopModel.tips];
        }

        if (!isOwner && self.shopModel.refundType == 2) {
            hasHandleBtn = YES;
        }
    }else if(self.shopModel.orderStatus == 6){//待卖家收货
        title = [NSString stringWithFormat:kLocalizationMsg(@"退款类型：%@"),self.shopModel.refundType == 1?kLocalizationMsg(@"仅退款"):kLocalizationMsg(@"退货退款")];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"退款金额：¥%.2f"),self.shopModel.totalAmout];
        content = self.shopModel.refundNotes;
        
        //提示
        tips =[NSString stringWithFormat:kLocalizationMsg(@"货物已发出，%@内未处理将自动退款"),self.shopModel.tips];
        
        if (!isOwner && self.shopModel.refundType == 2) {
            hasHandleBtn = YES;
        }
    }else if(self.shopModel.orderStatus == 7){//退款完成
        
        title = [NSString stringWithFormat:kLocalizationMsg(@"退款类型：%@"),self.shopModel.refundType == 1?kLocalizationMsg(@"仅退款"):kLocalizationMsg(@"退货退款")];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"退款金额：¥%.2f"),self.shopModel.totalAmout];
        content = [NSString stringWithFormat:kLocalizationMsg(@"到账时间：%@"),self.shopModel.refundTime];
        
    }else if (self.shopModel.orderStatus == 8) {//提醒发货
        
        title = [NSString stringWithFormat:kLocalizationMsg(@"收货人：%@"),self.shopModel.name];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"电话：%@"),self.shopModel.phoneNum];
        content = [NSString stringWithFormat:kLocalizationMsg(@"地址：%@"),self.shopModel.address];
        
        if (!isOwner) {
            //提示
            tips = [NSString stringWithFormat:kLocalizationMsg(@"%@内未发货订单将自动取消"),self.shopModel.tips];
            hasHandleBtn = YES;
        }
    }else if(self.shopModel.orderStatus == 9){//卖家同意收获
        
        title = [NSString stringWithFormat:kLocalizationMsg(@"退款类型：%@"),self.shopModel.refundType == 1?kLocalizationMsg(@"仅退款"):kLocalizationMsg(@"退货退款")];
        subText = [NSString stringWithFormat:kLocalizationMsg(@"退款金额：¥%.2f"),self.shopModel.totalAmout];
            
        if (!isOwner && self.shopModel.refundType == 2) {
            hasHandleBtn = YES;
        }
        
    }
    
    if (isShowUI) {
        ///显示
        [self contentBgV:title subText:subText content:content showImages:images tipStr:tips hasBottomView:hasHandleBtn];
    }else{
        ///计算高度
        [self heightForBgView:title subText:subText content:content showImages:images tipStr:tips hasBottomView:hasHandleBtn];
    }
}

- (void)commodityBtnClick{
   // NSLog(@"过滤文字订单详情"));
    if (self.delegate && [self.delegate respondsToSelector:@selector(commodityDetailInfo:)]) {
        [self.delegate commodityDetailInfo:self.shopModel];
    }
}
- (void)doWith:(UIButton *)btn{
   // NSLog(@"过滤文字去处理"));
}



/// 创建UI
/// @param title 主标题内容
/// @param subText 副文本
/// @param content 详细内容
/// @param tipStr 提示文字
- (void)contentBgV:(NSString *)title subText:(NSString *)subText content:(NSString *)content showImages:(NSString *)images tipStr:(NSString *)tipStr hasBottomView:(BOOL)has{

    [self.bottomView removeAllSubViews];
    [self.bottomView layoutSubviews];
    
    self.bottomViewH = 1;
    
    ///内容背景view
    UIView *lineV = [[UIView alloc] init];
    [self.bottomView addSubview:lineV];

    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bottomView);
        make.height.mas_equalTo(0.01);
    }];
    
    UIView *topView = lineV;
    UIView *bottomV = nil;
    if (title.length > 0) {
        UILabel *titleL = [[UILabel alloc]init];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.font = [UIFont systemFontOfSize:13];
        titleL.textColor = kRGB_COLOR(@"#666666");
        titleL.text = title;
        [self.bottomView addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).inset(10);
            
//            make.left.right.equalTo(self.bottomView);
            make.left.equalTo(self.bottomView);
            make.width.mas_equalTo(self.width-20);
        }];
        
        topView = titleL;
        bottomV = titleL;
    }
    if (subText.length > 0) {
        UILabel *subTextL = [[UILabel alloc]init];
        subTextL.textAlignment = NSTextAlignmentLeft;
        subTextL.font = [UIFont systemFontOfSize:13];
        subTextL.textColor = kRGB_COLOR(@"#666666");
        subTextL.text = subText;
        [self.bottomView addSubview:subTextL];
        [subTextL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).inset(10);

//            make.left.right.equalTo(self.bottomView);
            make.left.equalTo(self.bottomView);
            make.width.mas_equalTo(self.width-20);
        }];
        topView = subTextL;
        bottomV = subTextL;
    }
    if (content.length > 0) {
        UILabel *contentL = [[UILabel alloc] init];
        contentL.textAlignment = NSTextAlignmentLeft;
        contentL.font = [UIFont systemFontOfSize:13];
        contentL.textColor = kRGB_COLOR(@"#666666");
        contentL.numberOfLines = 0;
        contentL.text = content;
        [self.bottomView addSubview:contentL];
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).inset(10);

//            make.left.right.equalTo(self.bottomView);
            make.left.equalTo(self.bottomView);
            make.width.mas_equalTo(self.width-20);
        }];
        topView = contentL;
        bottomV = contentL;
        
        [contentL layoutSubviews];
        self.bottomViewH += (10+contentL.height);
    }
    
    if (images.length > 0) {
        UIView *imgBgV = [[UIView alloc] init];
        [self.bottomView addSubview:imgBgV];
        [imgBgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).inset(10);
            make.height.mas_equalTo(50);
            
//            make.left.right.equalTo(self.bottomView);
            make.left.equalTo(self.bottomView);
            make.width.mas_equalTo(self.width-20);
        }];

        NSArray *imageArr = [self.shopModel.refundNotesImages componentsSeparatedByString:@","];
        NSInteger num = MIN(imageArr.count, 3);
        for (int i = 0; i < num; i++) {
            NSString *url = imageArr[i];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(60*i, 0, 50, 50)];
            imageV.contentMode = UIViewContentModeScaleAspectFill;
            imageV.layer.cornerRadius = 6;
            imageV.clipsToBounds = YES;
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            [imgBgV addSubview:imageV];
        }
        topView = imgBgV;
        bottomV = imgBgV;
    }
    
    if (tipStr.length > 0) {
        UILabel *tipL = [[UILabel alloc] init];
        tipL.textColor = kRGB_COLOR(@"#FC8F3A");
        tipL.font = [UIFont boldSystemFontOfSize:13];
        tipL.numberOfLines = 0;
        tipL.textAlignment = NSTextAlignmentLeft;
        tipL.text = tipStr;
        [self.bottomView addSubview:tipL];
        [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).inset(10);
            
//            make.left.right.equalTo(self.bottomView);
            make.left.equalTo(self.bottomView);
            make.width.mas_equalTo(self.width-20);
        }];
        
        topView = tipL;
        bottomV = tipL;
    }
    
    if (has) {
        UIButton *btn = [UIButton buttonWithType:0];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 15;
        btn.layer.borderColor = kRGB_COLOR(@"#666666").CGColor;
        btn.layer.borderWidth = 0.5;
        btn.clipsToBounds = YES;
        [btn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
        [btn setTitle:kLocalizationMsg(@"去处理") forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(doWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.right.equalTo(self.bottomView);
            make.top.equalTo(topView.mas_bottom).inset(15);
        }];
        
        topView = btn;
        bottomV = btn;
    }
    if (bottomV) {
        [bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottomView).inset(15);
        }];
    }
}
 



/// 创建UI
/// @param title 主标题内容
/// @param subText 副文本
/// @param content 详细内容
/// @param tipStr 提示文字
- (void)heightForBgView:(NSString *)title subText:(NSString *)subText content:(NSString *)content showImages:(NSString *)images tipStr:(NSString *)tipStr hasBottomView:(BOOL)has{

    self.bottomViewH = 1;

    if (title.length > 0) {
        self.bottomViewH += (10 + [self getTextViewH:title font:[UIFont systemFontOfSize:13]]);
    }
    
    if (subText.length > 0) {
        self.bottomViewH += (10 + [self getTextViewH:subText font:[UIFont systemFontOfSize:13]]);
    }
    
    if (content.length > 0) {
        self.bottomViewH += (10 + [self getTextViewH:content font:[UIFont systemFontOfSize:13]]);
    }
    
    if (images.length > 0) {
        self.bottomViewH += (10 + 50);
    }
    
    if (tipStr.length > 0) {
        self.bottomViewH += (10 + [self getTextViewH:tipStr font:[UIFont boldSystemFontOfSize:13]]);
    }
    
    if (has) {
        self.bottomViewH += (15 + 30);
    }

    self.bottomViewH += 15;
    
}


+ (CGFloat)getViewHeight:(ShopMessageModel *)shopMsg isOwner:(BOOL)isOwner {
    
    CGFloat viewh = 100;
    
    ShopChatMessageView *chatMsg = [[ShopChatMessageView alloc] initWithFrame:CGRectMake(0, 0, shopViewWidth, viewh)];
    chatMsg.shopModel = shopMsg;
    [chatMsg updateBottmUI:NO isOwner:isOwner];
    
    viewh += MAX((chatMsg.bottomViewH), 15);

    [chatMsg removeAllSubViews];
    chatMsg = nil;
    
    return viewh;
}


- (CGFloat)getTextViewH:(NSString *)str font:(UIFont *)font{

    CGSize size = [str sizeWithFont:font constrainedToWidth:shopViewWidth-20];
    return size.height;

}


@end
