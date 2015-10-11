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
@property (nonatomic, strong) UIImageView *bageImageView;
@property (nonatomic, strong) UIImageView *seperateLineImageView;
@end

@implementation LTSegmentedItem
#pragma mark -LifeCycle
- (instancetype) initWithTitle:(NSString*) title action:(void(^)(LTSegmentedItem* item)) action{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _contentView = ({
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:view];
            
            view;
        });
        
        _titleLabel = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            [_contentView addSubview:label];
            
            label;
        });
        
        _bageImageView = ({
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            [_contentView addSubview:imageView];
            
            imageView;
        });
        
        _seperateLineImageView = ({
        
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            [_contentView addSubview:imageView];
            
            imageView;
        });
        
        NSArray *v_ContentView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
        NSArray *h_ContentView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
        
        NSArray *v_TitleLabel_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)];
        NSArray *h_TitleLabel_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)];
        
        NSArray *v_BageImageView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bageImageView(<=30)]-3-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bageImageView)];
        NSArray *h_BageImageView_Constarints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_bageImageView(<=30)]-3-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bageImageView)];
        
        NSArray *v_SeperateLineImageView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_seperateLineImageView(1)]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_seperateLineImageView)];
        NSArray *h_SeperateLineImageView_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_seperateLineImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_seperateLineImageView)];
        
        [NSLayoutConstraint fm_ActiveConstraints:v_ContentView_Constraints toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:h_ContentView_Constraints toView:self];
        [NSLayoutConstraint fm_ActiveConstraints:v_TitleLabel_Constraints toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:h_TitleLabel_Constraints toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:v_BageImageView_Constraints toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:h_BageImageView_Constarints toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:v_SeperateLineImageView_Constraints toView:_contentView];
        [NSLayoutConstraint fm_ActiveConstraints:h_SeperateLineImageView_Constraints toView:_contentView];
        
        _clickAction = action;
        [_contentView addGestureRecognizer:({
        
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickContentView:)];
            tapGesture.delegate = self;
            
            tapGesture;
        })];
    }
    return self;
}

- (instancetype) initWithTitle:(NSString*) title{
    
    return [self initWithTitle:title action:NULL];
}
#pragma mark Super
- (instancetype) initWithFrame:(CGRect)frame{
    
    return [self initWithTitle:nil];
}

- (CGSize) intrinsicContentSize{
    
    return CGSizeMake(self.titleLabel.intrinsicContentSize.width + self.contentOffset.horizontal, self.titleLabel.intrinsicContentSize.height + self.contentOffset.vertical);
}

#pragma mark -User Interaction
- (void) onClickContentView:(UITapGestureRecognizer*) gesture{
    
    if ([gesture.view isEqual:self.contentView]) {
        
        if (self.clickAction) {
            
            self.clickAction(self);
        }
    }
}

#pragma mark -Public Methods
- (void) showBageImageView{
    
    self.bageImageView.hidden = NO;
}

- (void) hideBageImageView{
    
    self.bageImageView.hidden = YES;
}

- (void) showSeperateLineImageView{
    
    self.seperateLineImageView.hidden = NO;
}

- (void) hideSeperateLineImageView{
    
    self.seperateLineImageView.hidden = YES;
}

#pragma mark -Delegate
#pragma mark UIGestureRecognizerDelegate
- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer.view isEqual:self.contentView]) {
        
        if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            
            if (!self.clickAction) {
                
                return NO;
            }
        }
    }
    
    return YES;
}

#pragma mark -Accessor
- (void) setContentOffset:(UIOffset)contentOffset{
    
    if (!UIOffsetEqualToOffset(_contentOffset, contentOffset)) {
        
        _contentOffset = contentOffset;
        [self invalidateIntrinsicContentSize];
    }
}
@end
