//
//  ViewController.m
//  Practice2
//
//  Created by MCUCSIE on 3/20/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//
#import "ViewController.h"
#import "UIImage+Opencv.h"

using namespace cv;
using namespace std;

@implementation ViewController

#define Image_Height 180
#define Image_Width 180

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Mat matOriginal;
    matOriginal = [[UIImage imageNamed:@"lena.bmp"] cvMatGray];
    
    
    [self showResult:matOriginal atLocation:0];

    Mat matResult[3];
    int iColorLevel[3] = {8, 64, 256};
    double dDifference;
    
    for (int i = 0; i < 3; i++) {
        matResult[i] = Mat(matOriginal.rows, matOriginal.cols, CV_8UC1, Scalar(0));
        
        [self quantizeMat:matOriginal toNColors:iColorLevel[i] storeAt:matResult[i]];
        
        dDifference = norm(matOriginal, matResult[i], CV_L1) / (matOriginal.rows * matOriginal.cols);
        NSLog(@"Norm %i: %f", iColorLevel[i], dDifference);
        
        [self showResult:matResult[i] atLocation:i +1];
    }
    
    
    
}

- (void)showResult:(Mat)matrix atLocation:(int)location
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage UIImageFromCVMat:matrix]];
    imageView.frame = CGRectMake(0, 20 + location * Image_Height, Image_Width, Image_Height);
    [self.view addSubview:imageView];

}

- (void)quantizeMat:(Mat)image1 toNColors:(int)n storeAt:(Mat)image2
{
    unsigned char *pv = new unsigned char[n];
    int iInterval = (256 / n);
    
    for (int i = 0; i < n; i++)
        pv[i] = i * iInterval;

    
    for (int y = 0; y < image1.rows; y++)
        for (int x = 0; x < image1.cols; x++)
            image2.at<uchar>(y, x) = pv[image1.at<uchar>(y, x) / iInterval];
            
}

@end
