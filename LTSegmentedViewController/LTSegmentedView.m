//
//  LTSegmentedView.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/19.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "LTSegmentedView+private.h"
#import "OAStackView.h"

static NSInteger const kLTSegmentedViewDefaultNumberOfItemsPerScreen = 4;

@interface LTSegmentedView ()
@property (nonatomic, strong) OAStackView *containerView;
@property (nonatomic, copy) NSMutableArray<__kindof LTSegmentedItem*> *p_mItems;

@property (nonatomic, strong) NSLayoutConstraint *contentWidthConstraint;
@end

@implementation LTSegmentedView
@synthesize selectedIndex = _selectedIndex;

#pragma mark -LifeCycle
- (instancetype) initWithItems:(NSArray<__kindof LTSegmentedItem*>*) items{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _numberOfItemsPerScreen = kLTSegmentedViewDefaultNumberOfItemsPerScreen;
        _p_mItems = [items mutableCopy];
        
        _contentView = ({
        
            UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
            contentView.translatesAutoresizingMaskIntoConstraints = NO;
            contentView.showsHorizontalScrollIndicator = NO;
            contentView.showsVerticalScrollIndicator = NO;
            [self addSubview:contentView];
            
            contentView;
        });
        
        _containerView = ({
        
            OAStackView *stackView = [[OAStackView alloc] initWithArrangedSubviews:items];
            stackView.translatesAutoresizingMaskIntoConstraints = NO;
            stackView.axis = UILayoutConstraintAxisHorizontal;
            stackView.distribution = OAStackViewDistributionFillEqually;
            stackView.alignment = OAStackViewAlignmentFill;
            [_contentView addSubview:stackView];
            
            stackView;
        });
        
        NSArray *v_ContentView_Constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
        NSArray *h_ContentView_Constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
        
        NSLayoutConstraint *leading_ContainerView_Constraint = [NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
        NSLayoutConstraint *trailing_ContainerView_Constraint = [NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
        NSLayoutConstraint *top_ContainerView_Constraint = [NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
        NSLayoutConstraint *bottom_ContainerView_Constraint = [NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
        NSLayoutConstraint *height_Constraint = [NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
        NSLayoutConstraint *width_Constraint = [NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:(items.count * 1.f / _numberOfItemsPerScreen) constant:0.f];
        self.contentWidthConstraint = width_Constraint;
        
        [NSLayoutConstraint fm_ActiveConstraints:v_ContentView_Constraint toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:h_ContentView_Constraint toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:@[top_ContainerView_Constraint, bottom_ContainerView_Constraint] toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:@[leading_ContainerView_Constraint, trailing_ContainerView_Constraint] toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:@[height_Constraint, width_Constraint] toView:_contentView];
    }
    return self;
}

- (void) layoutSubviews{
    
    [super layoutSubviews];
    [self reloadItems];
}

#pragma mark -Public Methods
- (void) reloadItems{
    
    [self adjustContentSize];
    self.selectedIndex = self.selectedIndex;/*调整contentOffset*/
}

- (void) addItem:(LTSegmentedItem*) item{
    
    [self.containerView addArrangedSubview:item];
    [self.p_mItems addObject:item];
    [self reloadItems];
}

- (void) removeItemAtIndex:(NSInteger) index{
    
    if ([self isValidIndex:index]) {
        
        LTSegmentedItem *item = self.items[index];
        [self removeItem:item];
    }
}

- (void) removeItem:(LTSegmentedItem*) item{
    
    [self.containerView removeArrangedSubview:item];
    [self.p_mItems removeObject:item];
    [self reloadItems];
}

- (void) insertItem:(LTSegmentedItem*) item atIndex:(NSInteger) index{
    
    [self.containerView insertArrangedSubview:item atIndex:index];
    [self.p_mItems insertObject:item atIndex:index];
    [self reloadItems];
}

#pragma mark -Private Methods
- (void) adjustContentSize{
    
    if (self.contentWidthConstraint) {
        
        [self.contentWidthConstraint fm_DeActiveInView:self.contentView];
    }
    
    self.contentWidthConstraint = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:self.p_mItems.count * 1.f / self.numberOfItemsPerScreen constant:0.f];
    
    if (self.contentWidthConstraint) {
        
        [self.contentWidthConstraint fm_ActiveToView:self.contentView];
    }
}

#pragma mark -Protocol
#pragma mark LTSegmentedViewProtocol <NSObject>
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView didSelectedItemAtIndex:(NSInteger) index{

    if (index != NSNotFound) {
        
        self.selectedIndex = index;
    }
}

- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView willScrollToItemAtIndex:(NSInteger) index percent:(CGFloat) percent{
    
    
}

- (void) adjustContentOffsetFrom:(NSInteger) preIndex to:(NSInteger) curIndex{
    
    CGFloat itemWidth = self.itemWidth;
    CGFloat offset = curIndex * itemWidth;
    CGFloat curOffset = self.contentView.contentOffset.x;
    
    CGFloat width = CGRectGetWidth(self.contentView.frame);
    CGFloat fitOffset = curOffset;
    BOOL isNeddAdjust = NO;
    if (preIndex > curIndex) {
        
        if (((offset - itemWidth) < curOffset)) {
            
            isNeddAdjust = YES;
            fitOffset = offset - itemWidth;
        }
    }else if (preIndex < curIndex){
        
        if ((offset + itemWidth * 2 > curOffset + width)) {
            
            isNeddAdjust = YES;
            fitOffset = offset - (width - 2 * itemWidth);
        }
    }
    
    if (!isNeddAdjust) {
        
        if ((offset + itemWidth > curOffset + width)) {
            
            isNeddAdjust = YES;
            fitOffset = offset - width + itemWidth;
        }else if ((offset < curOffset)){
            
            isNeddAdjust = YES;
            fitOffset = offset;
        }
    }
    
    if (isNeddAdjust) {
        
        fitOffset = [self validOffsetAt:fitOffset];
        [self.contentView setContentOffset:CGPointMake(fitOffset, self.contentView.contentOffset.y) animated:YES];
    }
}

#pragma mark -Accessor
- (NSArray<__kindof LTSegmentedItem*>*) items{
    
    return [self.p_mItems copy];
}

- (void) setSelectedIndex:(NSInteger)selectedIndex{
    
    selectedIndex = [self validIndexAt:selectedIndex];
    
    NSInteger preIndex = _selectedIndex;
    _selectedIndex = selectedIndex;
    
    [self adjustContentOffsetFrom:preIndex to:selectedIndex];
}

- (NSInteger) selectedIndex{
    
    return [self validIndexAt:_selectedIndex];
}

- (void) setNumberOfItemsPerScreen:(NSInteger)numberOfItemsPerScreen{
    
    if (numberOfItemsPerScreen != _numberOfItemsPerScreen) {
        
        if (numberOfItemsPerScreen <= 0) {
            
            _numberOfItemsPerScreen = kLTSegmentedViewDefaultNumberOfItemsPerScreen;
        }else{
            
            _numberOfItemsPerScreen = numberOfItemsPerScreen;
        }
        
        [self reloadItems];
    }
}
@end
