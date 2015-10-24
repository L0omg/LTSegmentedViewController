//
//  LTSegmentedViewItemProtocol.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/24.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LTSegmentedViewItemProtocol <NSObject>
@optional
- (void) willSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent;
- (void) didSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item;
- (void) willDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent;
- (void) didDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item;
@end
