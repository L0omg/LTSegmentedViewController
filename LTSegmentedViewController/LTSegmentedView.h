//
//  LTSegmentedView.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/19.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSegmentedItem.h"
#import "LTSegmentedViewProtocol.h"
@interface LTSegmentedView : UIView<LTSegmentedViewProtocol>
@property (nonatomic, copy) NSArray<__kindof LTSegmentedItem*> *items;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *contentView;

- (instancetype) initWithItems:(NSArray<__kindof LTSegmentedItem*>*) items;
- (LTSegmentedItem*) selectedItem;
@end
