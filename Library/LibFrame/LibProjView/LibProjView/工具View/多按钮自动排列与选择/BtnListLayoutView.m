//
//  BtnsLayoutView.m
//  LibProjView
//
//  Created by klc on 2020/6/15.
//  Copyright © 2020 . All rights reserved.
//

#import "BtnListLayoutView.h"
#import <LibTools/LibTools.h>
@interface BtnListLayoutView(){
    CGFloat _padding_X;
    CGFloat _padding_Y;
    CGFloat _margin_X;
    CGFloat _margin_Y;
    CGFloat _listWidth;
    CGFloat _item_height;
}

@property(nonatomic, strong) NSMutableArray *selectedItems;    //已选中的按钮标题数组
@property(nonatomic, copy) ReturnBtnArrBlock whenSelected_callBack;

@end

@implementation BtnListLayoutView

- (NSMutableArray *)selectedItems{
    if (!_selectedItems) {
        _selectedItems = [NSMutableArray array];
    }
    return _selectedItems;
}


//- (instancetype)initWith_Width:(CGFloat)width btnTitlePadding_X:(CGFloat)padding_X btnTitlePadding_Y:(CGFloat)padding_Y marginX:(CGFloat)margin_X marginY:(CGFloat)margin_Y itemHeight:(CGFloat)item_height{
//    self = [super init];
//    if (self) {
//        _listWidth = width;
//        _padding_X = padding_X;
//        _padding_Y = padding_Y;
//        _margin_X = margin_X;
//        _margin_Y = margin_Y;
//        _item_height = item_height;
//        _maxSelectedNum = 1;
//
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id <BtnListLayoutViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _marginWidth = 10;
        _marginHeight = 10;
        _itemHeight = 30;
        _maxSelectedNum = 1;
        _delegate = delegate;
    }
    return self;
}


- (void)showTagsWithTitles:(NSArray<NSString *> *)titleArr selectIndexArr:(NSArray<NSNumber *> *)selectIndexArr callBack:(ReturnBtnArrBlock)returnBack {

    _whenSelected_callBack = returnBack;
    
    [self removeAllSubViews];
    
    __block CGFloat topHeight = 0;
    __block CGFloat leftWidth = 0;
    __block CGFloat viewHeight = 0;
    
    if (titleArr.count == 0) {
        if (_whenSelected_callBack) {
            _whenSelected_callBack(nil);
        }
    }
    
    NSArray *defaultSelectIndexArr = @[];
    if (selectIndexArr.count>0 && _maxSelectedNum>0) {
        NSInteger minCount = MIN(_maxSelectedNum, selectIndexArr.count);
        NSMutableArray<NSNumber *> *muArr = [NSMutableArray arrayWithCapacity:minCount];
        for (int i = 0; i< minCount; i++) {
            [muArr addObject:selectIndexArr[i]];
        }
        defaultSelectIndexArr = [muArr copy];
    }
    
    
    [titleArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger titleIdx, BOOL * _Nonnull stop) {
        UIButton *tagBtn = [self.delegate listLayoutView:self btnForItemAtIndex:titleIdx];
        tagBtn.clipsToBounds = YES;
        tagBtn.layer.cornerRadius = 15;
        [tagBtn setTitle:title forState:UIControlStateNormal];
        [tagBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        tagBtn.tag = titleIdx;
        tagBtn.selected = NO;
        [self addSubview:tagBtn];


        //size
        CGSize strSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.itemHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tagBtn.titleLabel.font} context:nil].size;
        strSize.width += 32;
        strSize.height = self.itemHeight;
        
        ///当前按钮的左距离+按钮宽度  >  整个view宽度
        if (leftWidth + strSize.width > self.width) {
            leftWidth = 0;
            topHeight += (self.itemHeight+self.marginHeight);
        }
        
        tagBtn.frame = CGRectMake(leftWidth, topHeight, strSize.width, strSize.height);

        ///下一个按钮的距左距离
        leftWidth += (strSize.width+self.marginWidth);
        ///整个view的高度
        viewHeight = topHeight + self.itemHeight;
        
        
        [defaultSelectIndexArr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (titleIdx == [obj integerValue]) {
                tagBtn.selected = YES;
            }
        }];
        
    }];
    
    self.height = viewHeight;
    
    if (_whenSelected_callBack) {
        _whenSelected_callBack(defaultSelectIndexArr);
    }
    
}


//- (CGFloat)setTagViewWithTitles:(NSArray *)titleArr callBack:(ReturnBtnArrBlock)returnBack{
//
//    _whenSelected_callBack = returnBack;
//    [self removeAllSubViews];
//
//    if (_listWidth == 0) {
//        _listWidth = self.width;
//    }
//
//    __block int totalHeight = 0;
//    __block CGRect previousFrame = CGRectMake(0, 0, 0, 0);
//    __block CGFloat height = 0;
//    if (titleArr.count == 0) {
//        if (_whenSelected_callBack) {
//            _whenSelected_callBack(nil);
//        }
//        return height;
//    }
//    [titleArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIButton *tagBtn = [self.delegate listLayoutView:self btnForItemAtIndex:idx];
//        [tagBtn setTitle:title forState:UIControlStateNormal];
//        [tagBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//        tagBtn.tag = idx;
//
//        if ([self.selectedItems containsObject:@(idx)]) {
//            tagBtn.selected = YES;
//        } else {
//            tagBtn.selected = NO;
//        }
//
//        //size
//        CGSize Size_str = [title boundingRectWithSize:CGSizeMake(kScreenWidth-2*_padding_X, _item_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tagBtn.titleLabel.font} context:nil].size;
//        Size_str.width += _padding_X * 2;
//        if (_item_height) {
//            Size_str.height = _item_height;
//        } else {
//            Size_str.height += _padding_Y * 2;
//        }
//
//        CGRect newRect = CGRectZero;
//        newRect.size = Size_str;
//
//        if (CGRectGetMaxX(previousFrame) + Size_str.width + _margin_X > _listWidth) { //换行
//            newRect.origin = CGPointMake(0, CGRectGetMaxY(previousFrame) + _margin_Y);
//            totalHeight += Size_str.height +_margin_Y;
//        } else {
//            newRect.origin = CGPointMake((CGRectGetMaxX(previousFrame) == 0 ? 0 : CGRectGetMaxX(previousFrame) + _margin_X), previousFrame.origin.y);
//        }
//        [tagBtn setFrame:newRect];
//
//        previousFrame = tagBtn.frame;
//        height = totalHeight + Size_str.height;
//
//        [self addSubview:tagBtn];
//    }];
//
//    self.height = height+kSafeAreaBottom+50;
//    if (_whenSelected_callBack) {
//        _whenSelected_callBack(self.selectedItems);
//    }
//    return self.height;
//}

#pragma mark - btn的点击方法
- (void)onClick:(UIButton *)btn {
    

    if (self.maxSelectedNum == 1) {
        if (btn.selected) {
            return;
        }
        
        btn.selected = !btn.selected;
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:@(btn.tag)];
        
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]] && btn.tag != obj.tag) {
                UIButton *btn = (UIButton *)obj;
                btn.selected = NO;
            }
        }];
        
    }else{
        if (!btn.selected && self.selectedItems.count >= self.maxSelectedNum){
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"最多选择%lu个"),(unsigned long)self.maxSelectedNum]];
            return;
        }
        btn.selected = !btn.selected;
        btn.selected?[self.selectedItems addObject:@(btn.tag)]:[self.selectedItems removeObject:@(btn.tag)];
    }
    
    if ([self.delegate respondsToSelector:@selector(list:selecteIndex:isSlected:)]) {
        [self.delegate list:self selecteIndex:btn.tag isSlected:btn.selected];
    }
    if (_whenSelected_callBack) {
        _whenSelected_callBack(self.selectedItems);
    }

}

@end
