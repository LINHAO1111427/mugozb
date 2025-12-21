//
//  OrderRefundVc.m
//  Shopping
//
//  Created by yww on 2020/11/13.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OrderRefundView.h"
#import "RefundReasonTable.h"
 
#import <LibProjModel/ApplyRefundDTOModel.h>
#import <LibProjModel/HttpApiShopQuiteOrder.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/ApplyRefundReasonDTOModel.h>
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>

#import <LibProjBase/PopupTool.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjView/SDPhotoBrowser.h>
#import <LibProjView/ZDropScrollView.h>

#import <LibProjView/SkyDriveTool.h>

#import <TZImagePickerController/TZImagePickerController.h>

@interface OrderRefundView ()<UITextViewDelegate,ZDropScrollViewDelegate,SDPhotoBrowserDelegate,RefundReasonTableDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *model;
@property (nonatomic, strong)ApplyRefundDTOModel *refundModel;//退款原因 金额
@property (nonatomic, assign)BOOL isJustRefundMoney;//是否仅仅退款
@property (nonatomic, strong)UIButton *reMoneyBtn;//退款按钮
@property (nonatomic, strong)UIButton *reCommodityBtn;//退货退款按钮

@property (nonatomic, strong)UILabel *resonTipL;//退款原因
@property (nonatomic, strong)UIImageView *resonArrowImageV;
@property (nonatomic, strong)UIButton *resonBtn;
@property (nonatomic, strong)UILabel *proofTitleL;
@property (nonatomic, strong)UILabel *proofTipL;
@property (nonatomic, strong)UIView *picScrollView;//凭证
@property (nonatomic, strong)UIView *proofView;

@property (nonatomic, weak)UIButton *submitBtn; ///提交btn

@property (nonatomic, strong)UITextView *remarkTextView;//备注
@property (nonatomic, copy)NSString *remarkPicStr;

@property (nonatomic,strong) NSMutableArray *remarkImageDatas;
 
@property (nonatomic, strong)UIView *contentV;

@property (nonatomic, strong)ApplyRefundReasonDTOModel *reasonModel;

@property (nonatomic, copy)OrderRefundCallBack callBack;

@property (nonatomic, strong)RefundReasonTable *resonTable;
@end

@implementation OrderRefundView


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

+ (void)showOrderRefundViewWith:(ShopUserOrderDetailDTOModel *)orderModel andCallBack:(OrderRefundCallBack)callBack{
    __block ShopUserOrderDetailDTOModel *orderDetailModel = orderModel;
    [HttpApiShopQuiteOrder beforApplyRefund:orderModel.businessOrder.id_field callback:^(int code, NSString *strMsg, ApplyRefundDTOModel *model) {
        if (code == 1) {
            CGFloat scale = 940/750.0;
            CGFloat height = kScreenWidth*scale+kSafeAreaBottom;
            OrderRefundView *showView = [[OrderRefundView alloc]initWithFrame:CGRectMake(0,kScreenHeight-height, kScreenWidth, height)];
            showView.backgroundColor = [UIColor clearColor];
            showView.callBack = callBack;
            showView.model = orderDetailModel;
            showView.isJustRefundMoney = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:showView action:@selector(tap)];
            tap.delegate = showView;
            [showView addGestureRecognizer:tap];
            showView.refundModel = model;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [showView creatUI];
                [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO cover:YES];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


- (void)keyBoardWillShow:(NSNotification *)notify{
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        weakself.y = kScreenHeight-endRc.size.height-self.height+kSafeAreaBottom+60;
    } completion:^(BOOL finished) {
    }];
}


- (void)keyBoardWillHide:(NSNotification *)notify{
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        weakself.y = kScreenHeight-self.height;
    } completion:^(BOOL finished) {
    }];
}

- (void)creatUI{
    [self.contentV removeAllSubViews];
    [self.contentV removeFromSuperview];
    self.contentV = nil;
    [self addSubview:self.contentV];
    //退款选择
    CGFloat scale = 320/80.0;
    CGFloat width = kScreenWidth*320/750.0;
    CGFloat height = width/scale;
    CGFloat margin = (kScreenWidth-2*width)/4.0;
    UIButton *reMoneyBtn = [UIButton buttonWithType:0];
    reMoneyBtn.frame = CGRectMake(margin, 70, width, height);
    reMoneyBtn.layer.cornerRadius = height/2.0;
    reMoneyBtn.clipsToBounds = YES;
    reMoneyBtn.layer.borderWidth = 0.5;
    reMoneyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    reMoneyBtn.adjustsImageWhenHighlighted = NO;
    [reMoneyBtn setTitle:kLocalizationMsg(@"仅退款(未收到货)") forState:UIControlStateNormal];
    [reMoneyBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    [reMoneyBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateSelected];
    [reMoneyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F4F4F4")] forState:UIControlStateNormal];
    [reMoneyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FFF7F0")] forState:UIControlStateSelected];
    [reMoneyBtn addTarget:self action:@selector(reMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.reMoneyBtn = reMoneyBtn;
    [self.contentV addSubview:reMoneyBtn];
    
    UIButton *reCommodityBtn = [UIButton buttonWithType:0];
    reCommodityBtn.frame = CGRectMake(reMoneyBtn.maxX+margin*2, 70, width, height);
    reCommodityBtn.layer.cornerRadius = height/2.0;
    reCommodityBtn.clipsToBounds = YES;
    reCommodityBtn.layer.borderWidth = 0.5;
    reCommodityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (self.model.businessOrder.status <= 2) {
        reCommodityBtn.enabled = NO;
    }
    [reCommodityBtn setTitle:kLocalizationMsg(@"退货退款(收到货)") forState:UIControlStateNormal];
    [reCommodityBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    [reCommodityBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateSelected];
    [reCommodityBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F4F4F4")] forState:UIControlStateNormal];
    [reCommodityBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FFF7F0")] forState:UIControlStateSelected];
    [reCommodityBtn addTarget:self action:@selector(reCommodityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.reCommodityBtn = reCommodityBtn;
    [self.contentV addSubview:reCommodityBtn];
    if (self.isJustRefundMoney) {
        self.reMoneyBtn.selected = YES;
        self.reCommodityBtn.selected = NO;
        self.reMoneyBtn.layer.borderColor = kRGB_COLOR(@"FC8F3A").CGColor;
        self.reCommodityBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }else{
        self.reMoneyBtn.selected = NO;
        self.reCommodityBtn.selected = YES;
        self.reCommodityBtn.layer.borderColor = kRGB_COLOR(@"FC8F3A").CGColor;
        self.reMoneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    //退款原因
    UIButton *resonBtn = [[UIButton alloc]initWithFrame:CGRectMake(14, reMoneyBtn.maxY+10, kScreenWidth-28, 30)];
    resonBtn.backgroundColor = [UIColor clearColor];
    [resonBtn addTarget:self action:@selector(resonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.resonBtn = resonBtn;
    [self.contentV addSubview:resonBtn];
    {
        UILabel *resonL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, resonBtn.height)];
        resonL.textColor = kRGB_COLOR(@"#333333");
        resonL.font = [UIFont systemFontOfSize:13];
        resonL.textAlignment = NSTextAlignmentLeft;
        resonL.text = kLocalizationMsg(@"退款原因");
        [resonBtn addSubview:resonL];
        
        UIImageView *resonArrowImageV = [[UIImageView alloc]initWithFrame:CGRectMake(resonBtn.width-8, 0, 8, 8)];
        resonArrowImageV.contentMode = UIViewContentModeScaleAspectFit;
        resonArrowImageV.centerY = resonBtn.height/2.0;
        resonArrowImageV.image = [UIImage imageNamed:@"shopCart_arrow_down"];
        self.resonArrowImageV = resonArrowImageV;
        [resonBtn addSubview:resonArrowImageV];
        
        UILabel *resonTipL = [[UILabel alloc]initWithFrame:CGRectMake(resonL.maxX+5, 0, resonArrowImageV.x-(resonL.maxX+5)-5, resonBtn.height)];
        resonTipL.textColor = kRGB_COLOR(@"#999999");
        resonTipL.font = [UIFont systemFontOfSize:12];
        resonTipL.centerY = resonL.centerY;
        resonTipL.textAlignment = NSTextAlignmentRight;
        resonTipL.text = kLocalizationMsg(@"请选择退款原因");
        self.resonTipL = resonTipL;
        [resonBtn addSubview:resonTipL];
    }
    
    //退款金额
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(resonBtn.x, resonBtn.maxY+5, resonBtn.width, resonBtn.height)];
    [self.contentV addSubview:backView];
    {
        UILabel *moneyTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, backView.height)];
        moneyTitleL.textColor = kRGB_COLOR(@"#333333");
        moneyTitleL.font = [UIFont systemFontOfSize:13];
        moneyTitleL.textAlignment = NSTextAlignmentLeft;
        moneyTitleL.text = kLocalizationMsg(@"退款金额");
        [backView addSubview:moneyTitleL];
        
        UILabel *moneyL = [[UILabel alloc]initWithFrame:CGRectMake(moneyTitleL.maxX+5, 0, backView.width-(moneyTitleL.maxX+5), backView.height)];
        moneyL.textColor = kRGB_COLOR(@"#333333");
        moneyL.font = [UIFont systemFontOfSize:13];
        moneyL.centerY = moneyTitleL.centerY;
        moneyL.textAlignment = NSTextAlignmentRight;
        moneyL.text = [NSString stringWithFormat:@"¥%.2f",self.refundModel.amount];
        [backView addSubview:moneyL];
    }
    
    //凭证和备注
    UIView *remarkView = [[UIView alloc] initWithFrame:CGRectMake(backView.x, backView.maxY+5, backView.width, backView.height)];
    [self.contentV addSubview:remarkView];
    {
        UILabel *proofTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, remarkView.height)];
        proofTitleL.textColor = kRGB_COLOR(@"#333333");
        proofTitleL.font = [UIFont systemFontOfSize:13];
        proofTitleL.textAlignment = NSTextAlignmentLeft;
        if (self.isJustRefundMoney) {
            proofTitleL.text = kLocalizationMsg(@"备注");
        }else{
            proofTitleL.text = kLocalizationMsg(@"上传凭证和备注");
        }
        self.proofTitleL = proofTitleL;
        [remarkView addSubview:proofTitleL];
        
        UILabel *proofTipL = [[UILabel alloc]initWithFrame:CGRectMake(proofTitleL.maxX, 0, remarkView.width-proofTitleL.maxX, remarkView.height)];
        proofTipL.textColor = kRGB_COLOR(@"#999999");
        proofTipL.font = [UIFont systemFontOfSize:13];
        proofTipL.centerY = proofTitleL.centerY;
        proofTipL.textAlignment = NSTextAlignmentRight;
        proofTipL.text = kLocalizationMsg(@"上传凭证更助于商家或售后处理哦～");
        proofTipL.hidden = self.isJustRefundMoney;
        self.proofTipL = proofTipL;
        [remarkView addSubview:proofTipL];
    }

    
    CGFloat picW = (kScreenWidth-48-30-20)/3.0;
    CGFloat profVHeight = self.contentV.height-(remarkView.maxY+10)-82-kSafeAreaBottom;
    
    UIView *proofView = [[UIView alloc]initWithFrame:CGRectMake(14, remarkView.maxY+10, kScreenWidth-28, profVHeight)];
    proofView.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    proofView.layer.cornerRadius = 10;
    proofView.clipsToBounds = YES;
    self.proofView = proofView;
    [self.contentV addSubview:proofView];
     
    
    CGFloat picMargin = 15;
    if (profVHeight - picW -20 < 60) {
        picW = profVHeight-20 -60;
        picMargin = (kScreenWidth-48-20-3*picW)/2.0;
    }
    CGFloat textH;
    if (self.isJustRefundMoney) {
        textH = profVHeight -10;
    }else{
        textH = profVHeight-picW-20;
    }
    UITextView *textV = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-48, textH)];
    textV.placeholder = kLocalizationMsg(@"请输入备注内容…");
    textV.placeholderColor = kRGB_COLOR(@"#999999");
    textV.backgroundColor = [UIColor clearColor];
    textV.textAlignment = NSTextAlignmentLeft;
    textV.delegate = self;
    textV.textColor = kRGB_COLOR(@"#666666");
    self.remarkTextView = textV;
    [proofView addSubview:textV];
     
    UIView *picScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, textV.maxY, kScreenWidth-28, picW+20)];
    picScrollView.backgroundColor = [UIColor clearColor];
    picScrollView.userInteractionEnabled = YES;
    self.picScrollView = picScrollView;
    [proofView addSubview:picScrollView];
    picScrollView.hidden = self.isJustRefundMoney;
     
     
    ZDropScrollView *remarkPicScroll = [[ZDropScrollView alloc] initWithFrame:picScrollView.bounds];
    remarkPicScroll.backgroundColor = [UIColor clearColor];
    remarkPicScroll.o_delegate = self;
    remarkPicScroll.o_regionView = picScrollView;
    remarkPicScroll.o_maxCount = 3;
    remarkPicScroll.bounces = NO;
    remarkPicScroll.sDROPVIEW_MARGIN = picMargin;
    remarkPicScroll.sDROPVIEW_SIZE = picW;
    remarkPicScroll.sDROPVIEW_COUNT = 4;
    remarkPicScroll.addImageStr = @"shop_addGoods";
    [picScrollView addSubview:remarkPicScroll];
    remarkPicScroll.o_imageDatas = [NSMutableArray array];
    [remarkPicScroll reloadData];
    
    //提交按钮
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(14, proofView.maxY+20, kScreenWidth-28, 42)];
    submitBtn.backgroundColor = kRGB_COLOR(@"#FC8F3A");
    submitBtn.layer.cornerRadius = 21;
    [submitBtn setTitle:kLocalizationMsg(@"提交退款申请") forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.clipsToBounds = YES;
    [self.contentV addSubview:submitBtn];
    self.submitBtn = submitBtn;
    
    if (self.refundModel.reasonList.count > 0) {
        RefundReasonTable *resonTable = [[RefundReasonTable alloc]initWithFrame:CGRectMake(0, resonBtn.maxY, kScreenWidth, profVHeight+80)];
        resonTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        resonTable.hidden = YES;
        resonTable.bounces = NO;
        resonTable.resonDelegate = self;
        resonTable.layer.shadowColor = kRGB_COLOR(@"#F4F4F4").CGColor;
        resonTable.layer.shadowOffset = CGSizeMake(0,2);
        resonTable.layer.shadowOpacity = 0.5;
        resonTable.layer.shadowRadius = 5;
        [resonTable shadowPathWith:kRGB_COLOR(@"#F4F4F4") shadowOpacity:0.5 shadowRadius:5 shadowSide:KLCShadowPathTopBottom shadowPathWidth:4];
     
        resonTable.backgroundColor = [UIColor whiteColor];
        resonTable.dataArray = self.refundModel.reasonList;
        self.resonTable = resonTable;
        [self.contentV addSubview:resonTable];
        [resonTable reloadData];
    }
}

- (void)tap{
    [self.remarkTextView resignFirstResponder];
}

- (void)resonBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.contentV bringSubviewToFront:self.resonTable];
    }
    self.resonArrowImageV.image = btn.selected?[UIImage imageNamed:@"shopCart_arrow_up"]:[UIImage imageNamed:@"shopCart_arrow_down"];
    self.resonTable.hidden = !btn.selected;
}

- (void)submitBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    if (!self.reasonModel) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择退款原因")];
        return;
    }
    
    NSString *refundNotes = @"";
    NSString *refundNotesImages = @"";
    if (self.remarkTextView.text.length > 0) {
        refundNotes = self.remarkTextView.text;
    }
    if (self.remarkImageDatas.count > 0) {//备注图片
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < self.remarkImageDatas.count; i++) {
            NSString *imageUrl = self.remarkImageDatas[i];
            if (i != self.remarkImageDatas.count-1) {
                [str appendString:[NSString stringWithFormat:@"%@,",imageUrl]];
            }else{
                [str appendString:imageUrl];
            }
        }
        refundNotesImages = str;
    }
    
    [HttpApiShopQuiteOrder applyRefund:self.model.businessOrder.id_field reasonId:self.reasonModel.id_field refundNotes:refundNotes refundNotesImages:refundNotesImages type:self.isJustRefundMoney?1:2 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            if (weakself.callBack) {
                weakself.callBack(YES);
            }
        }else{
            if (weakself.callBack) {
                weakself.callBack(NO);
            }
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[PopupTool share] closePopupView:weakself];
        });
    }];
     
}
///仅仅退款
- (void)reMoneyBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.reCommodityBtn.selected = NO;
    btn.layer.borderColor = kRGB_COLOR(@"FC8F3A").CGColor;
    self.reCommodityBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    if (!self.isJustRefundMoney) {
        self.isJustRefundMoney = YES;
        [self creatUI];
    }
     
}
///退货退款
- (void)reCommodityBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.reMoneyBtn.selected = NO;
    btn.layer.borderColor = kRGB_COLOR(@"FC8F3A").CGColor;
    self.reMoneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    if (self.isJustRefundMoney) {
        self.isJustRefundMoney = NO;
        [self creatUI];
    }
}
- (void)closeBtnClcik:(UIButton *)btn{
    self.callBack(NO);
    [[PopupTool share] closePopupView:self];
}

#pragma mark - lazy
- (UIView *)contentV{
    if (!_contentV) {
        CGFloat scale = 940/750.0;
        CGFloat height = kScreenWidth*scale+kSafeAreaBottom;
        CGFloat picW = (kScreenWidth-48-30-20)/3.0;
        CGFloat y = 0;
        if (self.isJustRefundMoney) {
            height = height - picW;
            y = picW;
        }
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height)];
        _contentV.backgroundColor = [UIColor whiteColor];
        CGFloat radius = 10; // 圆角大小
        UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight; // 圆角位置
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:_contentV.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentV.bounds;
        maskLayer.path = path.CGPath;
        _contentV.layer.mask = maskLayer;
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-44, 10, 30, 30)];
        [closeBtn setImage:[UIImage imageNamed:@"main_close_jinshan"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClcik:) forControlEvents:UIControlEventTouchUpInside];
        [_contentV addSubview:closeBtn];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 100, 20)];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textColor = kRGB_COLOR(@"#333333");
        titleL.text = kLocalizationMsg(@"申请退款");
        titleL.centerY = closeBtn.centerY;
        [_contentV addSubview:titleL];
        
        UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(14, titleL.maxY, kScreenWidth-28, 20)];
        tipL.textColor = [UIColor redColor];
        tipL.textAlignment = NSTextAlignmentLeft;
        tipL.font = [UIFont systemFontOfSize:12];
        tipL.text = kLocalizationMsg(@"退货或退款前请与客服协商一致");
        [_contentV addSubview:tipL];
        
    }
    return _contentV;
}
- (NSMutableArray *)remarkImageDatas{
    if (!_remarkImageDatas) {
        _remarkImageDatas = [NSMutableArray array];
    }
    return _remarkImageDatas;
}

#pragma mark- DroScrollViewDelegate
- (void)addNewView:(ZDropScrollView *)scrollView{
    kWeakSelf(self);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    NSInteger num = scrollView.o_maxCount-scrollView.o_imageDatas.count;
    imagePickerVc.maxImagesCount = num>0?num:1;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.showSelectedIndex = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.showSelectBtn = YES;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ///上传
        for (UIImage *image in photos) {
            [weakself uploadImage:image scrollView:scrollView];
        }
    }];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)exchangeIndex:(NSInteger)index otherIndex:(NSInteger)otherIndex andView:(ZDropScrollView *)scrollView{
     
    [self.remarkImageDatas exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
}


- (void)removeIndex:(NSInteger)index andView:(ZDropScrollView *)scrollView{
    [self.remarkImageDatas removeObjectAtIndex:index];
}



- (void)didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo andView:(ZDropScrollView *)scrollView{
    [self clickImageView:index scrollView:scrollView];
}


- (void)uploadImage:(UIImage *)image scrollView:(ZDropScrollView *)scrollView{
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:5 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            [weakself.remarkImageDatas addObject:imageUrl];
            scrollView.o_imageDatas = weakself.remarkImageDatas;
            [scrollView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送图片失败！")];
        }
    }];
}

- (void)clickImageView:(NSInteger)imageTag scrollView:(ZDropScrollView *)scrollView{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageTag;
    browser.sourceImagesContainerView = scrollView;
    browser.imageCount = self.remarkImageDatas.count;
    browser.delegate = self;
    [browser show];
}

#pragma mark - SDPhotoBrowserDelegate -
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    NSString *urlStr = [self.remarkImageDatas[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:urlStr];
}


- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.remarkImageDatas[index]]]];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView == self.remarkTextView) {
        NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
        if (str.length > 50){
            textView.text = [str substringToIndex:50];
            return NO;
        }
        return YES;
    }
    return YES;
}
#pragma mark - RefundReasonTableDelegate
- (void)refundReasonTableDidSelected:(NSIndexPath *)selectedIndex withModel:(ApplyRefundReasonDTOModel *)model{
    self.resonBtn.selected = NO;
    self.resonTipL.text = model.reason;
    self.reasonModel = model;
    self.resonTable.hidden = YES;
    self.resonArrowImageV.image = [UIImage imageNamed:@"shopCart_arrow_down"];
}
#pragma mark- UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
@end
