//
//  SWHTapImage.h
//  LibProjView
//
//  Created by SWH05 on 2022/3/23.
//  Copyright © 2022 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWHTapImageView : UIImageView
@property(nonatomic,assign)int type;
@property (nonatomic, copy) void (^btnClick)(int type);
@end

NS_ASSUME_NONNULL_END
