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
- (void) segmentedView:(UIView*) segmentedView willSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent;
- (void) segmentedView:(UIView*) segmentedView didSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item;
- (void) segmentedView:(UIView*) segmentedView willDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent;
- (void) segmentedView:(UIView*) segmentedView didDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item;
@end
