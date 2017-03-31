//
//  Palette.h
//  Practice3
//
//  Created by MCUCSIE on 3/30/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import <Foundation/Foundation.h>

//Define Palette Constant
typedef NS_ENUM(NSInteger, PaletteColorNumber) {
    Palette8Colors = 0,
    Palette16Colors,
    Palette216Colors,
    Palette256Colors
};

//Define Palette_Color_Set struct
typedef struct {
    unsigned char ucRed;
    unsigned char ucGreen;
    unsigned char ucBlue;
} Palette_Color_Set;

@interface Palette : NSObject

@property (nonatomic, strong) NSData *nsdBlue;
@property (nonatomic, strong) NSData *nsdGreen;
@property (nonatomic, strong) NSData *nsdRed;
@property (nonatomic) NSData *nsdColorSet;

+ (instancetype)paletteWithHowManyColors:(PaletteColorNumber)paletteColorNumber;

@end
