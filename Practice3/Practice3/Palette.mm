//
//  Palette.m
//  Practice3
//
//  Created by MCUCSIE on 3/30/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import "Palette.h"

@interface Palette ()

@property (nonatomic, readwrite) unsigned char *blue;
@property (nonatomic, readwrite) unsigned char *green;
@property (nonatomic, readwrite) unsigned char *red;

@end

static int colorNums[3][3] = {{2, 2, 2},
                              {4, 2, 2},
                              {8, 8, 4}};
@implementation Palette

- (Palette *)initPaletteWithColorNum:(int)nums
{
    self = [super init];
    
    [self setColorsWithColorNum:nums];
    
    return self;
}

- (void)setColorsWithColorNum:(int)nums
{
    int i
}

@end
