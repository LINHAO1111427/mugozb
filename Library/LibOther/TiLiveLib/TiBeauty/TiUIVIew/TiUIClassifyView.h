//
//  TiUIClassifyView.h
//  TiFancy
//
//  Created by iMacA1002 on 2019/4/26.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TiUIClassifyView : UIView


@property (nonatomic, assign)NSInteger selectIndex;


@property (copy, nonatomic)void(^clickOnTheClassificationBlock)(NSArray * classifyArr);

@end

NS_ASSUME_NONNULL_END
