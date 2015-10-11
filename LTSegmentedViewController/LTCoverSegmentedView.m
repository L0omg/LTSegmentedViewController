//
//  LTCoverSegmentedView.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/11.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTCoverSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
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
- (instancetype) initWithItems:(NSArray<__kindof LTSegmentedItem *> *)items{
    
    self = [super initWithItems:items];
    if (self) {
        
        self.coverUIOffset = UIOffsetMake(5, 20);
        self.coverColor = [UIColor colorWithWhite:1.f alpha:0.5];
        
        UIView *coverView = self.coverView;
        [self.contentView addSubview:coverView];
        
        NSLayoutConstraint *centerX_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.selectedItem attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
        NSLayoutConstraint *centerY_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.selectedItem attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0];
        NSLayoutConstraint *width_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.selectedItem attribute:NSLayoutAttributeWidth multiplier:1.f constant:-self.coverUIOffset.horizontal];
        NSLayoutConstraint *height_Constraint = [NSLayoutConstraint constraintWithItem:coverView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.selectedItem attribute:NSLayoutAttributeHeight multiplier:1.f constant:-self.coverUIOffset.vertical];
        [NSLayoutConstraint fm_ActiveConstraints:@[centerX_Constraint, centerY_Constraint, width_Constraint, height_Constraint] toView:self.contentView];
        
        self.coverViewCenterXConstraint = centerX_Constraint;
        self.coverViewCenterYConstraint = centerY_Constraint;
        self.coverViewWidthConstraint = width_Constraint;
        self.coverViewHeightConstraint = height_Constraint;
    }
    
    return self;
}

#pragma mark -Protocol
#pragma mark LTSegmentedViewProtocol <NSObject>
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView didSelectedItemAtIndex:(NSInteger) index{
    
    [super segmentedView:segmentedView didSelectedItemAtIndex:index];
    
    self.coverViewCenterXConstraint.constant = ((CGRectGetWidth(self.contentView.frame) / self.items.count) * self.selectedIndex);
}

- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView willScrollToItemAtIndex:(NSInteger) index percent:(CGFloat) percent{
    
    [super segmentedView:segmentedView willScrollToItemAtIndex:index percent:percent];

    if (index != self.selectedIndex && index >= 0 && index < self.items.count) {
        
        NSInteger frontIndex = MAX(MIN(index, self.selectedIndex), 0);
        CGFloat width = (CGRectGetWidth(self.contentView.frame) / self.items.count);
        self.coverViewCenterXConstraint.constant = (width * frontIndex) + width * percent;
    }else{
        
        self.coverViewCenterXConstraint.constant = ((CGRectGetWidth(self.contentView.frame) / self.items.count) * self.selectedIndex);
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
    
    self.coverViewHeightConstraint.constant = -coverUIOffset.vertical;
    self.coverViewWidthConstraint.constant = -coverUIOffset.horizontal;
    _coverUIOffset = coverUIOffset;
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
}

- (void) drawRect:(CGRect)rect{
    
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.layer.masksToBounds = YES;
}

@end
