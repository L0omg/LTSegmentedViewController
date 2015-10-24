//
//  LTCoverSegmentedView.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/11.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTCoverSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "LTSegmentedView+private.h"

#pragma mark -Constant Define
#define LTCoverSegmentedViewCoverOffset UIOffsetMake(5, 20)
#define LTCoverSegmentedViewCoverColor [UIColor colorWithWhite:1.f alpha:0.5]

@class LTCoverView;
@interface LTCoverSegmentedView()
@property (nonatomic, strong) LTCoverView *coverView;
@property (nonatomic, strong) NSLayoutConstraint *coverViewCenterXConstraint;
@property (nonatomic, strong) NSLayoutConstraint *coverViewCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *coverViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *coverViewHeightConstraint;
@end

@implementation LTCoverSegmentedView
#pragma mark -Life Cycle
- (instancetype) initWithItems:(NSArray/*<__kindof LTSegmentedItem *>*/ *)items{
    
    self = [super initWithItems:items];
    if (self) {
        
        self.coverUIOffset = LTCoverSegmentedViewCoverOffset;
        self.coverColor = LTCoverSegmentedViewCoverColor;
        
        UIView *coverView = self.coverView;
        [self.contentView addSubview:coverView];
        
        NSLayoutConstraint *centerX_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
        NSLayoutConstraint *centerY_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0];
        NSLayoutConstraint *width_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:MAX(0, (-self.coverUIOffset.horizontal + self.itemWidth))];
        NSLayoutConstraint *height_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.f constant:-self.coverUIOffset.vertical];
        [NSLayoutConstraint fm_ActiveConstraints:@[centerX_Constraint, centerY_Constraint, width_Constraint, height_Constraint] toView:self.contentView];
        
        self.coverViewCenterXConstraint = centerX_Constraint;
        self.coverViewCenterYConstraint = centerY_Constraint;
        self.coverViewWidthConstraint = width_Constraint;
        self.coverViewHeightConstraint = height_Constraint;
    }
    
    return self;
}

#pragma mark -Public Methods
- (void) reloadItems{
    
    [super reloadItems];
    
    [self adjustCoverPosition];
}

#pragma mark -Private Methods
- (void) adjustCoverPosition{
    
    self.coverViewCenterXConstraint.constant = (self.itemWidth * (self.selectedIndex + 0.5f));
    self.coverViewHeightConstraint.constant = -self.coverUIOffset.vertical;
    self.coverViewWidthConstraint.constant = MAX(0, (-self.coverUIOffset.horizontal + self.itemWidth));
}

#pragma mark -Protocol
#pragma mark LTSegmentedViewProtocol <NSObject>
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView didSelectedItemAtIndex:(NSInteger) index{
    
    [super segmentedView:segmentedView didSelectedItemAtIndex:index];
    
    [self adjustCoverPosition];
}

- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView willScrollToItemAtIndex:(NSInteger) index percent:(CGFloat) percent{
    
    [super segmentedView:segmentedView willScrollToItemAtIndex:index percent:percent];

    CGFloat itemWidth = self.itemWidth;
    if (index != self.selectedIndex && [self isValidIndex:index]) {
        
        NSInteger frontIndex = [self frontIndex:index another:self.selectedIndex];
        self.coverViewCenterXConstraint.constant = (itemWidth * (frontIndex + 0.5f)) + itemWidth * percent;
    }else{
        
        [self adjustCoverPosition];
    }
}

#pragma mark -Accessor
- (LTCoverView*) coverView{
    
    if (!_coverView) {
        
        _coverView = [[LTCoverView alloc] initWithFrame:CGRectZero];
        _coverView.translatesAutoresizingMaskIntoConstraints = NO;
        _coverView.backgroundColor = self.coverColor;
    }
    
    return _coverView;
}

- (void) setCoverUIOffset:(UIOffset)coverUIOffset{
    
    _coverUIOffset = coverUIOffset;
    [self adjustCoverPosition];
}

- (void) setCoverColor:(UIColor *)coverColor{
    
    if (_coverColor != coverColor) {
        
        self.coverView.backgroundColor = coverColor;
        _coverColor = coverColor;
    }
}
@end

@implementation LTCoverView

- (void) layoutSubviews{
    
    [self setNeedsDisplay];
    [super layoutSubviews];
}

- (void) drawRect:(CGRect)rect{
    
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.layer.masksToBounds = YES;
}

@end
