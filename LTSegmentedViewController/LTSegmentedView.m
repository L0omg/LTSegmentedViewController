//
//  LTSegmentedView.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/19.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
@interface LTSegmentedView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *underLineImageView;
@property (nonatomic, strong) UIStackView *containerView;
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
        
            UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:items];
            stackView.translatesAutoresizingMaskIntoConstraints = NO;
            stackView.axis = UILayoutConstraintAxisHorizontal;
            stackView.distribution = UIStackViewDistributionFillEqually;
            stackView.alignment = UIStackViewAlignmentFill;
            stackView.spacing = 0.f;
            [_contentView addSubview:stackView];
            
            stackView;
        });
        
        _underLineImageView = ({
        
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
//            [self addSubview:imageView];
            
            imageView;
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

#pragma mark -Protocol
#pragma mark LTSegmentedViewProtocol <NSObject>
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView didSelectedItemAtIndex:(NSInteger) index{

    if (index != NSNotFound) {
        
        self.selectedIndex = index;
    }
    [self.p_mItems enumerateObjectsUsingBlock:^(__kindof LTSegmentedItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == index) {
            
            obj.titleLabel.textColor = [UIColor colorWithRed:1.f green:76.f / 255.f blue:76.f / 255.f alpha:1.f];
            obj.titleLabel.font = [UIFont systemFontOfSize:15];
        }else{
            
            obj.titleLabel.textColor = [UIColor colorWithRed:0.f green:76.f / 255.f blue:76.f / 255.f alpha:1.f];
            obj.titleLabel.font = [UIFont systemFontOfSize:10];
        }
    }];
}

- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView willScrollToItemAtIndex:(NSInteger) index percent:(CGFloat) percent{
    
    NSInteger curIndex = self.selectedIndex;
    NSInteger lastIndex = MAX(MIN(self.p_mItems.count - 1, index), 0);
    if (curIndex > lastIndex) {
        
        NSInteger tmpIndex = lastIndex;
        lastIndex = curIndex;
        curIndex = tmpIndex;
    }
    
    LTSegmentedItem *curItem = self.p_mItems[curIndex];
    LTSegmentedItem *lastItem = self.p_mItems[lastIndex];
    
    if (curIndex != lastIndex) {
        
        curItem.titleLabel.font = [UIFont systemFontOfSize:(5 * (1 - percent)) + 10];
        lastItem.titleLabel.font = [UIFont systemFontOfSize:(5 * percent) + 10];
    }
}

#pragma mark -Accessor
- (NSArray<__kindof LTSegmentedItem*>*) items{
    
    return [self.p_mItems copy];
}

- (void) setSelectedIndex:(NSInteger)selectedIndex{
    
    if (selectedIndex < 0 || selectedIndex >= self.p_mItems.count) {
        
        selectedIndex = 0;
    }
    
    LTSegmentedItem *preItem = self.p_mItems[_selectedIndex];
    LTSegmentedItem *curItem = self.p_mItems[selectedIndex];
    preItem.titleLabel.textColor = [UIColor blackColor];
    curItem.titleLabel.textColor = [UIColor redColor];
    
    _selectedIndex = selectedIndex;
}
@end
