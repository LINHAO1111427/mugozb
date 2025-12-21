//
//  AddWishItemCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUsersLiveWishModel;
@interface AddWishItemCell : UICollectionViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *giftIcon;
@property (weak, nonatomic) IBOutlet UILabel *giftNameL;
@property (weak, nonatomic) IBOutlet UITextField *numTextF;
@property (weak, nonatomic) IBOutlet UIButton *subBtn; //数量减按钮
@property (weak, nonatomic) IBOutlet UIButton *addBtn; ///数量加按钮
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, assign)BOOL isAdd;

@property (nonatomic, strong)ApiUsersLiveWishModel *wishModel;

///展示心愿单视图
@property (weak, nonatomic) IBOutlet UIView *showBgView;
@property (copy, nonatomic) void(^removeGiftBtnBlock)(ApiUsersLiveWishModel *wishModel);


///添加视图
@property (weak, nonatomic) IBOutlet UIView *addBgView;
@property (copy, nonatomic) void(^addGiftBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
