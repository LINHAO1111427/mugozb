//
//  OrderRefundVc.m
//  Shopping
//
//  Created by ssssssssssss on 2020/11/13.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OrderRefundView.h"
#import "ZDropScrollView.h"

#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>

#import <LibProjComm/SkyDriveTool.h>
#import <LibProjView/SDPhotoBrowser.h>
#import <TZImagePickerController/TZImagePickerController.h>

@interface OrderRefundView ()<UITextViewDelegate,ZDropScrollViewDelegate,SDPhotoBrowserDelegate>
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *model;
@property (nonatomic, assign)BOOL isJustRefundMoney;//是否仅仅退款
@property (nonatomic, strong)UIButton *reMoneyBtn;//退款按钮
@property (nonatomic, strong)UIButton *reCommodityBtn;//退货退款按钮

@property (nonatomic, strong)UILabel *resonTipL;//退款原因
@property (nonatomic, strong)UIImageView *resonArrowImageV;
@property (nonatomic, strong)UIButton *resonBtn;
 
@property (nonatomic, strong)UITextView *remarkTextView;//备注
@property (nonatomic, copy)NSString *remarkPicStr;

@property (nonatomic,strong) NSMutableArray *remarkImageDatas;
 
@property (nonatomic, strong)UIView *contentV;
 
@end

@implementation OrderRefundView
- (instancetype)initWithModel:(ShopUserOrderDetailDTOModel *)model{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self creatUI];
}
- (void)creatUI{
    self.isJustRefundMoney = YES;
    [self.view addSubview:self.contentV];
    
    //退款选择
    CGFloat scale = 320/80.0;
    CGFloat width = kScreenWidth*320/750.0;
    CGFloat height = width/scale;
    CGFloat margin = (kScreenWidth-2*width)/4.0;
    UIButton *reMoneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin, 70, width, height)];
    reMoneyBtn.layer.cornerRadius = height/2.0;
    reMoneyBtn.clipsToBounds = YES;
    reMoneyBtn.layer.borderWidth = 0.5;
    reMoneyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [reMoneyBtn setTitle:@"仅退款(未收到货)" forState:UIControlStateNormal];
    [reMoneyBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    [reMoneyBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateSelected];
    [reMoneyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F4F4F4")] forState:UIControlStateNormal];
    [reMoneyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FFF7F0")] forState:UIControlStateSelected];
    [reMoneyBtn addTarget:self action:@selector(reMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.reMoneyBtn = reMoneyBtn;
    [self.contentV addSubview:reMoneyBtn];
    
    UIButton *reCommodityBtn = [[UIButton alloc]initWithFrame:CGRectMake(reMoneyBtn.maxX+margin*2, 70, width, height)];
    reCommodityBtn.layer.cornerRadius = height/2.0;
    reCommodityBtn.clipsToBounds = YES;
    reCommodityBtn.layer.borderWidth = 0.5;
    reCommodityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (self.model.businessOrder.status <= 2) {
        reCommodityBtn.enabled = NO;
    }
    [reCommodityBtn setTitle:@"退货退款(收到货)" forState:UIControlStateNormal];
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
    UILabel *resonL = [[UILabel alloc]initWithFrame:CGRectMake(14, reMoneyBtn.maxY+15, 60, 20)];
    resonL.textColor = kRGB_COLOR(@"#333333");
    resonL.font = [UIFont systemFontOfSize:13];
    resonL.textAlignment = NSTextAlignmentLeft;
    resonL.text = @"退款原因";
    [self.contentV addSubview:resonL];
    UILabel *resonTipL = [[UILabel alloc]initWithFrame:CGRectMake(resonL.maxX, 0, kScreenWidth-74-28, 20)];
    resonTipL.textColor = kRGB_COLOR(@"#999999");
    resonTipL.font = [UIFont systemFontOfSize:12];
    resonTipL.centerY = resonL.centerY;
    resonTipL.textAlignment = NSTextAlignmentRight;
    resonTipL.text = @"请选择退款原因";
    [self.contentV addSubview:resonTipL];
    
    UIImageView *resonArrowImageV = [[UIImageView alloc]initWithFrame:CGRectMake(resonTipL.maxX, 0, 14, 14)];
    resonArrowImageV.contentMode = UIViewContentModeScaleAspectFit;
    resonArrowImageV.centerY = resonTipL.centerY;
    resonArrowImageV.image = [UIImage imageNamed:@"shopCart_arrow_down"];
    self.resonArrowImageV = resonArrowImageV;
    [self.contentV addSubview:resonArrowImageV];
    
    UIButton *resonBtn = [[UIButton alloc]initWithFrame:CGRectMake(14, 0, kScreenWidth-28, 30)];
    resonBtn.backgroundColor = [UIColor clearColor];
    resonBtn.centerY = resonL.centerY;
    [resonBtn addTarget:self action:@selector(resonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.resonBtn = resonBtn;
    [self.contentV addSubview:resonBtn];
    
    //退款金额
    UILabel *moneyTitleL = [[UILabel alloc]initWithFrame:CGRectMake(14, resonL.maxY+15, 60, 20)];
    moneyTitleL.textColor = kRGB_COLOR(@"#333333");
    moneyTitleL.font = [UIFont systemFontOfSize:13];
    moneyTitleL.textAlignment = NSTextAlignmentLeft;
    moneyTitleL.text = @"退款金额";
    [self.contentV addSubview:moneyTitleL];
    
    UILabel *moneyL = [[UILabel alloc]initWithFrame:CGRectMake(resonL.maxX, 0, kScreenWidth-60-28, 20)];
    moneyL.textColor = kRGB_COLOR(@"#333333");
    moneyL.font = [UIFont systemFontOfSize:13];
    moneyL.centerY = moneyTitleL.centerY;
    moneyL.textAlignment = NSTextAlignmentRight;
    moneyL.text = [NSString stringWithFormat:@"¥%.2f",66666.0];
    [self.contentV addSubview:moneyL];
    
    //凭证和备注
    UILabel *proofTitleL = [[UILabel alloc]initWithFrame:CGRectMake(14, moneyTitleL.maxY+15, 100, 20)];
    proofTitleL.textColor = kRGB_COLOR(@"#333333");
    proofTitleL.font = [UIFont systemFontOfSize:13];
    proofTitleL.textAlignment = NSTextAlignmentLeft;
    proofTitleL.text = @"上传凭证和备注";
    [self.contentV addSubview:proofTitleL];
    
    UILabel *proofTipL = [[UILabel alloc]initWithFrame:CGRectMake(proofTitleL.maxX, 0, kScreenWidth-100-28, 20)];
    proofTipL.textColor = kRGB_COLOR(@"#999999");
    proofTipL.font = [UIFont systemFontOfSize:13];
    proofTipL.centerY = proofTitleL.centerY;
    proofTipL.textAlignment = NSTextAlignmentRight;
    proofTipL.text = @"上传凭证更助于商家或售后处理哦～";
    [self.contentV addSubview:proofTipL];
    
    CGFloat profVHeight = self.contentV.height-(proofTitleL.maxY+10)-82-kSafeAreaBottom-40;
    UIView *proofView = [[UIView alloc]initWithFrame:CGRectMake(14, proofTitleL.maxY+10, kScreenWidth-28, profVHeight)];
    proofView.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    proofView.layer.cornerRadius = 10;
    proofView.clipsToBounds = YES;
    [self.contentV addSubview:proofView];
    
    UITextView *textV = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-48, profVHeight-80)];
    textV.placeholder = @"请输入备注内容…";
    textV.placeholderColor = kRGB_COLOR(@"#999999");
    textV.backgroundColor = [UIColor clearColor];
    textV.textAlignment = NSTextAlignmentLeft;
    textV.delegate = self;
    textV.textColor = kRGB_COLOR(@"#666666");
    self.remarkTextView = textV;
    [proofView addSubview:textV];
     
    UIView *picScrollView = [[UIView alloc]initWithFrame:CGRectMake(10, textV.maxY, kScreenWidth-48, 70)];
    picScrollView.backgroundColor = [UIColor clearColor];
    picScrollView.userInteractionEnabled = YES;
    [proofView addSubview:picScrollView];
     
    
    ZDropScrollView *remarkPicScroll = [[ZDropScrollView alloc] initWithFrame:CGRectMake(10, textV.maxY, kScreenWidth-48, 70)];
    remarkPicScroll.backgroundColor = [UIColor clearColor];
    remarkPicScroll.o_delegate = self;
    remarkPicScroll.o_regionView = picScrollView;
    remarkPicScroll.o_maxCount = 3;
    remarkPicScroll.sDROPVIEW_MARGIN = 10;
    remarkPicScroll.sDROPVIEW_SIZE = 70;
    remarkPicScroll.sDROPVIEW_COUNT = 4;
    remarkPicScroll.addImageStr = @"shop_addGoods";
    [picScrollView addSubview:remarkPicScroll];
    remarkPicScroll.o_imageDatas = self.remarkImageDatas;
    [remarkPicScroll reloadData];
    
    
    //提交按钮
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(14, proofView.maxY+20, kScreenWidth-28, 42)];
    submitBtn.backgroundColor = kRGB_COLOR(@"#FC8F3A");
    submitBtn.layer.cornerRadius = 21;
    [submitBtn setTitle:@"提交退款申请" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.clipsToBounds = YES;
    [self.contentV addSubview:submitBtn];
}
- (void)resonBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.resonArrowImageV.image = btn.selected?[UIImage imageNamed:@"shopCart_arrow_up"]:[UIImage imageNamed:@"shopCart_arrow_down"];
     
}
- (void)submitBtnClick:(UIButton *)btn{
    NSLog(@"提交退款申请");
}
///仅仅退款
- (void)reMoneyBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.reCommodityBtn.selected = NO;
    self.isJustRefundMoney = YES;
    btn.layer.borderColor = kRGB_COLOR(@"FC8F3A").CGColor;
    self.reCommodityBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}
///退货退款
- (void)reCommodityBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.isJustRefundMoney = NO;
    self.reMoneyBtn.selected = NO;
    btn.layer.borderColor = kRGB_COLOR(@"FC8F3A").CGColor;
    self.reMoneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}
- (void)closeBtnClcik:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy
- (UIView *)contentV{
    if (!_contentV) {
        CGFloat scale = 940/750.0;
        CGFloat height = kScreenWidth*scale+kSafeAreaBottom+20;
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-height, kScreenWidth, height)];
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
        titleL.text = @"申请退款";
        titleL.centerY = closeBtn.centerY;
        [_contentV addSubview:titleL];
        
        UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(14, titleL.maxY, kScreenWidth-28, 20)];
        tipL.textColor = [UIColor redColor];
        tipL.textAlignment = NSTextAlignmentLeft;
        tipL.font = [UIFont systemFontOfSize:12];
        tipL.text = @"退货或退款前请与客服协商一致";
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
-(void)addNewView:(ZDropScrollView *)scrollView{
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
    
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ///上传
        for (UIImage *image in photos) {
            [weakself uploadImage:image scrollView:scrollView];
        }
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
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

//可以在此动态修改 ZDropScrollView的高度
- (void)contentSizeDidChange:(CGSize)contenSize andView:(ZDropScrollView *)scrollView{
    CGFloat bgViewBaseHeight = scrollView.superview.height - scrollView.height;
    scrollView.height = contenSize.height+10;
    [scrollView.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bgViewBaseHeight + scrollView.height);
    }];
    [scrollView.superview layoutIfNeeded];
}


- (void)uploadImage:(UIImage *)image scrollView:(ZDropScrollView *)scrollView{
    kWeakSelf(self);
    [SkyDriveTool uploadImageWith:image scene:1 complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            [weakself.remarkImageDatas addObject:imageUrl];
            scrollView.o_imageDatas = weakself.remarkImageDatas;
            [scrollView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"发送图片失败！"];
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
@end
