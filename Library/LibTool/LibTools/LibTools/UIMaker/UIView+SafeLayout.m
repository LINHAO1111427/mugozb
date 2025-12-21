//
//  UIView+SafeLayout.m
//  LibTools
//
//  Created by klc on 2020/8/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UIView+SafeLayout.h"


@implementation UIView (SafeLayout)

- (MASViewAttribute *)zh_safe_top{
    
    isOS_11(self.mas_safeAreaLayoutGuideTop, self.mas_top)
}
- (MASViewAttribute *)zh_safe_bottom{
    
    isOS_11(self.mas_safeAreaLayoutGuideBottom, self.mas_bottom)
}
- (id)zh_safe_edges{

    isOS_11(self.mas_safeAreaLayoutGuide, self)
}
@end
