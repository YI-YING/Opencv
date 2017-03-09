//
//  CALayer+Border.m
//  Practice1
//
//  Created by 朱祐震 on 2017/3/10.
//  Copyright © 2017年 MCU. All rights reserved.
//

#import "CALayer+Border.h"

@implementation CALayer (Border)

- (void)setBorderIBColor:(UIColor *)borderIBColor
{
    self.borderColor = borderIBColor.CGColor;
}

- (UIColor *)borderIBColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
