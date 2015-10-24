//
//  LTSegmentedView.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/19.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSegmentedViewProtocol.h"
@interface LTSegmentedView : UIView<LTSegmentedViewProtocol>
@property (nonatomic, copy) NSArray/*<__kindof UIView*>*/ *items;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, assign) NSInteger numberOfItemsPerScreen;//default 4

- (instancetype) initWithItems:(NSArray/*<__kindof UIView *>*/*) items;
- (void) reloadItems;
- (void) addItem:(UIView*) item;
- (void) removeItemAtIndex:(NSInteger) index;
- (void) insertItem:(UIView*) item atIndex:(NSInteger) index;
@end
