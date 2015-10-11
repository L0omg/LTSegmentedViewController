//
//  NSLayoutConstraint+ActiveConstraint.h
//  FormaxCopyMaster
//
//  Created by LIYINGPENG on 15/9/14.
//  Copyright (c) 2015年 Formax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (ActiveConstraint)
+ (void) fm_ActiveConstraints:(NSArray*) constraints toView:(UIView*) view;
+ (void) fm_DeActiveConstraints:(NSArray*) constraints inView:(UIView*) view;
- (void) fm_ActiveToView:(UIView*) view;
- (void) fm_DeActiveInView:(UIView*) view;
@end
