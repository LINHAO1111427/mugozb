//
//  PlayPromptView.h
//
//  Created by Mac on 2018/12/12.
//  Copyright © 2018年 ytsr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayPromptView : UIView


-(instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)color;

-(void)statAnimation;
    
-(void)endAnimation;


@end

NS_ASSUME_NONNULL_END
