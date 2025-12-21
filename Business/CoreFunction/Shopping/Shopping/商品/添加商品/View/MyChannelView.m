//
//  MyChannelView.m
//  Shopping
//
//  Created by kalacheng on 2020/6/29.
//  Copyright © 2020 klc. All rights reserved.
//

#import "MyChannelView.h"
#import "KeyboardToolBar.h"
#import "SetGoodsAttributeVC.h"
#import "GoogsCategoryController.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/SkyDriveTool.h>

#import <LibProjView/SDPhotoBrowser.h>
#import <LibProjView/ZDropScrollView.h>
 
#import <LibProjModel/ShopGoods_creatGoods.h>
#import <LibProjModel/ShopGoods_updateGoods.h>

#import <Masonry/Masonry.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjView/CustomCameraController.h>

@interface MyChannelView ()<ZDropScrollViewDelegate,SDPhotoBrowserDelegate,UITextViewDelegate, UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UIView *priceView; ///价格的视图
@property (nonatomic, weak) UIView *discountsView; ///优惠价格视图

@property (nonatomic, copy) NSString *goodsName;  ///商品名称
@property (nonatomic, copy) NSString *price;   ///价格
@property (nonatomic, copy) NSString *discounts;  ///优惠价格

@property (nonatomic, weak) UITextField *attriTextF;  ///属性
@property (nonatomic, weak) UITextField *discountsTextF;  ///优惠价格
@property (nonatomic, weak) UITextField *priceTextF;  ///价格
@property (nonatomic, weak) UITextField *nameTextF;  ///名称
@property (nonatomic, weak) UITextField *cateGoryTextF;  ///分类
@property (nonatomic, strong) UITextView *detailTextView;///详情
@property (nonatomic, weak) ZDropScrollView *headFigureScroll;  ///头部
@property (nonatomic, weak) ZDropScrollView *detailFigureScroll;  ///详情
@property (nonatomic, weak)UIButton *addbtn;//添加

@property (nonatomic, weak)UIScrollView *bgScroll;
@property (nonatomic, weak)UIView *becomeV; ///获得鼠标焦点的view
 
///分类
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, assign) int64_t categoryId;


///商品头图
@property (nonatomic,strong) NSMutableArray *headFigureImageDatas;
///商品详情图
@property (nonatomic,strong) NSMutableArray *detailsImageDatas;

@end

@implementation MyChannelView

- (void)dealloc
{
    [self keyboardNotification:NO];
    
    [_headFigureImageDatas removeAllObjects];
    [_detailsImageDatas removeAllObjects];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
        [self keyboardNotification:YES];
        
    }
    return self;
}

- (void)keyboardNotification:(BOOL)isAdd{
    if (isAdd) {
        [self keyboardNotification:NO];
        //键盘监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


- (void)modifyGoods{
    NSString *detailImges;
    for (int i = 0; i < self.detailsImageDatas.count; i++) {
        NSString *url = self.detailsImageDatas[i];
        if (i > 0) {
            detailImges = [NSString stringWithFormat:@"%@,%@",detailImges,url];
        }else{
            detailImges = url;
        }
    }
    NSString *goodImges;
    for (int j = 0; j < self.headFigureImageDatas.count; j++) {
        NSString *url = self.headFigureImageDatas[j];
        if (j > 0) {
            goodImges = [NSString stringWithFormat:@"%@,%@",goodImges,url];
        }else{
            goodImges = url;
        }
    }
    ShopGoods_updateGoods *goods = [[ShopGoods_updateGoods alloc]init];
    goods.present = self.detailTextView.text.length > 0?self.detailTextView.text:@"";
    goods.categoryId = self.categoryId > 0?self.categoryId:0;
    goods.channelId = self.channelId > 0?self.channelId:-1;
    goods.goodsId = self.goodsId > 0?self.goodsId:0;
    goods.detailPicture = detailImges.length > 0?detailImges:@"";
    goods.goodsPicture = goodImges.length > 0?goodImges:@"";
    goods.goodsName = self.goodsName.length > 0?self.goodsName:@"";
    goods.productLinks = @"";
    goods.favorablePrice = [self.discounts doubleValue];
    goods.price = [self.price doubleValue];
    goods.type = 2;
     kWeakSelf(self);
    [HttpApiShopGoods updateGoods:goods callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            if (weakself.addGoodsSuccess) {
                weakself.addGoodsSuccess();
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)submitGoods{
    NSString *detailImges;
    for (int i = 0; i < self.detailsImageDatas.count; i++) {
        NSString *url = self.detailsImageDatas[i];
        if (i > 0) {
            detailImges = [NSString stringWithFormat:@"%@,%@",detailImges,url];
        }else{
            detailImges = url;
        }
    }
    NSString *goodImges;
    for (int j = 0; j < self.headFigureImageDatas.count; j++) {
        NSString *url = self.headFigureImageDatas[j];
        if (j > 0) {
            goodImges = [NSString stringWithFormat:@"%@,%@",goodImges,url];
        }else{
            goodImges = url;
        }
    }
     
    ShopGoods_creatGoods *goods = [[ShopGoods_creatGoods alloc]init];
    goods.present = self.detailTextView.text.length > 0?self.detailTextView.text:@"";
    goods.categoryId = self.categoryId > 0?self.categoryId:0;
    goods.channelId = self.channelId > 0?self.channelId:-1;
    goods.goodsId = self.goodsId;
    goods.detailPicture = detailImges.length > 0?detailImges:@"";
    goods.goodsPicture = goodImges.length > 0?goodImges:@"";
    goods.goodsName = self.goodsName.length > 0?self.goodsName:@"";
    goods.productLinks = @"";
    goods.favorablePrice = [self.discounts doubleValue];
    goods.price = [self.price doubleValue];
    goods.type = 2;
   
    kWeakSelf(self);
    [HttpApiShopGoods creatGoods:goods callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            if (weakself.addGoodsSuccess) {
                weakself.addGoodsSuccess();
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

-(void)creatSubView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-44)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self addSubview:scrollView];
    self.bgScroll = scrollView;
    
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.bottom.equalTo(self).inset(44);
//    }];

    UIView *contentBgV = [[UIView alloc] init];
    [scrollView addSubview: contentBgV];
    [contentBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    ///透明虚拟的顶部线
    UIView *topLine = [[UIView alloc] init];
    [contentBgV addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentBgV);
        make.height.mas_equalTo(0.1);
    }];
    
    ///type : 1:输入文字。  2 点击事件。  3 照片
    NSArray *itemArr = @[@{@"name":kLocalizationMsg(@"商品名称"),@"placeholder":kLocalizationMsg(@"请输入商品名称"),@"type":@"1"},
                         @{@"name":kLocalizationMsg(@"商品分类"),@"placeholder":kLocalizationMsg(@"请选择商品分类"),@"type":@"2"},
                         @{@"name":kLocalizationMsg(@"商品图片"),@"placeholder":kLocalizationMsg(@"不超过8张，长按图片并拖动可排序"),@"type":@"3"},
                         @{@"name":kLocalizationMsg(@"商品详情"),@"placeholder":kLocalizationMsg(@"不超过16张"),@"type":@"4"},
                         @{@"name":kLocalizationMsg(@"商品属性"),@"placeholder":kLocalizationMsg(@"(非必填)"),@"type":@"5"},
                         @{@"name":kLocalizationMsg(@"商品价格"),@"placeholder":@"¥ 0.00",@"type":@"6"},
                         @{@"name":kLocalizationMsg(@"优惠价格"),@"placeholder":@"¥ 0.00",@"type":@"7"},
    ];

    UIView *topV = topLine;

    for (int i = 0; i<itemArr.count; i++) {

        NSDictionary *item = itemArr[i];
        ///背景视图的高度
        CGFloat viewHeight = 50;
        CGFloat top = 10;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(20, topV.maxY, self.width-40, viewHeight)];
        [contentBgV addSubview:bgView];
        ///masonry设置bgview尺寸的代码在最后
        
        UILabel *nameL = [[UILabel alloc] init];
        nameL.text = item[@"name"];
        nameL.textColor = kRGB_COLOR(@"#555555");
        nameL.font = [UIFont systemFontOfSize:14];
        [nameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [bgView addSubview:nameL];
        [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView);
            make.width.mas_greaterThanOrEqualTo(80);
            make.top.equalTo(bgView).offset(5);
            make.height.mas_equalTo(viewHeight-top);
        }];
        
        int type = [item[@"type"] intValue];
        
        switch (type) {
            case 1:  ///商品名称
            case 2:  ///商品分类
            case 5:  ///商品属性
            case 6:  ///商品价格
            case 7:  ///优惠价格
            {
                UITextField *textF = [[UITextField alloc] init];
                textF.font = [UIFont systemFontOfSize:13];
                textF.tag = 98567 + type;
                textF.placeholder = item[@"placeholder"];
                [bgView addSubview:textF];
                [textF mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(nameL.mas_right).offset(5);
                    make.right.equalTo(bgView);
                    make.height.equalTo(nameL);
                    make.centerY.equalTo(nameL);
                }];
                
                if (type == 1 || type == 6 || type == 7) {
                    if (type == 6) {
                        self.priceTextF = textF;
                        self.priceTextF.delegate = self;
                        self.priceTextF.keyboardType = UIKeyboardTypeDecimalPad;
                    }
                    if (type == 7) {
                        self.discountsTextF = textF;
                        self.discountsTextF.delegate = self;
                        self.discountsTextF.keyboardType = UIKeyboardTypeDecimalPad;
                    }
                    if (type == 1) {
                        self.nameTextF = textF;
                    }
                    textF.userInteractionEnabled = YES;
                    [textF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
                }else{
                    if (type == 5) {
                        self.attriTextF  =textF;
                    }
                    textF.userInteractionEnabled = NO;
                    ///图片
                    UIImageView *imageV = [[UIImageView alloc] init];
                    imageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
                    imageV.contentMode = UIViewContentModeScaleAspectFit;
                    [bgView addSubview:imageV];
                    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(10, 12));
                        make.right.equalTo(bgView);
                        make.centerY.equalTo(nameL);
                    }];
                    
                    UIButton *selectBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
                    selectBtn.tag = 98667 + type;
                    [selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [bgView addSubview:selectBtn];
                    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.top.bottom.equalTo(textF);
                        make.right.equalTo(imageV);
                    }];
                    if (type == 2) {
                        for (UIView *subV in selectBtn.superview.subviews) {
                            if([subV isKindOfClass:[UITextField class]]){
                                UITextField *textV = (UITextField *)subV;
                                self.cateGoryTextF = textV;
                            }
                        }
                    }
                }
            
                ///线
                UIView *linkV = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight-0.5, bgView.width, 0.5)];
                linkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
                [bgView addSubview:linkV];
                [linkV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.equalTo(bgView);
                    make.height.mas_equalTo(0.5);
                    make.top.equalTo(nameL.mas_bottom).offset(5);
                }];
            }
                break;
            case 3:  ///商品头图
            case 4:  ///商品详情
            {
                NSString *showStr = [NSString stringWithFormat:@"%@ (%@)",item[@"name"],item[@"placeholder"]];
                NSMutableAttributedString *muAttStr = [[NSMutableAttributedString alloc] initWithString:showStr];
                [muAttStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange([item[@"name"] length]+1, [item[@"placeholder"] length]+2)];
                nameL.attributedText = muAttStr;
                
                CGFloat maxY = viewHeight;
                if (type == 3) {
                    viewHeight += (kScreenWidth-80)/4 + 20;
                }else{
                    viewHeight += ((kScreenWidth-80)/4 + 100 + 20);
                    UITextView *detailsTV = [[UITextView alloc] initWithFrame:CGRectMake(-20, maxY , kScreenWidth, 100)];
                    detailsTV.font = [UIFont systemFontOfSize:12];
                    detailsTV.backgroundColor = kRGB_COLOR(@"#F7F7F7");
                    detailsTV.textColor = kRGB_COLOR(@"#9BA2AC");
                    detailsTV.textContainerInset = UIEdgeInsetsMake(10, 20, 10, 20);
                    detailsTV.placeholder = kLocalizationMsg(@"输入商品详情，最多200字，非必填");
                    detailsTV.placeholderColor = kRGB_COLOR(@"#999999");
                    detailsTV.delegate = self;
                    self.detailTextView = detailsTV;
                    [bgView addSubview:detailsTV];
                    [detailsTV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(bgView).offset(maxY);
                        make.left.right.equalTo(bgView).inset(-20);
                        make.height.mas_equalTo(100);
                    }];
                    KeyboardToolBar *toolBar = [[KeyboardToolBar alloc]initWithArray:@[detailsTV]];
                    detailsTV.inputAccessoryView = toolBar;
                    
                    maxY += 100;
                }
                
                [bgView layoutIfNeeded];
                
                UIView *imgBgV = [[UIView alloc] init];
                [bgView addSubview:imgBgV];
                [imgBgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(bgView).offset(maxY);
                    make.left.equalTo(bgView).inset(-10);
                    make.width.mas_equalTo(kScreenWidth -20);
                    make.height.mas_equalTo((kScreenWidth-80)/4.0 + 20);
                    make.bottom.equalTo(bgView);
                }];
                [imgBgV layoutIfNeeded];
                
                ZDropScrollView *headFigureScrol = [[ZDropScrollView alloc] initWithFrame:CGRectMake(0, 0, imgBgV.width, imgBgV.height)];
                headFigureScrol.o_delegate = self;
                headFigureScrol.o_regionView = contentBgV;
                headFigureScrol.o_maxCount = type == 3?8:16;
                headFigureScrol.sDROPVIEW_MARGIN = 13;
                headFigureScrol.sDROPVIEW_SIZE = (kScreenWidth-80)/4.0;
                headFigureScrol.sDROPVIEW_COUNT = 4;
                headFigureScrol.tag = 98767+type;
                headFigureScrol.addImageStr = @"shop_addGoods";
                if (type == 3) {
                    self.headFigureScroll = headFigureScrol;
                }else{
                    self.detailFigureScroll = headFigureScrol;
                }
                [imgBgV addSubview:headFigureScrol];
                headFigureScrol.o_imageDatas = [[NSMutableArray alloc] init];
                [headFigureScrol reloadData];

            }
                break;
            default:
                break;
        }
        
        if (type == 6) {
            _priceView = bgView;
        }
        
        if (type == 7) {
            _discountsView = bgView;
        }
        
        ////设置当前view
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentBgV).inset(20);
            make.top.equalTo(topV.mas_bottom);
            if (i == (itemArr.count-1)) {
                make.bottom.equalTo(contentBgV).mas_offset(-50);
            }
        }];
        topV = bgView;
    }
    
    {
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height-44, self.width, 44)];
        addBtn.backgroundColor = kRGB_COLOR(@"#FF5500");
        [addBtn setTitle:kLocalizationMsg(@"立即添加") forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.addbtn = addBtn;
        [self addSubview:self.addbtn];
    }
}



///选择文字标签
- (void)textValueChange:(UITextField *)textF{
    switch (textF.tag - 98567) {
        case 1:  ///商品名称
        {
            _goodsName = textF.text;
        }
            break;
        case 2:  ///商品分类
        {
            
        }
            break;
        case 5:  ///商品属性
        {
            
        }
            break;
        case 6:  ///商品价格
        {
            _price = textF.text;
        }
            break;
        case 7:  ///优惠价格
        {
            _discounts = textF.text;
        }
            break;
        default:
            break;
    }
}
- (void)setModel:(ShopGoodsDTOModel *)model{
    _model = model;
    self.goodsId = model.goodsId;
    self.channelId = model.channelId;
    //分类
    self.categoryId = model.categoryId;
    self.categoryName = model.categoryName;
    self.cateGoryTextF.text = model.categoryName;
    //名称
    self.nameTextF.text = model.goodsName;
    self.goodsName = model.goodsName;
    
    //详情
    self.detailTextView.text = model.present;
    //价格
    self.price = [NSString stringWithFormat:@"%.2f",model.price];
    self.discounts = [NSString stringWithFormat:@"%.2f",model.favorablePrice];
    self.priceTextF.text = self.price;
    self.discountsTextF.text = self.discounts;
    //商品图片
    NSMutableArray *headImages = [NSMutableArray arrayWithArray:[model.goodsPicture componentsSeparatedByString:@","]];
    NSMutableArray *detailImages = [NSMutableArray arrayWithArray:[model.detailPicture componentsSeparatedByString:@","]];
    self.headFigureImageDatas = headImages;
    self.detailsImageDatas = detailImages;
    self.headFigureScroll.o_imageDatas = self.headFigureImageDatas;
    [self.headFigureScroll reloadData];
    self.detailFigureScroll.o_imageDatas = self.detailsImageDatas;
    [self.detailFigureScroll reloadData];
    [self.addbtn setTitle:kLocalizationMsg(@"立即修改") forState:UIControlStateNormal];
}

- (void)priceIsHidden:(BOOL)hidden attrStr:(NSString *)str{
    if (hidden) {
        self.attriTextF.text = str;
        self.price = @"";
        self.discounts = @"";
    }else{
        self.attriTextF.text = @"";
    }
    self.priceView.hidden = hidden;
    self.discountsView.hidden = hidden;
}

///选择商品分类或者商品属性
- (void)btnClick:(UIButton *)btn{
    NSInteger type = btn.tag-98667;
    switch (type) {
        case 2:  ///商品分类
        {
            GoogsCategoryController *categoryVC = [[GoogsCategoryController alloc] init];
            [[ProjConfig currentVC].navigationController pushViewController:categoryVC animated:YES];
            
            kWeakSelf(self);
            categoryVC.selectCategory = ^(int64_t categoryId, NSString * _Nonnull categoryName) {
                weakself.categoryId = categoryId;
                weakself.categoryName = categoryName;
                for (UIView *subV in btn.superview.subviews) {
                    if([subV isKindOfClass:[UITextField class]]){
                        UITextField *textV = (UITextField *)subV;
                        textV.text = categoryName;
                    }
                }
            };
        }
            break;
        case 5:///商品属性
        {
            SetGoodsAttributeVC *attrVC = [[SetGoodsAttributeVC alloc] init];
            if (self.isModify) {
                attrVC.isModify = YES;
                attrVC.goodsId = self.goodsId;
            }
            [[ProjConfig currentVC].navigationController pushViewController:attrVC animated:YES];
        }
            break;
        default:
            break;
    }
}

//添加
-(void)addBtnClick:(UIButton *)sender{
    if (_goodsName.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商品名称")];
        return;
    }
    if (self.attriTextF.text.length == 0) {
         if (_price.length == 0) {
               [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商品价格")];
               return;
           }
    }
    if (_categoryId == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择商品分类")];
        return;
    }
    if (_headFigureImageDatas.count == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请上传商品图片")];
        return;
    }
    if (self.isModify) {
        [self modifyGoods];
    }else{
       [self submitGoods];
    }
     
}


-(NSMutableArray *)headFigureImageDatas{
    if (!_headFigureImageDatas) {
        _headFigureImageDatas = [NSMutableArray array];
    }
    return _headFigureImageDatas;
}

-(NSMutableArray *)detailsImageDatas{
    if (!_detailsImageDatas) {
        _detailsImageDatas = [NSMutableArray array];
    }
    return _detailsImageDatas;
}


#pragma mark -- 获取键盘高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        weakself.bgScroll.height = weakself.height-keyboardRect.size.height+kSafeAreaBottom;
        if (weakself.becomeV == weakself.detailTextView) {
            weakself.bgScroll.contentOffset = CGPointMake(0, (weakself.detailTextView.superview.y+weakself.detailTextView.maxY)-weakself.bgScroll.height+20);
        }else{
            if ((weakself.becomeV == weakself.discountsTextF )|| (weakself.becomeV == weakself.priceTextF )) {
                weakself.bgScroll.contentOffset = CGPointMake(0, weakself.bgScroll.contentSize.height-weakself.bgScroll.height);
            }
        }
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{   NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        weakself.bgScroll.height = weakself.height-44;
    }];
}


#pragma mark- PreDroScrollViewDelegate

- (void)addNewView:(ZDropScrollView*)scrollView{
    kWeakSelf(self);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];;
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"相机") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself photoShoot:scrollView];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself addImage:scrollView];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];

}


- (void)photoShoot:(ZDropScrollView *)scrollView{
    kWeakSelf(self);
    CustomCameraController *camera = [[CustomCameraController alloc] init] ;
    camera.showPhotoAlbum = NO;
    camera.functionType = CameraFunction_onlyCamera;
    camera.isFront = NO;
    [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
        [cameraVC dismissViewControllerAnimated:NO completion:nil];
        ///上传
        [weakself uploadImage:images.firstObject scrollView:scrollView];
    }];
    [[ProjConfig currentVC] presentViewController:camera animated:YES completion:nil];
}


-(void)addImage:(ZDropScrollView *)scrollView{
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
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ///上传
        for (UIImage *image in photos) {
            [weakself uploadImage:image scrollView:scrollView];
        }
    }];
    
    [[ProjConfig currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)exchangeIndex:(NSInteger)index otherIndex:(NSInteger)otherIndex andView:(ZDropScrollView *)scrollView
{
    NSInteger imageType = (scrollView.tag- 98767);
    if (imageType == 3) {  ///头图
        [self.headFigureImageDatas exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
    }else{ ///详情图
        [self.detailsImageDatas exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
    }
}


- (void)removeIndex:(NSInteger)index andView:(ZDropScrollView *)scrollView{
    NSInteger imageType = (scrollView.tag- 98767);
    if (imageType == 3) {  ///头图
        [self.headFigureImageDatas removeObjectAtIndex:index];
    }else{ ///详情图
        [self.detailsImageDatas removeObjectAtIndex:index];
    }
}



- (void)didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo andView:(ZDropScrollView *)scrollView
{
    [self clickImageView:index scrollView:scrollView];
}

//可以在此动态修改 ZDropScrollView的高度
- (void)contentSizeDidChange:(CGSize)contenSize andView:(ZDropScrollView *)scrollView
{
   // NSLog(@"过滤文字content size:%@    %0.0lf"),NSStringFromCGSize(contenSize), (kScreenWidth-80)/4.0 + 20);
    
    scrollView.height = contenSize.height + 20;
    [scrollView.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scrollView.height);
    }];
}


- (void)uploadImage:(UIImage *)image scrollView:(ZDropScrollView *)scrollView{
//    [SVProgressHUD showWithStatus:kLocalizationMsg(@"上传中")];
    
    NSInteger type = scrollView.tag-98767;
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:5 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            switch (type) {
                case 0:
                    break;
                case 3:
                    [weakself.headFigureImageDatas addObject:imageUrl];
                    scrollView.o_imageDatas = weakself.headFigureImageDatas;
                    [scrollView reloadData];
                    break;
                case 4:
                    [weakself.detailsImageDatas addObject:imageUrl];
                    scrollView.o_imageDatas = weakself.detailsImageDatas;
                    [scrollView reloadData];
                    break;
                default:
                    break;
            }
           // NSLog(@"过滤文字imageUrl=%@"),imageUrl);
//            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传成功")];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送图片失败！")];
        }
    }];
}

- (void)clickImageView:(NSInteger)imageTag scrollView:(ZDropScrollView *)scrollView{
    
    NSInteger imageType = (scrollView.tag- 98767);
    if (imageType == 3) {  ///头图
        if (self.headFigureImageDatas.count>imageTag) {
            SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
            browser.currentImageIndex = imageTag;
            browser.tag = 98867+imageType;
            browser.sourceImagesContainerView = scrollView;
            browser.imageCount = self.headFigureImageDatas.count;
            browser.delegate = self;
            [browser show];
        }
    }else{ ///详情图
        if (self.detailsImageDatas.count>imageTag) {
            SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
            browser.currentImageIndex = imageTag;
            browser.tag = 98867+imageType;
            browser.sourceImagesContainerView = scrollView;
            browser.imageCount = self.detailsImageDatas.count;
            browser.delegate = self;
            [browser show];
        }
    }
    
}

#pragma mark - SDPhotoBrowserDelegate -
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = @"";
    if (browser.tag == 3) {  ///头图
        urlStr = [self.headFigureImageDatas[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else{ ///详情图
        urlStr = [self.detailsImageDatas[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    return [NSURL URLWithString:urlStr];
}


- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    if (browser.tag == 3) {  ///头图
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.headFigureImageDatas[index]]]];
    }else{ ///详情图
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailsImageDatas[index]]]];
    }
    
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.becomeV = textView;
    return YES;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView *hitV = [super hitTest:point withEvent:event];
//    if (hitV == _scrol || [hitV isMemberOfClass:[UIView class]]) {
//        return nil;
//    }
//    return hitV;
//}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

      NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];

      if (toString.length > 0) {

          //NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//(带正负号的)

          NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,20}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数

          NSPredicate *money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];

          BOOL flag = [money evaluateWithObject:toString];

          if (!flag) return NO;
      }
      return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.becomeV = textField;
    return YES;
}


#pragma mark scrollviewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
}


@end
