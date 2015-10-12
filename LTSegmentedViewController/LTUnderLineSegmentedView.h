//
//  LTUnderLineSegmentedView.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/11.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView.h"

@interface LTUnderLineSegmentedView : LTSegmentedView
@property (nonatomic, assign) CGFloat underLineheight;/**< 下划线高度，default 2*/
@property (nonatomic, strong) UIColor *underLineColor;/**< 下划线颜色，default blueColor*/
@end
