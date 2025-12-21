//
//  TiUIMeiZhuangViewCell.h
//  TiFancy
//
//  Created by MBP DA1003 on 2019/8/3.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface TiUIMeiZhuangViewCell : UICollectionViewCell

@property(nonatomic,strong)TIMenuMode *subMod;

-(void)setCellTypeBorderIsShow:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
