//
//  ViewController.m
//  Homework2
//
//  Created by MCUCSIE on 4/1/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Opencv.h"
#import "Palette.h"
using namespace std;
using namespace cv;

#define Image_Height 180
#define Image_Width 180

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Mat matLena = [[UIImage imageNamed:@"LENA.bmp"] cvMatRGB];
    Mat matHouse = [[UIImage imageNamed:@"HOUSE.bmp"] cvMatRGB];
    Mat matResult = matLena.clone();
    
    [self quantizeMat:matResult toNColors:Palette256Colors];

    [self showResult:matLena atLocation:0];
    [self showResult:matResult atLocation:1];

    double dDifference = norm(matLena, matResult, CV_L1) / (matLena.rows * matLena.cols);

    NSLog(@"MAE = %f", dDifference);

}

- (void)showResult:(Mat)matrix atLocation:(int)location
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage UIImageFromCVMat:matrix]];
    imageView.frame = CGRectMake(0, 20 + location * Image_Height, Image_Width, Image_Height);
    [self.view addSubview:imageView];
    
}

- (void)quantizeMat:(Mat)image1 toNColors:(PaletteColorNumber)paletteColorNumber
{
    Palette *palette = [Palette paletteWithHowManyColors:paletteColorNumber];
    int iRInterval = 255 / (palette.nsdRed.length - 1);
    int iGInterval = 255 / (palette.nsdGreen.length - 1);
    int iBInterval = 255 / (palette.nsdBlue.length - 1);

    uchar *ucRed = (uchar *)palette.nsdRed.bytes;
    uchar *ucGreen = (uchar *)palette.nsdGreen.bytes;
    uchar *ucBlue = (uchar *)palette.nsdBlue.bytes;

    double dRedIndex, dGreenIndex, dBlueIndex;

    for (int y = 0; y < image1.rows; y++)
        for (int x = 0; x < image1.cols; x++) {
            dRedIndex = (double)image1.at<Vec4b>(y, x)[0] / iRInterval + 0.5;
            dGreenIndex = (double)image1.at<Vec4b>(y, x)[1] / iGInterval + 0.5;
            dBlueIndex = (double)image1.at<Vec4b>(y, x)[2] / iBInterval + 0.5;

            image1.at<Vec4b>(y, x)[0] = ucRed[int(dRedIndex)];
            image1.at<Vec4b>(y, x)[1] = ucGreen[int(dGreenIndex)];
            image1.at<Vec4b>(y, x)[2] = ucBlue[int(dBlueIndex)];

        }
    
}

@end
