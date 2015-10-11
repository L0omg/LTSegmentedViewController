//
//  LTWYSegmentedView.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/11.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTWYSegmentedView.h"

#pragma mark -Constant Define
static const CGFloat LTWYSegmentedViewDefaultTitleNormalFontSize = 10;
static const CGFloat LTWYSegmentedViewDefaultTitleSelectedFontSize = 15;
static const struct LTColor LTWYSegmentedViewDefaultTitleNormalColor = {0x50, 0x50, 0x50, 1};
static const struct LTColor LTWYSegmentedViewDefaultTitleSelectedColor = {0xFF, 0x50, 0x50, 1};


@implementation LTWYSegmentedView
#pragma mark -LifeCycle
- (instancetype) initWithItems:(NSArray<__kindof LTSegmentedItem*>*) items{
    
    self = [super initWithItems:items];
    if (self) {
        
        _titleNormalFontSize = LTWYSegmentedViewDefaultTitleNormalFontSize;
        _titleSelectedFontSize = LTWYSegmentedViewDefaultTitleSelectedFontSize;
        _titleNormalColor = LTWYSegmentedViewDefaultTitleNormalColor;
        _titleSelectedColor = LTWYSegmentedViewDefaultTitleSelectedColor;
    }
    return self;
}

#pragma mark -Protocol
#pragma mark LTSegmentedViewProtocol <NSObject>
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView didSelectedItemAtIndex:(NSInteger) index{
    
    [super segmentedView:segmentedView didSelectedItemAtIndex:index];
    
    [self.items enumerateObjectsUsingBlock:^(__kindof LTSegmentedItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == index) {
            
            obj.titleLabel.textColor = LTColorToUIColor(self.titleSelectedColor);
            obj.titleLabel.font = [UIFont systemFontOfSize:self.titleSelectedFontSize];
        }else{
            
            obj.titleLabel.textColor = LTColorToUIColor(self.titleNormalColor);
            obj.titleLabel.font = [UIFont systemFontOfSize:self.titleNormalFontSize];
        }
    }];
}

- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView willScrollToItemAtIndex:(NSInteger) index percent:(CGFloat) percent{
    
    [super segmentedView:segmentedView willScrollToItemAtIndex:index percent:percent];
    
    if (index < 0 || index >= self.items.count) {
        
        return;
    }
    
    NSInteger maximumIndex = self.items.count - 1;
    percent = [[NSString stringWithFormat:@"%.3f", percent] floatValue];
    NSInteger frontIndex = self.selectedIndex;
    NSInteger backIndex = MAX(MIN(maximumIndex, index), 0);
    
    if (frontIndex != backIndex) {
        
        if (frontIndex > backIndex) {
            
            NSInteger tmpIndex = frontIndex;
            frontIndex = backIndex;
            backIndex = tmpIndex;
        }
        
        LTSegmentedItem *frontItem = self.items[frontIndex];
        LTSegmentedItem *backItem = self.items[backIndex];
        
        frontItem.titleLabel.font = [UIFont systemFontOfSize:((self.titleSelectedFontSize - self.titleNormalFontSize) * (1 - percent)) + self.titleNormalFontSize];
        frontItem.titleLabel.textColor = LTColorToUIColor(LTGradualColor(self.titleSelectedColor, self.titleNormalColor, percent));
        
        backItem.titleLabel.font = [UIFont systemFontOfSize:((self.titleSelectedFontSize - self.titleNormalFontSize) * percent) + self.titleNormalFontSize];
        backItem.titleLabel.textColor = LTColorToUIColor(LTGradualColor(self.titleNormalColor, self.titleSelectedColor, percent));
    }
}

#pragma mark -Accessor
- (CGFloat) titleNormalFontSize{
    
    if (_titleNormalFontSize <= 0) {
        
        return LTWYSegmentedViewDefaultTitleNormalFontSize;
    }
    
    return _titleNormalFontSize;
}

- (CGFloat) titleSelectedFontSize{
    
    if (_titleSelectedFontSize <= 0) {
        
        return LTWYSegmentedViewDefaultTitleSelectedFontSize;
    }
    
    return _titleSelectedFontSize;
}
@end
