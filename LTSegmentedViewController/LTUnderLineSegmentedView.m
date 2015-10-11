//
//  LTUnderLineSegmentedView.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/11.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTUnderLineSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
@interface LTUnderLineSegmentedView()
@property (nonatomic, strong) UIView *underLineView;
@property (nonatomic, strong) NSLayoutConstraint *underLineHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *underLineWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *underLineLedingConstraint;
@end

@implementation LTUnderLineSegmentedView
#pragma mark -Life Cycle
- (instancetype) initWithItems:(NSArray<__kindof LTSegmentedItem *> *)items{
    
    self = [super initWithItems:items];
    if (self) {
        
        self.underLineColor = [UIColor blueColor];
        self.underLineheight = 2;
        
        UIView* underLineView = self.underLineView;
        [self.contentView addSubview:underLineView];
        
        NSLayoutConstraint *bottom_Constraint = [NSLayoutConstraint constraintWithItem:underLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
        NSLayoutConstraint *height_Constraint = [NSLayoutConstraint constraintWithItem:underLineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:self.underLineheight];
        NSLayoutConstraint *leading_Constraint = [NSLayoutConstraint constraintWithItem:underLineView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:[self.items firstObject] attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
        NSLayoutConstraint *width_Constraint = [NSLayoutConstraint constraintWithItem:underLineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[self.items firstObject] attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f];
        [bottom_Constraint fm_ActiveToView:self.contentView];
        [height_Constraint fm_ActiveToView:self.contentView];
        [leading_Constraint fm_ActiveToView:self.contentView];
        [width_Constraint fm_ActiveToView:self.contentView];
        self.underLineHeightConstraint = height_Constraint;
        self.underLineLedingConstraint = leading_Constraint;
        self.underLineWidthConstraint = width_Constraint;
    }
    return self;
}

#pragma mark -Protocol
#pragma mark LTSegmentedViewProtocol <NSObject>
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView didSelectedItemAtIndex:(NSInteger) index{
    
    [super segmentedView:segmentedView didSelectedItemAtIndex:index];

    self.underLineLedingConstraint.constant = ((CGRectGetWidth(self.contentView.frame) / self.items.count) * self.selectedIndex);
}

- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView willScrollToItemAtIndex:(NSInteger) index percent:(CGFloat) percent{
    
    [super segmentedView:segmentedView willScrollToItemAtIndex:index percent:percent];
  
    if (index != self.selectedIndex && index >= 0 && index < self.items.count) {
        
        NSInteger frontIndex = MAX(MIN(index, self.selectedIndex), 0);
        CGFloat width = (CGRectGetWidth(self.contentView.frame) / self.items.count);
        self.underLineLedingConstraint.constant = (width * frontIndex) + width * percent;
    }else{
        
        self.underLineLedingConstraint.constant = ((CGRectGetWidth(self.contentView.frame) / self.items.count) * self.selectedIndex);
    }
}

#pragma mark -Accessor
- (UIView*) underLineView{
    
    if (!_underLineView) {
        
        _underLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _underLineView.translatesAutoresizingMaskIntoConstraints = NO;
        _underLineView.backgroundColor = self.underLineColor;
        _underLineView.layer.cornerRadius = 2.f;
        _underLineView.layer.masksToBounds = YES;
    }
    
    return _underLineView;
}

- (void) setUnderLineheight:(CGFloat)underLineheight{
    
    self.underLineHeightConstraint.constant = underLineheight;
    _underLineheight = underLineheight;
}

- (void) setUnderLineColor:(UIColor *)underLineColor{
    
    if (_underLineColor != underLineColor) {
        
        self.underLineView.backgroundColor = underLineColor;
        _underLineColor = underLineColor;
    }
}
@end
