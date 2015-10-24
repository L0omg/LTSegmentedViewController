//
//  LTDataDefine.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/11.
//  Copyright © 2015年 LYP. All rights reserved.
//

#ifndef LTDataDefine_h
#define LTDataDefine_h

#define LT_INLINE static inline

struct LTColor{
    
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
};
typedef struct LTColor LTColor;

/*** Definitions of inline functions. ***/
LT_INLINE LTColor
LTColorMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
    LTColor color;color.r = r;color.g = g;color.b = b; color.a = a; return color;
}

LT_INLINE bool
LTColorEqualToColor(LTColor color1, LTColor color2)
{
    
    return (color1.r == color2.r && color1.g == color2.g && color1.b == color2.b && color1.a == color2.a);
}

LT_INLINE UIColor*
LTColorToUIColor(LTColor color)
{
    return [UIColor colorWithRed:color.r / 0xFF green:color.g / 0xFF blue:color.b / 0xFF alpha:color.a];
}

LT_INLINE LTColor
LTGradualColor(LTColor frontColor, LTColor backColor, CGFloat percent)
{
    LTColor color = {0, 0, 0, 0};
    color.r = (backColor.r - frontColor.r) * percent + frontColor.r;
    color.g = (backColor.g - frontColor.g) * percent + frontColor.g;
    color.b = (backColor.b - frontColor.b) * percent + frontColor.b;
    color.a = (backColor.a - frontColor.a) * percent + frontColor.a;
    return color;
}

LT_INLINE UIColor*
UIColorFromRGBHex(NSInteger hexValue)
{
    UIColor *color = [UIColor colorWithRed:((hexValue & 0xFF0000 >> 16) / 255.f) green:((hexValue & 0xFF00 >> 8) / 255.f) blue:((hexValue & 0xFF) / 255.f) alpha:1.f];
    return color;
}

#endif /* LTDataDefine_h */
