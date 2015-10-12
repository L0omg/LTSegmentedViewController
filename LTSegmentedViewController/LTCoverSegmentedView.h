//
//  LTCoverSegmentedView.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/11.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView.h"

@interface LTCoverSegmentedView : LTSegmentedView
@property (nonatomic, assign) UIOffset coverUIOffset;/**< 覆盖层在水平和垂直方向的尺寸抵消， default UIOffsetMake(5, 20)*/
@property (nonatomic, strong) UIColor *coverColor;/**< 覆盖层的颜色，default [UIColor colorWithWhite:1.f alpha:0.5]*/
@end

@interface LTCoverView : UIView

@end