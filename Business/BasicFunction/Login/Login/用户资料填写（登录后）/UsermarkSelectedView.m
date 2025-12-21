//
//  UsermarkSelectedView.m
//  Login
//
//  Created by klc on 2020/4/25.
//

#import "UsermarkSelectedView.h"
#import <LibTools/LibTools.h>
@interface UsermarkSelectedView()

@property (strong, nonatomic) UILabel *titleLabel;
@property (copy, nonatomic) void(^callBack)(TabInfoDtoModel *model,BOOL selected);
@end
@implementation UsermarkSelectedView

- (instancetype)initWithFrame:(CGRect)frame callBlock:(void (^)(TabInfoDtoModel *model,BOOL selected))callback{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.callBack = callback;
        [self viewSetUp];
    }
    return self;
}

- (void)viewSetUp{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.width, self.height-10)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.layer.cornerRadius = 15;
    titleLabel.clipsToBounds = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    if (self.selected) {
        titleLabel.textColor = kRGB_COLOR(_tabModel.fontColor);
        titleLabel.backgroundColor = kRGBA_COLOR(_tabModel.fontColor, 0.3);
    }else{
        titleLabel.textColor = kRGB_COLOR(@"#888888");
        titleLabel.backgroundColor = kRGBA_COLOR(@"#F6F6F6", 1.0);
    }
    self.titleLabel = titleLabel;
    [self addSubview:self.titleLabel];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:self.bounds];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (self.selected) {
        self.titleLabel.textColor = kRGB_COLOR(_tabModel.fontColor);
        self.titleLabel.backgroundColor = kRGBA_COLOR(_tabModel.fontColor, 0.3);
    }else{
        self.titleLabel.textColor = kRGB_COLOR(@"#888888");
        self.titleLabel.backgroundColor = kRGBA_COLOR(@"#F6F6F6", 1.0);
    }

}
- (void)btnClick:(UIButton *)btn{
    self.selected = !self.selected;
     
    self.callBack(self.tabModel, self.selected);
}
- (void)setTabModel:(TabInfoDtoModel *)tabModel{
    _tabModel = tabModel;
    self.titleLabel.text = tabModel.name;
    
}
@end
