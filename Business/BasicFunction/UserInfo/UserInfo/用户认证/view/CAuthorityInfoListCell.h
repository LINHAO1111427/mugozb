//
//  CAuthorityInfoListCell.h
//  MineCenter
//
//  Created by klc_sl on 2021/11/9.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface  CAuthorityInfoListModel: NSObject
@property (nonatomic, assign)int type;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *placeHolder;
@property (nonatomic, assign)BOOL isReauired;
@end

@interface  CAuthorityInfoListSectionModel: NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSArray<CAuthorityInfoListModel*> *list;
@end


@interface CAuthorityInfoListCell : UITableViewCell

@property (nonatomic, assign)BOOL isRequired;//是否必须
@property (nonatomic, strong)UILabel *requiredStar;
@property (nonatomic, strong)UIImageView *moreImageV;
@property (nonatomic, strong)UILabel *titleL;//标题
@property (nonatomic, strong)UITextField *contentL;//内容
@property (nonatomic, strong)CAuthorityInfoListModel *model;

@end

NS_ASSUME_NONNULL_END
