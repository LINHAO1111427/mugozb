//
//  GoodDetailNaviView.m
//  LibProjView
//
//  Created by klc_sl on 2021/8/2.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "GoodDetailNaviView.h"

@interface GoodDetailNaviView ()<JXCategoryViewDelegate,JXCategoryTitleViewDataSource>

@property (nonatomic, strong)NSArray* typeArr;
@property (nonatomic, weak) UIView* bgColorView;

@property (nonatomic, assign)BOOL isWriteBg; ///显示是白色主题背景 （加个判断，防止同一种类型，重复调用）


@property (nonatomic, weak)UIButton *redShopCartBtn;

@property (nonatomic, weak)UIButton *redMessageBtn;


@end

@implementation GoodDetailNaviView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    bgColorView.alpha = 0;
    [self addSubview:bgColorView];
    self.bgColorView = bgColorView;
    [bgColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    ///返回
    UIButton *backBtn = [UIButton buttonWithType:0];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [backBtn setImage:[UIImage imageNamed:@"shopping_nav_back_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 44));
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self);
    }];
    
    //消息
    UIButton *messageBtn = [UIButton buttonWithType:0];
    messageBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [messageBtn setImage:[UIImage imageNamed:@"shopping_message_white"] forState:UIControlStateNormal];
    self.messageBtn = messageBtn;
    [self addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
    }];
    UIButton *redMessageBtn = [UIButton buttonWithType:0];
    redMessageBtn.layer.cornerRadius = 6;
    redMessageBtn.clipsToBounds = YES;
    redMessageBtn.backgroundColor = [UIColor redColor];
    redMessageBtn.userInteractionEnabled = NO;
    [redMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    redMessageBtn.titleLabel.font = [UIFont systemFontOfSize:7];
    redMessageBtn.hidden = YES;
    redMessageBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    self.redMessageBtn = redMessageBtn;
    [messageBtn addSubview:redMessageBtn];
    [redMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(12);
        make.width.mas_greaterThanOrEqualTo(12);
        make.left.equalTo(messageBtn.mas_right).offset(-15);
        make.top.equalTo(messageBtn).offset(4);
    }];
    
    
    //购物车
    UIButton *shoppingCartBtn =  [UIButton buttonWithType:0];
    shoppingCartBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [shoppingCartBtn setImage:[UIImage imageNamed:@"shopping_cart_white"] forState:UIControlStateNormal];
    self.shoppingCartBtn = shoppingCartBtn;
    [self addSubview:shoppingCartBtn];
    [shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(messageBtn.mas_left).offset(-5);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
    }];
    UIButton *redShopCartBtn = [UIButton buttonWithType:0];
    redShopCartBtn.layer.cornerRadius = 6;
    redShopCartBtn.clipsToBounds = YES;
    redShopCartBtn.backgroundColor = [UIColor redColor];
    redShopCartBtn.userInteractionEnabled = NO;
    [redShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    redShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:7];
    redShopCartBtn.hidden = YES;
    redShopCartBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    [redShopCartBtn setTitle:@"0" forState:UIControlStateNormal];
    self.redShopCartBtn = redShopCartBtn;
    [shoppingCartBtn addSubview:redShopCartBtn];
    [redShopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(12);
        make.width.mas_greaterThanOrEqualTo(12);
        make.left.equalTo(shoppingCartBtn.mas_right).offset(-15);
        make.top.equalTo(shoppingCartBtn).offset(4);
    }];
    
    ///分类
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = kRGB_COLOR(@"#FF5500");
    lineView.indicatorWidth = 16.0;
    lineView.lineScrollOffsetX = 3;

    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth-200, kNavBarHeight-kStatusBarHeight)];
    titleView.centerX = kScreenWidth/2.0;
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.averageCellSpacingEnabled = YES;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = [UIFont systemFontOfSize:16];
    titleView.titleSelectedFont = [UIFont boldSystemFontOfSize:16];
    titleView.titleColor = [UIColor whiteColor];
    titleView.titleSelectedColor = [UIColor whiteColor];
    [titleView setDefaultSelectedIndex:0];
    titleView.hidden = YES;
    self.titleView = titleView;
    [self addSubview:self.titleView];
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:self.typeArr.count];
    for (NSDictionary *dic in self.typeArr) {
        [titles addObject:dic[@"title"]];
    }
    titleView.titles = titles;

}


- (void)setBgAlpha:(CGFloat)bgAlpha {
    _bgAlpha = bgAlpha;
    self.bgColorView.alpha = bgAlpha;
    [self changeNavAttribute:(bgAlpha > 0.5)?YES:NO];
}


- (NSArray *)typeArr{
    if (!_typeArr) {
        _typeArr = @[
            @{@"title":kLocalizationMsg(@"商品"),@"type":@"0"},
            @{@"title":kLocalizationMsg(@"详情"),@"type":@"1"},
            @{@"title":kLocalizationMsg(@"推荐"),@"type":@"2"}
        ];
    }
    return _typeArr;
}

///设定当前navibar的背景色 和相应的图标 isWriteBg  yes：白色背景。no 透明
- (void)changeNavAttribute:(BOOL)isWriteBg{
    if (_isWriteBg != isWriteBg) {
        _isWriteBg = isWriteBg;
        if (isWriteBg) {
            self.titleView.titleColor = kRGB_COLOR(@"#333333");
            self.titleView.titleSelectedColor = kRGB_COLOR(@"#333333");
            [self.backBtn setImage:[UIImage imageNamed:@"main_navbar_back_black"] forState:UIControlStateNormal];
            [self.shoppingCartBtn setImage:[UIImage imageNamed:@"shopping_cart_black"] forState:UIControlStateNormal];
            [self.messageBtn setImage:[UIImage imageNamed:@"shopping_message_black"] forState:UIControlStateNormal];
        }else{
            self.titleView.titleColor = [UIColor whiteColor];
            self.titleView.titleSelectedColor = [UIColor whiteColor];
            [self.backBtn setImage:[UIImage imageNamed:@"shopping_nav_back_white"] forState:UIControlStateNormal];
            [self.shoppingCartBtn setImage:[UIImage imageNamed:@"shopping_cart_white"] forState:UIControlStateNormal];
            [self.messageBtn setImage:[UIImage imageNamed:@"shopping_message_white"] forState:UIControlStateNormal];
        }
       [self.titleView reloadData];
    }
}

- (void)setShopCarNum:(int)shopCarNum{
    _shopCarNum = shopCarNum;
    NSString *showStr  = [NSString stringWithFormat:@"%d",shopCarNum];
    if (shopCarNum > 99) {
        showStr = @"+99";
    }
    [self.redShopCartBtn setTitle:showStr forState:UIControlStateNormal];
    self.redShopCartBtn.hidden = !shopCarNum;

}


- (void)setMessageNum:(int)messageNum{
    _messageNum = messageNum;
    
    NSString *showStr  = [NSString stringWithFormat:@"%d",messageNum];
    if (messageNum > 99) {
        showStr = @"+99";
    }
    [self.redMessageBtn setTitle:showStr forState:UIControlStateNormal];
    self.redMessageBtn.hidden = !messageNum;
}


- (void)setSelectTitleViewIndex:(NSInteger)selectTitleViewIndex{
    if (self.titleView.selectedIndex != selectTitleViewIndex) {
        [self.titleView selectItemAtIndex:selectTitleViewIndex];
    }
}


#pragma mark - JXCategoryTitleViewDataSource
- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title{
    CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth-150, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    return size.width*1.2+3;
    
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.didSelectItem?self.didSelectItem(index):nil;
    
    if (index == 0) {
        self.bgColorView.alpha = 0.0;
        [self changeNavAttribute:NO];
    }else{
        self.bgColorView.alpha = 1.0;
        [self changeNavAttribute:YES];
    }
    
}

@end
