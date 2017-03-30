//
//  ViewController.m
//  Practice3
//
//  Created by MCUCSIE on 3/30/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Opencv.h"
using namespace std;
using namespace cv;

typedef struct {
    unsigned char Blue[8];
    unsigned char Green[8];
    unsigned char Red[8];
} Palette_COLOR_TYPE;

const int iColorNum = 256;
const int iWidth = 400, iHeight = 736, iCellWidth = 50, iCellHeight = 23;
const int iCellRows = iHeight / iCellHeight, iCellCols = iWidth / iCellWidth;
Palette_COLOR_TYPE palette;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Mat matCanvas = Mat(Size_<int>(iWidth, iHeight), CV_8UC3, Scalar(255, 255, 255));
    
    
    
}

- (void)makeColorSet
{
    
}

- (void)plotPalette:(Mat)image
{
    
}

@end
