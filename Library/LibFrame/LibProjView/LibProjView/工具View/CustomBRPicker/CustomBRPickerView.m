//
//  CustomBRPickerView.m
//  LibProjView
//
//  Created by klc_sl on 2021/3/26.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "CustomBRPickerView.h"
#import "BRPickerView.h"
#import "FunctionSheetBaseView.h"
#import <LibTools/LibTools.h>

@interface CustomBRPickerView ()

///字符串
@property (nonatomic, copy)NSArray<BRResultModel *> *selectModelArr;  ///字符串选择结果
///日期
@property (nonatomic, copy)NSDate *selectDate;

///创建视图
- (UIView *)createShowView:(UIView *)bgView sureBtnClick:(void(^)(void))sureBlock;
///点击确认按钮
- (void)sureBtnClick;

@end

@implementation CustomBRPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)dealloc
{
    
}

- (UIView *)createShowView:(UIView *)bgView sureBtnClick:(void(^)(void))sureBlock{
    
    CGFloat scale = 518/750.0;
    CGFloat height = kScreenWidth*scale;

    self.frame = CGRectMake(0, 0, kScreenWidth, height+kSafeAreaBottom);
    self.backgroundColor = [UIColor whiteColor];
    ///头部视图
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    [self addSubview:headerV];
    
    UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:contentV];
    [self sendSubviewToBack:contentV];
    
    //右侧确定按钮
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(headerV.width-headerV.height, 0, headerV.height, headerV.height);
    [closeBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
    [closeBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [headerV addSubview:closeBtn];
    [closeBtn klc_whenTapped:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sureBlock) {
                sureBlock();
            }
        });
    }];

    if (_showTitle.length) {
        ///标题
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(closeBtn.width, 0, headerV.width-(closeBtn.width *2.0), headerV.height)];
        titleL.text = _showTitle;
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.textColor = [UIColor blackColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        [headerV addSubview:titleL];
    }
    [FunctionSheetBaseView showView:self cover:YES];
    return contentV;
}


- (void)dismissView{
    [self dismiss];
}

- (void)dismiss{
    [FunctionSheetBaseView deletePopView:self];
}

- (void)showCustomView:(UIView<CustomPickerProtocol> *)view{
    kWeakSelf(self);
    UIView *pickerBgView = [self createShowView:self sureBtnClick:^{
        [view sureBtnClick];
        [weakself dismissView];
    }];
    [view showInSuperView:pickerBgView];
}


@end



///MARK: CustomStringPickerView

@implementation CustomStringPickerView

///字符串单选
- (void)showStringPicker:(NSNumber *)selectedIndex stringArr:(NSArray<NSString *> *)stringArr{
    if (stringArr.count == 0) {
       // NSLog(@"过滤文字-----没有数据"));
        return;
    }
    ///设置第一个
    kWeakSelf(self);
    UIView *pickerBgView = [self createShowView:self sureBtnClick:^{
        if (weakself.doneBlock && weakself.selectModelArr.count == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.doneBlock(weakself.selectModelArr.firstObject);
            });
        }
        [weakself dismissView];
    }];
    
    {
        ///默认选项
        if ([selectedIndex integerValue] >= stringArr.count) {
            selectedIndex = @(stringArr.count-1);
        }
        BRResultModel *resultModel = [[BRResultModel alloc] init];
        resultModel.index = [selectedIndex intValue];
        resultModel.key = [NSString stringWithFormat:@"%@",selectedIndex];
        resultModel.value = stringArr[resultModel.index];
        self.selectModelArr = @[resultModel];
        if (self.changeBlock) {
            self.changeBlock(self.selectModelArr.firstObject);
        }
    }
    
    BRStringPickerView *piker = [[BRStringPickerView alloc] init];
    piker.backgroundColor = [UIColor whiteColor];
    piker.pickerMode = BRStringPickerComponentSingle;
    BRPickerStyle *style = [[BRPickerStyle alloc]init];
    piker.selectIndex = [selectedIndex integerValue];
    style.pickerTextColor = kRGB_COLOR(@"#666666");
    style.selectRowTextColor = [ProjConfig normalColors];
    piker.pickerStyle = style;
    piker.dataSourceArr = stringArr;
    [piker addPickerToView:pickerBgView];
    piker.changeModelBlock = ^(BRResultModel * _Nullable resultModel) {
        weakself.selectModelArr = @[resultModel];
        if (weakself.changeBlock) {
            weakself.changeBlock(weakself.selectModelArr.firstObject);
        }
    };
}


///字符串多选
- (void)showMultiStringPicker:(NSArray<NSNumber*> *)selectedIndex stringArr:(NSArray<NSArray<NSString *> *> *)stringListArr{
    
    if (stringListArr.count == 0) {
       // NSLog(@"过滤文字-----没有数据源"));
        return;
    }
    
    if (stringListArr.count != selectedIndex.count) {
       // NSLog(@"过滤文字-----默认选择的数据不匹配"));
        return;
    }

    ///设置第一个
    kWeakSelf(self);
    UIView *pickerBgView = [self createShowView:self sureBtnClick:^{
        if (weakself.multiDoneBlock && weakself.selectModelArr.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.multiDoneBlock(weakself.selectModelArr);
            });
        }
        [weakself dismissView];
    }];
    
    {
        ///默认选项
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        ///默认选择
        NSMutableArray *selectMuIndex = [[NSMutableArray alloc] init];
        for (int i = 0; i < selectedIndex.count; i++) {
            ///每个字符串组
            NSInteger index = [selectedIndex[i] integerValue];

            if (index >= stringListArr[i].count) {
                index = (stringListArr[i].count-1);
            }
            
            NSArray *listArr = stringListArr[i];
            ///取选中的字符串
            BRResultModel *resultModel = [[BRResultModel alloc] init];
            resultModel.index = index;
            resultModel.key = [NSString stringWithFormat:@"%zi",index];
            resultModel.value = listArr[index];
            [muArr addObject:resultModel];
            
            [selectMuIndex addObject:@(index)];
        }
        self.selectModelArr = [NSArray arrayWithArray:muArr];
        if (self.multiChangeBlock) {
            self.multiChangeBlock(self.selectModelArr);
        }
        
        selectedIndex = [NSArray arrayWithArray:selectMuIndex];
    }
    
    BRStringPickerView *piker = [[BRStringPickerView alloc] init];
    piker.backgroundColor = [UIColor whiteColor];
    piker.pickerMode = BRStringPickerComponentMulti;
    piker.selectIndexs = selectedIndex;
    BRPickerStyle *style = [[BRPickerStyle alloc]init];
    style.pickerTextColor = kRGB_COLOR(@"#666666");
    style.selectRowTextColor = [ProjConfig normalColors];
    piker.pickerStyle = style;
    piker.dataSourceArr = stringListArr;
    [piker addPickerToView:pickerBgView];
    piker.changeModelArrayBlock = ^(NSArray<BRResultModel *> * _Nullable resultModelArr) {
        weakself.selectModelArr = resultModelArr;
        if (weakself.multiChangeBlock) {
            weakself.multiChangeBlock(weakself.selectModelArr);
        }
    };
}



///字符串多选
- (void)showLinkageStringPicker:(NSArray<NSNumber *> *)selectedIndex numberOfComponents:(int)num stringArr:(NSArray<BRResultModel *> *)stringListArr {
    
    if (stringListArr.count == 0) {
       // NSLog(@"过滤文字-----没有数据源"));
        return;
    }
    
    ///设置第一个
    kWeakSelf(self);
    UIView *pickerBgView = [self createShowView:self sureBtnClick:^{
        if (weakself.multiDoneBlock && weakself.selectModelArr.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.multiDoneBlock(weakself.selectModelArr);
            });
        }
        [weakself dismissView];
    }];
    
    {
        ///默认选项
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        ///默认选择
        NSMutableArray *selectMuIndex = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < selectedIndex.count; i++) {
            ///每个字符串组
            NSInteger index = [selectedIndex[i] integerValue];

            if (index >= stringListArr.count) {
                index = (stringListArr.count-1);
            }
            
            BRResultModel *resultModel = stringListArr[i];
            [muArr addObject:resultModel];
            [selectMuIndex addObject:@(index)];
        }
        
        self.selectModelArr = [NSArray arrayWithArray:muArr];
        self.multiChangeBlock?self.multiChangeBlock(self.selectModelArr):nil;
        selectedIndex = [NSArray arrayWithArray:selectMuIndex];
    }
    
    BRStringPickerView *piker = [[BRStringPickerView alloc] init];
    piker.backgroundColor = [UIColor whiteColor];
//    piker.numberOfComponents = num;
    piker.pickerMode = BRStringPickerComponentLinkage;
//    piker.selectIndexs = selectedIndex;
    BRPickerStyle *style = [[BRPickerStyle alloc]init];
    style.pickerTextColor = kRGB_COLOR(@"#666666");
    style.selectRowTextColor = [ProjConfig normalColors];
    piker.pickerStyle = style;
    piker.dataSourceArr = stringListArr;
    [piker addPickerToView:pickerBgView];
    piker.changeModelArrayBlock = ^(NSArray<BRResultModel *> * _Nullable resultModelArr) {
        weakself.selectModelArr = resultModelArr;
        weakself.multiChangeBlock?weakself.multiChangeBlock(weakself.selectModelArr):nil;
    };
}


@end




///MARK: CustomDataPickerView

@implementation CustomDataPickerView

///日期选择器
- (void)showDatePicker:(NSString *)showDate limit:(int)limit dateFormatter:(NSString *)dateFormatter{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:dateFormatter];
    //100年前
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:-100];
    [adcomps setDay:0];
    
    NSDate *minDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDate *maxDate = [NSDate date];
    if (limit > 0) {
        NSDateComponents *maxcomps = [[NSDateComponents alloc] init];
        [maxcomps setYear:-limit];
        [maxcomps setDay:0];
        maxDate = [calendar dateByAddingComponents:maxcomps toDate:date options:0];
    }
     
    
    self.selectDate = [forMatter dateFromString:showDate];
    if (showDate.length == 0) {
        self.selectDate = [NSDate date];
    }

    ///设置第一个
    kWeakSelf(self);
    UIView *pickerBgView = [self createShowView:self sureBtnClick:^{
        if (weakself.doneBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.doneBlock(weakself.selectDate);
            });
        }
        [weakself dismissView];
    }];
    
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.selectDate = self.selectDate;
    datePickerView.minDate = minDate;
    datePickerView.maxDate = maxDate;
    datePickerView.isAutoSelect = NO;
    datePickerView.showToday = YES;
    datePickerView.showWeek = NO;
    BRPickerStyle *style = [[BRPickerStyle alloc]init];
    style.pickerTextColor = kRGB_COLOR(@"#666666");
    style.selectRowTextColor = [ProjConfig normalColors];
    datePickerView.pickerStyle = style;
    datePickerView.changeBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        weakself.selectDate = selectDate;
    };
    [datePickerView addPickerToView:pickerBgView];
}


@end
