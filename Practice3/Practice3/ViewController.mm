//
//  ViewController.m
//  Practice3
//
//  Created by MCUCSIE on 3/30/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Opencv.h"
#import "Palette.h"
using namespace std;
using namespace cv;

const int iWidth = 402, iHeight = 684, iCellWidth = 67, iCellHeight = 19;
const int iCellRows = iHeight / iCellHeight, iCellCols = iWidth / iCellWidth;

@interface ViewController ()

@property (nonatomic, strong) Palette *palette;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Mat matCanvas = Mat(Size_<int>(iWidth, iHeight), CV_8UC3, Scalar(255, 255, 255));
    self.palette = [Palette paletteWithHowManyColors:Palette216Colors];

    [self plotPalette:matCanvas];

    UIImageView *uiimageview = [[UIImageView alloc] initWithImage:[UIImage UIImageFromCVMat:matCanvas]];
    uiimageview.frame = CGRectMake(0, 20, iWidth, iHeight);
    


    [self.view addSubview:uiimageview];
}


- (void)plotPalette:(Mat)image
{
    Point_<int> pt1, pt2;
    Palette_Color_Set *pcsColorSet = (Palette_Color_Set *)[self.palette.nsdColorSet bytes];
    NSInteger nsiRed, nsiGreen, nsiBlue;

    for (int i = 0; i < iCellRows; i++) {
        pt1.y = i * iCellHeight;
        pt2.y = (i + 1) * iCellHeight;

        for (int j = 0; j < iCellCols; j++) {
            pt1.x = j * iCellWidth;
            pt2.x = (j + 1) * iCellWidth;

            nsiRed = pcsColorSet[i * iCellCols + j].ucRed;
            nsiGreen = pcsColorSet[i * iCellCols + j].ucGreen;
            nsiBlue = pcsColorSet[i * iCellCols + j].ucBlue;

            rectangle(image, pt1, pt2, Scalar(nsiBlue, nsiGreen, nsiRed), CV_FILLED);
        }
    }
}

@end
