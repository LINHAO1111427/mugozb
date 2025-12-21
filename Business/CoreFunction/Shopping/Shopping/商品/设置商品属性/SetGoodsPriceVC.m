//
//  SetGoodsPriceVC.m
//  Shopping
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "SetGoodsPriceVC.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/HttpApiShopGoods.h>
#import "EditGoodsPriceView.h"
#import "KeyboardToolBar.h"

@interface SetGoodsPriceVC ()<UIScrollViewDelegate>

@property (nonatomic, weak)UIView *contentV;
@property (nonatomic, weak)UIScrollView *bgScroll;
@property (nonatomic, weak)UIView *becomeV;

@end

@implementation SetGoodsPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"编辑");
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    [self createUI];
}

- (void)tap{
    [self.view endEditing:YES];
}
- (void)setArr:(NSArray<ShopAttrComposeModel *> *)arr{
    _arr = arr;
    
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


#pragma mark - view -
- (void)createUI{
    {
        UIScrollView *bgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kScreenHeight-kNavBarHeight-kSafeAreaBottom-44)];
        bgScroll.contentSize = CGSizeMake(0, 50 + 100 * _arr.count);
        bgScroll.delegate = self;
        [self.view addSubview:bgScroll];
        self.bgScroll = bgScroll;
        
        UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [bgScroll addSubview:headV];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 20)];
        titleL.centerY = headV.height/2.0;
        titleL.textColor = kRGB_COLOR(@"#444444");
        titleL.text = kLocalizationMsg(@"价格/库存");
        [headV addSubview:titleL];
        
        UIView *linkV = [[UIView alloc] initWithFrame:CGRectMake(0, headV.height-0.5, headV.width, 0.5)];
        linkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
        [headV addSubview:linkV];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(12, 50, kScreenWidth-24, 100 * _arr.count)];
        [bgScroll addSubview:contentView];
        
        kWeakSelf(self);
        
        NSMutableArray *textFArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i< _arr.count; i++) {
            
            EditGoodsPriceView *priceV = [[EditGoodsPriceView alloc] initWithFrame:CGRectMake(0, i*100, contentView.width, 100)];
            priceV.attrModel = _arr[i];
            priceV.textFShouldBeginEditing = ^(EditGoodsPriceView * _Nonnull subView) {
                weakself.becomeV = subView;
            };
            [contentView addSubview:priceV];

            [textFArr addObject:priceV.priceTextF];
            [textFArr addObject:priceV.discountPriceTextF];
            [textFArr addObject:priceV.capacityTextF];
        }
        
        KeyboardToolBar *toolBar = [[KeyboardToolBar alloc] initWithArray:textFArr];
        [contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[EditGoodsPriceView class]]) {
                
                EditGoodsPriceView *priceView = (EditGoodsPriceView *)obj;
                
                priceView.priceTextF.inputAccessoryView = toolBar;
                priceView.capacityTextF.inputAccessoryView = toolBar;
                priceView.discountPriceTextF.inputAccessoryView = toolBar;
            }
        }];
    }

    
    {
        UIButton *previewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-44-kSafeAreaBottom-kNavBarHeight, kScreenWidth/2.0, 44)];
        previewBtn.backgroundColor = kRGB_COLOR(@"#FF8548");
        [previewBtn setTitle:kLocalizationMsg(@"上一步") forState:UIControlStateNormal];
        previewBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [previewBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:previewBtn];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2.0, kScreenHeight-44-kSafeAreaBottom-kNavBarHeight, kScreenWidth/2.0, 44)];
        addBtn.backgroundColor = kRGB_COLOR(@"#FF5500");
        [addBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addBtn];
    }
}

///上一步按钮
- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

///编辑按钮
- (void)addBtnClick:(UIButton *)btn{
    for (ShopAttrComposeModel *model in self.arr) {
        if (model.price <= 0) {
            if (model.name2.length > 0) {
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"属性(%@x%@)的价格未填写"),model.name1,model.name2]];
            }else{
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"属性(%@)的价格未填写"),model.name1]];
            }
            return;
        }
        if (model.stock <= 0) {
            if (model.name2.length > 0) {
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"属性(%@x%@)的库存为0"),model.name1,model.name2]];
            }else{
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"属性(%@)的库存为0"),model.name1]];
            }
             
            return;
        }
    }
    kWeakSelf(self);
    [HttpApiShopGoods setPriceInventory:[self.arr mutableCopy] callback:^(int code, NSString *strMsg, NSArray<ShopGoodsAttrModel *> *arr) {
        if (code == 1) {
            ShopGoodsAttrModel *model = arr.firstObject;
            NSDictionary *parameter = @{
            @"goodsId":@(model.goodsId),
            @"attribute1":weakself.attribute1.length>0?weakself.attribute1:@"",
            @"attribute2":weakself.attribute2.length>0?weakself.attribute2:@""};
//           // NSLog(@"过滤文字parameter === %@"),parameter);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goodsAttriAddSuccess" object:parameter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                if (index >= 2) {
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
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
    CGFloat newOffsetY = (self.becomeV.superview.y+ self.becomeV.maxY)- changeHeight + self.becomeV.height- 20;
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
