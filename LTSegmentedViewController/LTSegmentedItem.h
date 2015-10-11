//
//  LTSegmentedItem.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/15.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTSegmentedItem : UIView
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIImageView *bageImageView;
@property (nonatomic, strong, readonly) UIImageView *seperateLineImageView;
@property (nonatomic, assign) UIOffset contentOffset;
@property (nonatomic, copy) void((^clickAction)(LTSegmentedItem* item));

- (instancetype) initWithTitle:(NSString*) title action:(void(^)(LTSegmentedItem* item)) action;
- (instancetype) initWithTitle:(NSString*) title;
- (void) showBageImageView;
- (void) hideBageImageView;
- (void) showSeperateLineImageView;
- (void) hideSeperateLineImageView;
@end
