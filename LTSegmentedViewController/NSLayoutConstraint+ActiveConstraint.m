//
//  NSLayoutConstraint+ActiveConstraint.m
//  FormaxCopyMaster
//
//  Created by LIYINGPENG on 15/9/14.
//  Copyright (c) 2015年 Formax. All rights reserved.
//

#import "NSLayoutConstraint+ActiveConstraint.h"

@implementation NSLayoutConstraint (ActiveConstraint)
+ (void) fm_ActiveConstraints:(NSArray*) constraints toView:(UIView*) view{
    
    if (constraints && constraints.count > 0) {
        
        if ([[self class] respondsToSelector:@selector(activateConstraints:)]) {
            
            [NSLayoutConstraint activateConstraints:constraints];
        }else{
            
            [view addConstraints:constraints];
        }
    }
}

+ (void) fm_DeActiveConstraints:(NSArray*) constraints inView:(UIView*) view{
    
    if (constraints && constraints.count > 0) {
        
        if ([[self class] respondsToSelector:@selector(deactivateConstraints:)]) {
            
            [NSLayoutConstraint deactivateConstraints:constraints];
        }else{
            
            [view removeConstraints:constraints];
        }
    }
}

- (void) fm_ActiveToView:(UIView*) view{
    
    if ([self respondsToSelector:@selector(setActive:)]) {
        
        self.active = YES;
    }else{
        
        [view addConstraint:self];
    }
}

- (void) fm_DeActiveInView:(UIView*) view{
    
    if ([self respondsToSelector:@selector(setActive:)]) {
        
        self.active = NO;
        
    }else{
        
        [view removeConstraint:self];
    }
}
@end
