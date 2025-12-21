//
//  SetGoodsAttributeVC.m
//  Shopping
//
//  Created by klc_sl on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "SetGoodsAttributeVC.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import "SetGoodsShowView.h"
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjModel/ShopAttrValueModel.h>
#import <LibProjModel/ShopAttrValueModel.h>
#import "SetGoodsPriceVC.h"

#define kMaxAttrCount 20 // 最大属性数

@interface SetGoodsAttributeVC ()<UIGestureRecognizerDelegate, UIScrollViewDelegate,UITextFieldDelegate>

@property (nonatomic, assign)CGFloat headerHeight;
@property (nonatomic, weak)UIScrollView *bgScroll;
 
@property (nonatomic, weak)UIView *becomeV;

@property (nonatomic, assign)int64_t attrOneId;  ///属性1id
@property (nonatomic, assign)int64_t attrTwoId;  ///属性2id

@property (nonatomic, strong)UIView *oneBgView;   ///第一个属性视图
@property (nonatomic, strong)UIView *twoBgView;   ///第二个属性视图

@property (nonatomic, strong)UIView *oneContentV;
@property (nonatomic, strong)UIView *twoContentV;

@property (nonatomic, copy)NSString *attOneName;  ///第一个属性
@property (nonatomic, copy)NSString *attTwoName;  ///第二个属性

@property (nonatomic, strong)NSArray<ShopGoodsAttrDTOModel *> *attriArr;

@end

@implementation SetGoodsAttributeVC

- (NSArray<ShopGoodsAttrDTOModel *> *)attriArr{
    if (!_attriArr) {
        _attriArr = [NSArray array];
    }
    return _attriArr;
}
- (void)dealloc
{
   // NSLog(@"过滤文字-------%s-------"),__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"商品属性");
    if (self.goodsId > 0) {
        [self getAttributeData];
    }else{
        [self createBaseView];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}
- (void)tap{
    [self.view endEditing:YES];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self keyboardNotification:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self keyboardNotification:NO];
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

- (void)getAttributeData{
    kWeakSelf(self);
    [HttpApiShopGoods getArrDetailList:self.goodsId callback:^(int code, NSString *strMsg, NSArray<ShopGoodsAttrDTOModel *> *arr) {
        if (code == 1) {
           // NSLog(@"过滤文字xxxxxxxxxxxxxxxxx获取属性xxxxxxxxxxxxxxxxxxxxxxx"));
            if (arr.count > 0) {
                weakself.attriArr = arr;
                ShopGoodsAttrDTOModel *model1 = arr.firstObject;
                weakself.attrOneId = model1.attrId;
                weakself.attOneName = model1.attrName;
                if (arr.count > 1) {
                    ShopGoodsAttrDTOModel *model2 = arr.lastObject;
                    weakself.attrTwoId = model2.attrId;
                    weakself.attTwoName = model2.attrName;
                }
            }
            [weakself createBaseView];
        }else{
            [weakself createBaseView];
            if (code == 2) {///当前商品没设置属性
                
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }
    }];
}
#pragma mark - 点击编辑价格和库存 -
- (void)addBtnClick:(UIButton *)btn{
    BOOL hasAttr1 = NO;
    if (_oneContentV) {
        hasAttr1 = YES;
         //属性1
         if (_attOneName.length == 0) {
             [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入属性1的名称")];
             return;
         }
         
         NSString *arr1Str = [self getAttrContentStr:_oneContentV];
         if (arr1Str.length == 0) {
             [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请添加属性1的属性值")];
             return;
         }
         BOOL haveSameAttriOne = [self sameAttributeJuge:_oneContentV];
         if (haveSameAttriOne) {
              [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"属性1中包含相同的属性值")];
              return;
         }
    }
     
    ///是否有属性二
    BOOL hasAttr2 = NO;
    if (_twoContentV) {
        hasAttr2 = YES;
        
        if (_attTwoName.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入属性2的名称")];
            return;
        }

        NSString *arr2Str = [self getAttrContentStr:_twoContentV];
        if (arr2Str.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请添加属性2的属性值")];
            return;
        }
        if ([_attOneName isEqualToString:_attTwoName]) {
             [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"属性名称不能相同")];
             return;
        }
        BOOL haveSameAttriTwo = [self sameAttributeJuge:_twoContentV];
        if (haveSameAttriTwo) {
             [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"属性2中包含相同的属性值")];
             return;
        }
    }
   
    if (!hasAttr1 && !hasAttr2) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请添加属性")];
        return;
    }
     
    
    ///请求参数
    NSMutableArray *attrMuArr = [[NSMutableArray alloc] init];
    ///第一个属性
    ShopGoodsAttrCompositeModel *attr1Model = [[ShopGoodsAttrCompositeModel alloc] init];
    ///属性名
    ShopGoodsAttrModel* shopGoodsAttr = [[ShopGoodsAttrModel alloc] init];
    shopGoodsAttr.name = _attOneName;
    shopGoodsAttr.goodsId = _goodsId;
    shopGoodsAttr.id_field = self.attrOneId > 0?self.attrOneId :0;

    ///属性参数
    NSMutableArray *attr1 = [[NSMutableArray alloc] init];
    for (SetGoodsShowView *goodV in _oneContentV.subviews) {
        if (goodV.attrStr.length > 0) {
            ShopAttrValueModel *valueModel = [[ShopAttrValueModel alloc] init];
            valueModel.attributeId = _attrOneId;
            valueModel.goodsId = _goodsId;
            valueModel.id_field = goodV.attrValueId;
            valueModel.name = goodV.attrStr;
            [attr1 addObject:valueModel];
        }
    }
    
    attr1Model.shopGoodsAttr = shopGoodsAttr;
    attr1Model.shopAttrValues = attr1;
    [attrMuArr addObject:attr1Model];
    if (attr1.count > kMaxAttrCount) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"属性1的属性值不能超过20个")];
        return;
    }
    
    if (hasAttr2) {
        ///第二个属性
        ShopGoodsAttrCompositeModel *attr2Model = [[ShopGoodsAttrCompositeModel alloc] init];
        ///属性名
        ShopGoodsAttrModel* shopGoodsAttr = [[ShopGoodsAttrModel alloc] init];
        shopGoodsAttr.name = _attTwoName;
        shopGoodsAttr.id_field = self.attrTwoId > 0?self.attrTwoId :0;
        shopGoodsAttr.goodsId = _goodsId;

        ///属性参数
        NSMutableArray *attr2 = [[NSMutableArray alloc] init];
        for (SetGoodsShowView *goodV in _twoContentV.subviews) {
            if (goodV.attrStr.length > 0) {
                ShopAttrValueModel *valueModel = [[ShopAttrValueModel alloc] init];
                valueModel.attributeId = _attrTwoId;
                valueModel.goodsId = _goodsId;
                valueModel.name = goodV.attrStr;
                valueModel.id_field = goodV.attrValueId;
                [attr2 addObject:valueModel];
            }
        }
        attr2Model.shopGoodsAttr = shopGoodsAttr;
        attr2Model.shopAttrValues = attr2;
        [attrMuArr addObject:attr2Model];
        if (attr2.count > kMaxAttrCount) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"属性2的属性值不能超过20个")];
            return;
        }
    }
    for (ShopGoodsAttrCompositeModel *com in attrMuArr) {
       // NSLog(@"过滤文字属性 === %@  id === %lld"),com.shopGoodsAttr.name,com.shopGoodsAttr.id_field);
        for (ShopAttrValueModel *mooo in com.shopAttrValues) {
           // NSLog(@"过滤文字属性值 === %@  id === %lld"),mooo.name,mooo.id_field);
        }
    }
    kWeakSelf(self);
    if (self.isModify && self.goodsId > 0) {
        [HttpApiShopGoods updateAttribute:self.goodsId shopGoodsAttrCompositeEntities:attrMuArr callback:^(int code, NSString *strMsg, NSArray<ShopAttrComposeModel *> *arr) {
            if (code == 1) {
                if (arr.count == 0) {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"数据错误")];
                }else{
                    for (ShopAttrComposeModel *oos in arr) {
                       // NSLog(@"过滤文字price === %.1f"),oos.price);
                    }
                    [weakself nextEditeWith:arr];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        [HttpApiShopGoods createAttribute:_goodsId shopGoodsAttrCompositeEntities:attrMuArr callback:^(int code, NSString *strMsg, NSArray<ShopAttrComposeModel *> *arr) {
            if (code == 1) {
                if (arr.count == 0) {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"数据错误")];
                }else{
                    [weakself nextEditeWith:arr];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
 

- (void)nextEditeWith:(NSArray<ShopAttrComposeModel *>*)arr{
    ShopAttrComposeModel *model = arr.firstObject;
    self.goodsId = model.goodsId;
    self.attrOneId = model.attribute1Id;
    self.attrTwoId = model.attribute2Id;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SetGoodsPriceVC *goodsPriceVC = [[SetGoodsPriceVC alloc]init];
        goodsPriceVC.attribute1 = self.attOneName;
        goodsPriceVC.attribute2 = self.attTwoName;
        goodsPriceVC.arr = arr;
        [self.navigationController pushViewController:goodsPriceVC animated:YES];
    });
}


#pragma mark - View -

- (void)createBaseView{
    _headerHeight = 50;
    
    {
        UIScrollView *bgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kScreenHeight-kNavBarHeight-kSafeAreaBottom-44)];
        bgScroll.delegate = self;
        bgScroll.contentSize = CGSizeMake(0, self.view.height);
        [self.view addSubview:bgScroll];
        self.bgScroll = bgScroll;
        
        ///第一个属性
        UIView *oneV = [[UIView alloc] init];
        [bgScroll addSubview:oneV];
        _oneBgView = oneV;
        
        ///第二个属性
        UIView *twoV = [[UIView alloc] init];
        [bgScroll addSubview:twoV];
        _twoBgView = twoV;
        
        
        UIView *linkV = [[UIView alloc] init];
        linkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
        [bgScroll addSubview:linkV];
        
        UIButton *btn = [UIButton buttonWithType:0];
        [btn setTitle:kLocalizationMsg(@"+ 点击添加更多商品属性") forState:UIControlStateNormal];
        [btn setTitleColor:kRGB_COLOR(@"#FF8503") forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(addAttriBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgScroll addSubview:btn];
        
        [oneV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgScroll);
            make.centerX.equalTo(self.view);
            make.width.mas_equalTo(self.view.width-24);
            make.height.mas_equalTo(150.0);
            make.bottom.equalTo(twoV.mas_top);
        }];
        [oneV layoutIfNeeded];
        [twoV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(oneV);
            make.width.mas_equalTo(oneV.width);
            make.height.mas_equalTo(0.1);
            make.bottom.equalTo(linkV.mas_top);
        }];
        [twoV layoutIfNeeded];
        [linkV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(btn.mas_top);
        }];
        [linkV layoutIfNeeded];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(linkV.mas_bottom);
            make.left.equalTo(oneV);
            make.height.mas_equalTo(46);
            make.bottom.equalTo(bgScroll).mas_offset(-50);
        }];
        [btn layoutIfNeeded];
        
        [self createSubView:oneV title:kLocalizationMsg(@"属性1") type:0];
        
        if (self.attTwoName.length > 0) {
            [self addAttriBtnClick:btn];
        }
    }
    
    {
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-44-kNavBarHeight-kSafeAreaBottom, self.view.width, 44)];
        addBtn.backgroundColor = kRGB_COLOR(@"#FF5500");
        [addBtn setTitle:kLocalizationMsg(@"编辑价格/库存") forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addBtn];
    }
    
     
}

- (BOOL)sameAttributeJuge:(UIView *)superView{
    NSMutableString *muStr = [[NSMutableString alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *compareArr = [NSMutableArray array];
    for (SetGoodsShowView *goodV in superView.subviews) {
        if ([goodV.attrStr length]) {
            [muStr appendFormat:@"%@,",goodV.attrStr];
            [compareArr addObject:goodV.attrStr];
            [dic setObject:goodV.attrStr forKey:goodV.attrStr];
        }
    }
    if (dic.allValues.count != compareArr.count) {
        dic = nil;
        compareArr = nil;
        return YES;
    }
    return NO;
}

- (NSString *)getAttrContentStr:(UIView *)superView{
    NSMutableString *muStr = [[NSMutableString alloc] init];
     
    for (SetGoodsShowView *goodV in superView.subviews) {
        if ([goodV.attrStr length]) {
            [muStr appendFormat:@"%@,",goodV.attrStr];
           // NSLog(@"过滤文字attrr === %@"),goodV.attrStr);
        }
    }
    if (muStr.length >= 2) {
        [muStr substringToIndex:muStr.length-2];
    }
    return muStr;
}


- (void)addAttriBtnClick:(UIButton *)addBtn{
    addBtn.hidden = YES;
    [self createSubView:_twoBgView title:kLocalizationMsg(@"属性2") type:1];
}


- (void)createSubView:(UIView *)superV title:(NSString *)title type:(int)type{
     
    superV.clipsToBounds = YES;
    superV.layer.masksToBounds = YES;
    
    ///头部视图
    UIView *headerBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, superV.width, _headerHeight)];
    [superV addSubview:headerBgV];
    
    ///内容按钮
    UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, _headerHeight, superV.width, 300)];
    [superV addSubview:contentV];
    type?(_twoContentV = contentV):(_oneContentV = contentV);
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 60, 20)];
    nameL.centerY = headerBgV.height/2.0;
    nameL.text = [NSString stringWithFormat:@"%@:",title];
    nameL.textColor = [UIColor blackColor];
    nameL.font = [UIFont systemFontOfSize:14];
    [headerBgV addSubview:nameL];
    
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, headerBgV.width-80-20, headerBgV.height)];
    textF.centerY = nameL.centerY;
    textF.font = [UIFont systemFontOfSize:14];
    textF.delegate = self;
    textF.tag = 99167 + type;
    if (type == 0) {
        textF.text = self.attOneName;
    }else{
        textF.text = self.attTwoName;
    }
    textF.placeholder = kLocalizationMsg(@"请输入属性名称");
    [textF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
    [headerBgV addSubview:textF];
    
    UIView *linkV = [[UIView alloc] initWithFrame:CGRectMake(0, headerBgV.height-0.5, headerBgV.width, 0.5)];
    linkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [headerBgV addSubview:linkV];
    
    ///添加新按钮
    kWeakSelf(self);
    SetGoodsShowView *add = [[SetGoodsShowView alloc] initWithFrame:CGRectMake(0, 10, (contentV.width-2)/2.0, 45) isAdd:YES];
    [contentV addSubview:add];
    add.textFShouldBeginEditing = ^(SetGoodsShowView * _Nonnull subView) {
        weakself.becomeV = subView;
    };
    add.addBtnClick = ^{
        [weakself addOneItemViewForSuperView:contentV attriStr:@"" valueId:0];
    };
    if (self.attriArr.count > 0) {
        ShopGoodsAttrDTOModel *model;
         if (type == 0) {
            model = self.attriArr.firstObject;
         }else{
            model = self.attriArr.lastObject;
         }
        for (ShopAttrValueModel *mod in model.attrValueList) {
            [self addOneItemViewForSuperView:contentV attriStr:mod.name valueId:mod.id_field];
        }
    }
     
    contentV.height = add.maxY+24;
    [contentV.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_headerHeight + contentV.height);
    }];

}


- (void)addOneItemViewForSuperView:(UIView *)superView attriStr:(NSString *)attr valueId:(int64_t)valueId{
 
    if (superView.subviews.count > kMaxAttrCount) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"属性值不能超过20个")];
        return;
    }
    
    [self.view endEditing:YES];
    
    __block UIView *superV = superView;
    
    kWeakSelf(self);
    CGPoint nextPoint = CGPointMake(0, 10);
    
    ///添加的按钮
    UIView *addV = superView.subviews.firstObject;
    
    ///除添加视图以外的视图
    NSMutableArray *subViews = [NSMutableArray arrayWithArray:superView.subviews];
    [subViews removeObjectAtIndex:0];
    
    ///重新调整
    for (NSInteger i = 0; i< subViews.count; i++) {
        
        UIView *subV = subViews[i];
        CGRect rc = subV.frame;
        rc.origin.x = nextPoint.x;
        rc.origin.y = nextPoint.y;
        subV.frame = rc;
        nextPoint = [self getSubViewsNextPoint:nextPoint nextIndex:i+1 itemSize:subV.size];
    }
    
    SetGoodsShowView *attrV = [[SetGoodsShowView alloc] initWithFrame:CGRectMake(nextPoint.x, nextPoint.y, addV.width, addV.height) isAdd:NO];
    attrV.attrValueId = valueId > 0?valueId:0;
    [superV addSubview:attrV];
    if (attr.length > 0) {
        attrV.attrStr = attr;
    }
    nextPoint = [self getSubViewsNextPoint:nextPoint nextIndex:subViews.count+1 itemSize:addV.size];
    kWeakSelf(attrV);
    attrV.delBtnClick = ^{
        [weakself removeSubViews:weakattrV superView:superV];
    };
    attrV.textFShouldBeginEditing = ^(SetGoodsShowView * _Nonnull subView) {
        weakself.becomeV = subView;
    };
    ///添加按钮的尺寸
    addV.frame = CGRectMake(nextPoint.x, nextPoint.y, addV.width, addV.height);
    
    superView.height = addV.maxY+24;
    [superView.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_headerHeight + superView.height);
    }];
    
}

- (CGPoint)getSubViewsNextPoint:(CGPoint)currentPoint nextIndex:(NSInteger)index itemSize:(CGSize)size{
    
    CGFloat space = 1;
    CGPoint nextPoint;
    if (index%2) {
        nextPoint = CGPointMake(size.width+2, currentPoint.y);
    }else{
        nextPoint = CGPointMake(0, 10+ (index+1)/2 * (size.height + space));
    }
    return nextPoint;
}

- (void)removeSubViews:(SetGoodsShowView *)showV superView:(UIView *)superView{
    
    [self.view endEditing:YES];

    [superView.subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == showV) {
            [obj removeFromSuperview];
            obj = nil;
            *stop = nil;
        }
    }];
    
    
    CGPoint nextPoint = CGPointMake(0, 10);

    ///添加的按钮
    UIView *addV = superView.subviews.firstObject;
    ///除添加视图以外的视图
    NSMutableArray *subViews = [NSMutableArray arrayWithArray:superView.subviews];
    [subViews removeObjectAtIndex:0];
    
    for (NSInteger i = 0; i< subViews.count; i++) {
        UIView *subV = subViews[i];
        CGRect rc = subV.frame;
        rc.origin.x = nextPoint.x;
        rc.origin.y = nextPoint.y;
        subV.frame = rc;
        nextPoint = [self getSubViewsNextPoint:nextPoint nextIndex:i+1 itemSize:subV.size];
    }

    ///添加按钮的尺寸
    addV.frame = CGRectMake(nextPoint.x, nextPoint.y, addV.width, addV.height);
    
    superView.height = addV.maxY+24;
    [superView.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_headerHeight + superView.height);
    }];
}


- (void)textValueChange:(UITextField *)textF{
    switch (textF.tag - 99167) {
        case 1:   ///属性二名称
        {
            _attTwoName = textF.text;
        }
            break;
        default:  ///属性一名称
        {
            _attOneName = textF.text;
        }
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.becomeV = textField;
    return YES;
}


#pragma mark - UIScrollViewDelegate -
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


#pragma mark -- 获取键盘高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat changeHeight =  kScreenHeight-kNavBarHeight-keyboardRect.size.height;
    CGFloat newOffsetY = (self.becomeV.superview.superview.y+self.becomeV.superview.y+ self.becomeV.maxY)- changeHeight + self.becomeV.height;
    newOffsetY = MAX(newOffsetY, 0);
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        weakself.bgScroll.height =  changeHeight;
        weakself.bgScroll.contentOffset = CGPointMake(0, newOffsetY);
    }];
}


- (void)keyboardWillHide:(NSNotification *)aNotification
{   NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        weakself.bgScroll.height = kScreenHeight-kNavBarHeight-kSafeAreaBottom-44;
    }];
}


@end
