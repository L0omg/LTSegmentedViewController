//
//  LTSegmentedItem.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/15.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import "LTSegmentedItem.h"
#import "NSLayoutConstraint+ActiveConstraint.h"

@interface LTSegmentedItem()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation LTSegmentedItem
#pragma mark -LifeCycle
- (instancetype) initWithTitle:(NSString*) title icon:(UIImage*) icon action:(void(^)(LTSegmentedItem* item)) action{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _contentView = ({
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.userInteractionEnabled = NO;
            [self addSubview:view];
            
            view;
        });
        
        _titleLabel = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [_contentView addSubview:label];
            
            label;
        });
        
//        _imageView = ({
//        
//            UIImageView *imageView = [[UIImageView alloc] initWithImage:icon];
//            imageView.translatesAutoresizingMaskIntoConstraints = NO;
//            imageView.contentMode = UIViewContentModeRight;
//            [_contentView addSubview:imageView];
//            
//            imageView;
//        });
        
        NSArray *v_ContentView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
        NSArray *h_ContentView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
        
        NSArray *v_TitleLabel_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)];
        NSArray *h_TitleLabel_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|" options:(NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom) metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)];
        
        [NSLayoutConstraint fm_ActiveConstraints:v_ContentView_Constraints toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:h_ContentView_Constraints toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:v_TitleLabel_Constraints toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:h_TitleLabel_Constraints toView:_contentView];
        
        _clickAction = action;
        
        [self addTarget:self action:@selector(onClickSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype) initWithTitle:(NSString*) title icon:(UIImage*) icon{
    
    return [self initWithTitle:title icon:nil action:NULL];
}
#pragma mark Super
- (instancetype) initWithFrame:(CGRect)frame{
    
    return [self initWithTitle:nil icon:nil];
}

- (CGSize) intrinsicContentSize{
    
    return CGSizeMake(self.titleLabel.intrinsicContentSize.width + self.imageView.intrinsicContentSize.width + self.contentOffset.horizontal, MAX(self.imageView.intrinsicContentSize.height, self.titleLabel.intrinsicContentSize.height) + self.contentOffset.vertical);
}

#pragma mark -User Interaction
- (void) onClickSelf:(id) sender{
    
    if (self.clickAction) {
        
        self.clickAction(self);
    }
}

#pragma mark -Accessor
- (void) setContentOffset:(UIOffset)contentOffset{
    
    if (!UIOffsetEqualToOffset(_contentOffset, contentOffset)) {
        
        _contentOffset = contentOffset;
        [self invalidateIntrinsicContentSize];
    }
}
@end
