//
//  Palette.m
//  Practice3
//
//  Created by MCUCSIE on 3/30/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import "Palette.h"

//Color number pattern
static NSInteger colorNums[4][3] = {{2, 2, 2},
                              {4, 2, 2},
                              {6, 6, 6},
                              {8, 8, 4}};
@implementation Palette

//Use constant to create a palette
+ (instancetype)paletteWithHowManyColors:(PaletteColorNumber)paletteColorNumber
{
    Palette *palette = [[self alloc] init];
    
    [palette setColorsWithColorNumber:paletteColorNumber];
    
    return palette;
}

- (void)setColorsWithColorNumber:(NSInteger)colorNum
{
    NSInteger iRedColorNum = colorNums[colorNum][0];
    NSInteger iGreenColorNum = colorNums[colorNum][1];
    NSInteger iBlueColorNum = colorNums[colorNum][2];
    
    self.nsdRed = [self makeColorLevelWithColorNumber:iRedColorNum];
    self.nsdGreen = [self makeColorLevelWithColorNumber:iGreenColorNum];
    self.nsdBlue = [self makeColorLevelWithColorNumber:iBlueColorNum];
    self.nsdColorSet = [self makeColorSetWithRedColorNum:iRedColorNum andGreenColorNum:iGreenColorNum andBlueColorNum:iBlueColorNum];
}

- (NSData *)makeColorLevelWithColorNumber:(NSInteger)colorNum
{
    unsigned char *ucColorLevel = new unsigned char[colorNum];
    NSData *nsdColorLevel = [NSData dataWithBytesNoCopy:ucColorLevel length:sizeof(unsigned char) * colorNum];
    NSInteger iInterval = 255 / (colorNum - 1);

    for (NSInteger i = 0; i < colorNum; i++)
        ucColorLevel[i] = i * iInterval;

    return nsdColorLevel;
}

- (NSData *)makeColorSetWithRedColorNum:(NSInteger)redNum andGreenColorNum:(NSInteger)greenNum andBlueColorNum:(NSInteger)blueNum
{
    NSInteger colorSetSize = redNum * greenNum * blueNum;
    Palette_Color_Set *pcsColorSet = new Palette_Color_Set[colorSetSize];
    NSData *nsdColorSet = [NSData dataWithBytesNoCopy:pcsColorSet length:sizeof(Palette_Color_Set) * colorSetSize];
    
    NSInteger ptr;
    for (NSInteger i = 0; i < redNum; i++)
        for (NSInteger j = 0; j < greenNum; j++)
            for (NSInteger k = 0; k < blueNum; k++) {
                ptr = i * greenNum * blueNum + j * blueNum + k;
                
                pcsColorSet[ptr].ucRed = ((unsigned char *)self.nsdRed.bytes)[i];
                pcsColorSet[ptr].ucGreen = ((unsigned char *)self.nsdGreen.bytes)[j];
                pcsColorSet[ptr].ucBlue = ((unsigned char *)self.nsdBlue.bytes)[k];
            }
                
    return nsdColorSet;
}
@end
