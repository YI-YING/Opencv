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

const int iWidth = 400, iHeight = 704, iCellWidth = 50, iCellHeight = 22;
const int iCellRows = iHeight / iCellHeight, iCellCols = iWidth / iCellWidth;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Mat matCanvas = Mat(Size_<int>(iWidth, iHeight), CV_8UC3, Scalar(255, 255, 255));
    [self makeColorSet];
    [self plotPalette:matCanvas];
    
    UIImageView *uiimageview = [[UIImageView alloc] initWithImage:[UIImage UIImageFromCVMat:matCanvas]];
    uiimageview.frame = CGRectMake(0, 20, iWidth, iHeight);
    
    
    [self.view addSubview:uiimageview];
}

- (void)makeColorSet
{
    
}

- (void)plotPalette:(Mat)image
{
    
}

@end
