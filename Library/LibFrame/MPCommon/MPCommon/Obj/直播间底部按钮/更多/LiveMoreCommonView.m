//
//  LiveMoreCommonView.m
//  LibProjView
//
//  Created by admin on 2020/1/7.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveMoreCommonView.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <Masonry.h>

@interface LiveMoreCommonView ()

@property (nonatomic, copy)void (^selectHandle)(NSUInteger);

@property (nonatomic, copy)NSArray *dataArr;

@property (nonatomic, assign)NSInteger baseTag;

@property (nonatomic, weak)UIView *moreView;

@end

@implementation LiveMoreCommonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseTag = 66883;
    }
    return self;
}

- (void)addItemName:(NSString *)name icon:(NSString *)icon msgType:(NSUInteger)msgType{
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    [muArr addObjectsFromArray:_dataArr];
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [muDic setObject:name forKey:@"name"];
    [muDic setObject:icon forKey:@"icon"];
    [muDic setObject:@(msgType) forKey:@"msgType"];
    [muArr addObject:[NSDictionary dictionaryWithDictionary:muDic]];
    _dataArr = [NSArray arrayWithArray:muArr];
}

- (void)createUI{
    ///一行几个
    int lineCount = 5;
    CGFloat space = 20;
    
    CGFloat btnWidth = (kScreenWidth-50-(lineCount-1)*30)/(lineCount *1.0);
    CGFloat btnHeight = btnWidth+15+5;
    ///行数
    NSInteger lineNum = _dataArr.count/lineCount+(_dataArr.count%lineCount>0?1:0);
    
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, lineNum*btnHeight+(lineNum+1)*space+10);
    self.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i< _dataArr.count; i++) {
        NSDictionary *dic = _dataArr[i];
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(25+i%lineCount*(btnWidth+30), space+ (i/lineCount)*(space+btnHeight), btnWidth, btnHeight);
        btn.tag = _baseTag+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.frame = CGRectMake(0, 0, btn.width, btn.width);
        icon.image = [UIImage imageNamed:dic[@"icon"]];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [btn addSubview:icon];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = dic[@"name"];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textColor = [UIColor blackColor];
        [btn addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(btn);
            make.centerX.equalTo(btn);
        }];
        
    }
    
    [FunctionSheetBaseView showView:self cover:NO];
    
}

- (void)btnClick:(UIButton *)btn{
    NSInteger clickOne = btn.tag -_baseTag;
    NSDictionary *dic = _dataArr[clickOne];
    if (_selectHandle) {
        [self dismiss];
        _selectHandle([dic[@"msgType"] intValue]);
    }
}

- (void)selectOne:(void (^)(NSUInteger))select{
    _selectHandle = select;
}

- (void)show{
    [self createUI];
}

- (void)dismiss{
    [FunctionSheetBaseView deletePopView:self];
}


@end
