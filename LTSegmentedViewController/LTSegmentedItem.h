//
//  LTSegmentedItem.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/15.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTDataDefine.h"

@interface LTSegmentedItem : UIControl
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, assign) UIOffset contentOffset;
@property (nonatomic, copy) void((^clickAction)(LTSegmentedItem* item));

@property (nonatomic, assign) LTColor titleNormalColor;
@property (nonatomic, assign) LTColor titleSelectedColor;

@property (nonatomic, assign) CGFloat minimumScale;
@property (nonatomic, assign) CGFloat maximumScale;

- (instancetype) initWithTitle:(NSString*) title icon:(UIImage*) icon action:(void(^)(LTSegmentedItem* item)) action;
- (instancetype) initWithTitle:(NSString*) title icon:(UIImage*) icon;
@end