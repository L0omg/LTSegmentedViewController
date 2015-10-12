//
//  LTSegmentedView.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/19.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "OAStackView.h"
@interface LTSegmentedView ()
@property (nonatomic, strong) OAStackView *containerView;
@property (nonatomic, copy) NSMutableArray<__kindof LTSegmentedItem*> *p_mItems;
@end

@implementation LTSegmentedView
#pragma mark -LifeCycle
- (instancetype) initWithItems:(NSArray<__kindof LTSegmentedItem*>*) items{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _p_mItems = [items mutableCopy];
        
        _contentView = ({
        
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:view];
            
            view;
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
        
        NSArray *v_ContainerView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_containerView)];
        NSArray *h_ContainerView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_containerView)];
        
        [NSLayoutConstraint fm_ActiveConstraints:v_ContentView_Constraint toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:h_ContentView_Constraint toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:v_ContainerView_Constraints toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:h_ContainerView_Constraints toView:_contentView];
    }
    return self;
}

#pragma mark -Public Methods
- (LTSegmentedItem*) selectedItem{
    
    if (self.selectedIndex >= 0 && self.selectedIndex < self.p_mItems.count) {
        
        return self.p_mItems[self.selectedIndex];
    }
    
    return nil;
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

#pragma mark -Accessor
- (NSArray<__kindof LTSegmentedItem*>*) items{
    
    return [self.p_mItems copy];
}

- (void) setSelectedIndex:(NSInteger)selectedIndex{
    
    if (selectedIndex < 0 || selectedIndex >= self.p_mItems.count) {
        
        selectedIndex = 0;
    }
    
    _selectedIndex = selectedIndex;
}
@end
