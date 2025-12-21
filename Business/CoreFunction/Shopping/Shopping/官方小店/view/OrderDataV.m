//
//  OrderDataV.m
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDataV.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjView/CustomBRPickerView.h>

@interface OrderDataV()
@property (nonatomic, strong)UILabel *orderNumL;//订单数量
@property (nonatomic, strong)UILabel *amountNumL;//订单金额
@property (nonatomic, strong)UILabel *incomeL;//卖货收入
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, strong)UILabel *lookL;
@end

@implementation OrderDataV
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[kLocalizationMsg(@"今日"),kLocalizationMsg(@"昨日"),kLocalizationMsg(@"本周"),kLocalizationMsg(@"上周"),kLocalizationMsg(@"上月")];
    }
    return _dataArray;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 100, 30)];
    titleL.text = kLocalizationMsg(@"订单数据");
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:titleL];
    
    NSMutableAttributedString *attristr = [[NSMutableAttributedString alloc]initWithString:kLocalizationMsg(@"今日")];
    NSTextAttachment *attachMent = [[NSTextAttachment alloc]init];
    attachMent.image = [UIImage imageNamed:@"map_location_down"];
    attachMent.bounds = CGRectMake(0, -2, 14, 14);
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachMent];
    [attristr insertAttributedString:imageStr atIndex:attristr.length];
    
    UILabel *lookL = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 145, 5, 130, 30)];
    lookL.attributedText = attristr;
    lookL.textColor = kRGB_COLOR(@"#999999");
    lookL.textAlignment = NSTextAlignmentRight;
    lookL.font = [UIFont systemFontOfSize:12];
    self.lookL = lookL;
    [self addSubview:self.lookL];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(lookL.x, 0, lookL.width, 40)];
    [btn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    
    UIView *linkView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.width, 0.3)];
    linkView.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self addSubview:linkView];
    
    [self updateFeaturesView];
    
}

- (void)updateFeaturesView{
    
    NSArray *titleArr = @[@{@"title":kLocalizationMsg(@"订单数量"),@"type":@"1"},
                          @{@"title":kLocalizationMsg(@"订单金额"),@"type":@"2"},
//                          @{@"title":kLocalizationMsg(@"卖货收入"),@"type":@"3"},
    ];
    
    UIView *featuresView = [[UIView alloc]initWithFrame:CGRectMake(10, 55, self.width - 20, self.height - 55 -15)];
    featuresView.backgroundColor = [UIColor clearColor];
    [self addSubview:featuresView];
    
    
    CGFloat width = (featuresView.width)/titleArr.count;
    
    for (int i = 0; i < titleArr.count; i++) {
        NSDictionary *subDic = titleArr[i];

        UIView *subV = [[UIView alloc]initWithFrame:CGRectMake(i*width, 0 , width, featuresView.height)];
        subV.backgroundColor = [UIColor whiteColor];
        [featuresView addSubview:subV];
        
        UILabel *countLable= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, subV.width , subV.height - 28)];
        countLable.text = @"0";
        countLable.textAlignment = NSTextAlignmentCenter;
        countLable.textColor = kRGB_COLOR(@"#FF5500");
        countLable.font = [UIFont boldSystemFontOfSize:20];
        [subV addSubview:countLable];
        int type = [subDic[@"type"] intValue];
        switch (type) {
            case 1:
            {
                self.orderNumL = countLable;
            }
                break;
            case 2:
            {
                self.amountNumL = countLable;
            }
                break;
            case 3:
            {
                self.incomeL = countLable;
            }
                break;
            default:
                break;
        }
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, countLable.maxY, subV.width, 20)];
        titleLabel.textColor = kRGB_COLOR(@"#333333");
        titleLabel.text = subDic[@"title"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [subV addSubview:titleLabel];
        
        if (i != 0) {
            UIView *linkV = [[UIView alloc] initWithFrame:CGRectMake(-0.5, (subV.height -20)/2.0, 1, 20)];
            linkV.backgroundColor = kRGB_COLOR(@"#cccccc");
            [subV addSubview:linkV];
        }
        
        UIButton *btn = [[UIButton alloc]initWithFrame:subV.bounds];
        btn.tag = 1000+i;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(feastureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [subV addSubview:btn];
    }
}

- (void)setModel:(ShopBusinessOrderInfoDTOModel *)model{
    _model = model;
    self.orderNumL.text = [NSString stringWithFormat:@"%d",model.count];
    self.amountNumL.text = [NSString stringWithFormat:@"%.2f",model.price];
    self.incomeL.text = [NSString stringWithFormat:@"%.2f",model.income];
}

-(void)feastureBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(OrderDataVFunctionBtnClick:)]) {
        [self.delegate OrderDataVFunctionBtnClick:sender.tag - 1000];
    }
}

- (void)selectedBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    CustomStringPickerView *pickerV = [[CustomStringPickerView alloc] init];
    pickerV.doneBlock = ^(BRResultModel * _Nonnull resultModel) {
        weakself.selectedIndex = resultModel.index;
        weakself.lookL.attributedText = [resultModel.value attachmentForImage:[UIImage imageNamed:@"map_location_down"] bounds:CGRectMake(0, -2, 14, 14) before:NO];
        //刷新数据操作
        if (weakself.delegate && [self.delegate respondsToSelector:@selector(OrderDataVTimeSelected:)]) {
            [weakself.delegate OrderDataVTimeSelected:weakself.selectedIndex];
        }
    };
    [pickerV showStringPicker:@(self.selectedIndex) stringArr:self.dataArray];
    
}



@end
