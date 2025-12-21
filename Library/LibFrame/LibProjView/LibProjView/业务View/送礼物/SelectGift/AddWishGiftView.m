//
//  AddWishGiftView.m
//  MPVideoLive
//
//  Created by admin on 2019/8/2.
//  Copyright © 2019 cat. All rights reserved.
//

#import "AddWishGiftView.h"

#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryIndicatorImageView.h>
#import <JXCategoryView/JXCategoryListContainerView.h>
#import <LibProjView/GiftListShowView.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

#import <LibProjModel/NobLiveGiftModel.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjView/FunctionSheetBaseView.h>


@interface AddWishGiftView ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,GiftListShowViewDelegate>

@property (nonatomic, weak)JXCategoryTitleView *titleV;
@property (nonatomic, weak)UITextField *giftCountTextF;   //选择数量按钮

@property (nonatomic, copy)NSArray *giftList; ///礼物列表
///确认按钮的文字
@property (nonatomic, copy)NSString *sureTitle;

@property (nonatomic, strong)NobLiveGiftModel *selectGiftModel;  //选择的礼物
@property(nonatomic, assign)int giftCount;   //礼物个数
@property(nonatomic, assign)BOOL canSelectGiftNum;   //是否可以选择数量
@property (nonatomic, copy)void (^selectGiftBlock)(NobLiveGiftModel * _Nonnull, int);


@end

@implementation AddWishGiftView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


+ (void)addWishGift:(BOOL)canSelectGiftNum sureTitle:(NSString *)sureTitle selectGiftBack:(void (^)(NobLiveGiftModel * _Nonnull, int))giftBlock {
    AddWishGiftView *gift = [[AddWishGiftView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 335)];
    gift.canSelectGiftNum = canSelectGiftNum;
    gift.sureTitle = sureTitle;
    gift.selectGiftBlock = giftBlock;
    [gift createGiftView];
}


- (void)createGiftView{

    self.backgroundColor = kRGBA_COLOR(@"#151015", 0.86);

    JXCategoryTitleView *titleV = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 20, self.width-50, 25)];
    titleV.delegate = self;
    titleV.cellSpacing = 20;
    titleV.contentEdgeInsetLeft = 15;
    titleV.contentEdgeInsetRight = 15;
    titleV.titleFont = [UIFont systemFontOfSize:13];
    titleV.titleSelectedFont = [UIFont systemFontOfSize:14];
    titleV.titleColor = [UIColor whiteColor];
    titleV.titleSelectedColor = [ProjConfig normalColors];
    titleV.averageCellSpacingEnabled = NO;
    [self addSubview:titleV];
    _titleV = titleV;
    
    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"btn_bg_pink"];
    indicatorImageView.indicatorCornerRadius = 1.5;
    indicatorImageView.indicatorImageView.clipsToBounds = YES;
    indicatorImageView.indicatorImageView.layer.cornerRadius = 1.5;
    indicatorImageView.indicatorImageView.layer.masksToBounds = YES;
    indicatorImageView.indicatorImageViewSize = CGSizeMake(10, 3);
    titleV.indicators = @[indicatorImageView];
    
    JXCategoryListContainerView *containerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    containerView.frame = CGRectMake(0, titleV.maxY+20, self.width, 230);
    containerView.scrollView.scrollEnabled = NO;
    [self addSubview:containerView];
    self.titleV.listContainer = containerView;
    [containerView reloadData];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gift_select_line"]];
    bottomLine.frame = CGRectMake(15, containerView.maxY, self.width-30, 10);
    [self addSubview:bottomLine];
    
    ///发送UI
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, bottomLine.maxY, self.width, 50)];
    [self addSubview:bottomV];
    //赠送按钮
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(bottomV.width-20-60, (bottomV.height-30)/2.0, 60, 30);
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 15;
    [sendBtn setTitle:self.sureTitle forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(btnClickSendData) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:sendBtn];
    
    //数量
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(sendBtn.x-35-15, sendBtn.y, 35, 30)];
    textF.keyboardType = UIKeyboardTypeNumberPad;
    textF.font = [UIFont systemFontOfSize:13];
    textF.textColor = [UIColor whiteColor];
    textF.backgroundColor = kRGBA_COLOR(@"#4D324C", 1.0);
    textF.textAlignment = NSTextAlignmentCenter;
    textF.text = @"1";
    textF.layer.masksToBounds = YES;
    textF.layer.cornerRadius = 5;
    [textF addTarget:self action:@selector(textFieldsEditingChange:) forControlEvents:UIControlEventEditingChanged];
    [bottomV addSubview:textF];
    _giftCountTextF = textF;

    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(textF.x-30-7, 0, 30, 19)];
    numLab.centerY = textF.centerY;
    numLab.text = kLocalizationMsg(@"数量");
    numLab.textAlignment = NSTextAlignmentRight;
    numLab.font = [UIFont systemFontOfSize:13];
    numLab.textColor = [UIColor whiteColor];
    [bottomV addSubview:numLab];
    
    ///是否可以选择
    {
        textF.hidden = !self.canSelectGiftNum;
        numLab.hidden = !self.canSelectGiftNum;
    }

    self.height = bottomV.maxY;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillChange:) name:UIKeyboardWillHideNotification object:nil];
    
    [FunctionSheetBaseView showView:self cover:NO];
    [self loadGiftData];
}


///键盘弹起降下
- (void)keyBoardFrameWillChange:(NSNotification *)notify{
    UIView *superV = self.superview;
    CGRect keyBoardRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        CGRect rc = superV.frame;
        rc.origin.y = (keyBoardRc.origin.y < kScreenHeight)?(keyBoardRc.origin.y-rc.size.height):(kScreenHeight-rc.size.height);
        superV.frame = rc;
    }];
}

///加载礼物数据
- (void)loadGiftData{
    kWeakSelf(self);
    [HttpApiNobLiveGift getGiftList:-1 callback:^(int code, NSString *strMsg, NSArray<ApiNobLiveGiftModel *> *arr) {
        if (code == 1) {
            [weakself showData:arr];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///添加
- (void)btnClickSendData{
    if (_selectGiftModel && _selectGiftBlock) {
        _selectGiftBlock(_selectGiftModel,[_giftCountTextF.text intValue]);
        [FunctionSheetBaseView deletePopView:self];
    }
}

- (void)textFieldsEditingChange:(UITextField *)textF{
    if (textF.text.length>3) {
        textF.text = [textF.text substringToIndex:3];
    }
}


- (void)showData:(NSArray<ApiNobLiveGiftModel *> *)giftModels{
    _giftList = giftModels;
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (ApiNobLiveGiftModel *subGiftModel in giftModels) {
        [titles addObject:subGiftModel.giftTypeName];
    }
    self.titleV.titles = titles;
    [self.titleV reloadData];
    [self.titleV.listContainer reloadData];
}


#pragma mark -GiftListShowViewDelegate,JXCategoryViewDelegate-
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    
}

- (void)giftListView:(GiftListShowView *)listView selectGift:(NobLiveGiftModel *_Nullable)gift giftType:(int)giftType{
    self.selectGiftModel = gift;
}

#pragma mark -JXCategoryListContainerViewDelegate-

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return _giftList.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    ApiNobLiveGiftModel *giftModel = _giftList[index];
    GiftListShowView *giftV = [[GiftListShowView alloc] initWithFrame:CGRectMake(0, 0, listContainerView.width, listContainerView.height) defaultGiftId:0];
    giftV.selectWish = YES;
    giftV.delegate = self;
    giftV.giftListModel = giftModel;
    return giftV;
}

@end
