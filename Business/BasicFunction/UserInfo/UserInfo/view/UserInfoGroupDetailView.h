//
//  UserInfoGroupDetailView.h
//  UserInfo
//
//  Created by shirley on 2021/12/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UserInfoGroupDetailView : UIView

@end


@interface  EditUserInfoListModel: NSObject
@property (nonatomic, assign)int type;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *placeHolder;
@property (nonatomic, assign)BOOL isReauired;
@property (nonatomic, assign)int limit;
@end



@interface  EditUserListSectionModel: NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSArray<EditUserInfoListModel*> *list;
@end




////用户信息  --  群组标题
@interface UserInfoGroupTitleView : UIView

@property (nonatomic, weak)UILabel *sectionL;
///当前View高
+ (CGFloat)viewHeight;

@end


////用户信息  --  cell
@interface EditUserInfoListCell : UITableViewCell

@property (nonatomic, weak)UILabel *requiredStar;
@property (nonatomic, weak)UIImageView *moreImageV;
@property (nonatomic, weak)UILabel *titleL;//标题
@property (nonatomic, weak)UITextField *contentL;//内容


@property (nonatomic, weak)EditUserInfoListModel *model;
@property (nonatomic, assign)BOOL isRequired;//是否必须


///当前cell高
+ (CGFloat)cellHeight;


@end




NS_ASSUME_NONNULL_END
