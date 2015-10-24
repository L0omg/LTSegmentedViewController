//
//  LTSegmentedItem.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/15.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import "LTSegmentedItem.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "LTSegmentedViewItemProtocol.h"

#pragma mark -Constant Define
static const CGFloat LTSegmentedItemDefaultTitleNormalFontSize = 10;
static const CGFloat LTSegmentedItemDefaultTitleSelectedFontSize = 25;
static const struct LTColor LTSegmentedItemDefaultTitleNormalColor = {0x00, 0x00, 0xFF, 1};
static const struct LTColor LTSegmentedItemDefaultTitleSelectedColor = {0x33, 0x33, 0x33, 1};

@interface LTSegmentedItem()<UIGestureRecognizerDelegate, LTSegmentedViewItemProtocol>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation LTSegmentedItem
#pragma mark -LifeCycle
- (instancetype) initWithTitle:(NSString*) title icon:(UIImage*) icon action:(void(^)(LTSegmentedItem* item)) action{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _titleNormalColor = LTSegmentedItemDefaultTitleNormalColor;
        _titleNormalFontSize = LTSegmentedItemDefaultTitleNormalFontSize;
        _titleSelectedColor = LTSegmentedItemDefaultTitleSelectedColor;
        _titleSelectedFontSize = LTSegmentedItemDefaultTitleSelectedFontSize;
        
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
            label.textColor = LTColorToUIColor(_titleNormalColor);
            label.font = [UIFont systemFontOfSize:_titleNormalFontSize];
            [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [_contentView addSubview:label];
            
            label;
        });
        
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
    
    return CGSizeMake(self.titleLabel.intrinsicContentSize.width + self.contentOffset.horizontal, self.titleLabel.intrinsicContentSize.height + self.contentOffset.vertical);
}

#pragma mark -User Interaction
- (void) onClickSelf:(id) sender{
    
    if (self.clickAction) {
        
        self.clickAction(self);
    }
}

#pragma mark -Protocol
#pragma mark 
- (void) willSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent{
    
    self.titleLabel.font = [UIFont systemFontOfSize:((self.titleSelectedFontSize - self.titleNormalFontSize) * percent) + self.titleNormalFontSize];
    self.titleLabel.textColor = LTColorToUIColor(LTGradualColor(self.titleNormalColor, self.titleSelectedColor, percent));
}

- (void) didSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item{
    
    self.titleLabel.textColor = LTColorToUIColor(self.titleSelectedColor);
    self.titleLabel.font = [UIFont systemFontOfSize:self.titleSelectedFontSize];
}

- (void) willDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent{
    
    self.titleLabel.font = [UIFont systemFontOfSize:((self.titleSelectedFontSize - self.titleNormalFontSize) * percent) + self.titleNormalFontSize];
    self.titleLabel.textColor = LTColorToUIColor(LTGradualColor(self.titleNormalColor, self.titleSelectedColor, percent));
}

- (void) didDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item{
    
    self.titleLabel.textColor = LTColorToUIColor(self.titleNormalColor);
    self.titleLabel.font = [UIFont systemFontOfSize:self.titleNormalFontSize];
}

#pragma mark -Accessor
- (void) setContentOffset:(UIOffset)contentOffset{
    
    if (!UIOffsetEqualToOffset(_contentOffset, contentOffset)) {
        
        _contentOffset = contentOffset;
        [self invalidateIntrinsicContentSize];
    }
}

@end
