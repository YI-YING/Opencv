//
//  Palette.h
//  Practice3
//
//  Created by MCUCSIE on 3/30/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Palette : NSObject

@property (nonatomic, readonly) unsigned char *blue;
@property (nonatomic, readonly) unsigned char *green;
@property (nonatomic, readonly) unsigned char *red;

- (Palette *)initPaletteWithColorNum:(int)nums;

@end
