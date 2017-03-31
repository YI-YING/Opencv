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
    double dDifference, dMAE, dRMS, dSNR;
    
    for (int i = 0; i < 3; i++) {
        matResult[i] = Mat(matOriginal.rows, matOriginal.cols, CV_8UC1, Scalar(0));
        
        [self quantizeMat:matOriginal toNColors:iColorLevel[i] storeAt:matResult[i]];
        
        dDifference = norm(matOriginal, matResult[i], CV_L1) / (matOriginal.rows * matOriginal.cols);
        dMAE = [self MAEImage1:matOriginal withImage2:matResult[i]];
        dRMS = [self RMSImage1:matOriginal withImage2:matResult[i]];
        dSNR = [self SNRImage1:matOriginal withImage2:matResult[i]];
        NSLog(@"Norm %i: %f, MAE: %f, RMS: %f, SNR: %f",
              iColorLevel[i], dDifference, dMAE, dRMS, dSNR);
        
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
    int iInterval = (255 / (n - 1));
    
    for (int i = 0; i < n; i++)
        pv[i] = i * iInterval;

    
    for (int y = 0; y < image1.rows; y++)
        for (int x = 0; x < image1.cols; x++)
            image2.at<uchar>(y, x) = pv[image1.at<uchar>(y, x) / iInterval];
            
}

- (double)MAEImage1:(Mat)image1 withImage2:(Mat)image2
{
    double dMAE = 0;
    double dMN = image1.rows * image1.cols;

    for (int y = 0; y < image1.rows; y++)
        for (int x = 0; x < image1.cols; x++)
            dMAE += (abs(image2.at<uchar>(y, x) - image1.at<uchar>(y, x)) / dMN);
    
    return dMAE;
}

- (double)RMSImage1:(Mat)image1 withImage2:(Mat)image2
{
    double dRMS = 0;
    double dMN = image1.rows * image1.cols;
    
    for (int y = 0; y < image1.rows; y++)
        for (int x = 0; x < image1.cols; x++)
            dRMS += pow(image2.at<uchar>(y, x) - image1.at<uchar>(y, x), 2) / dMN;
    dRMS = sqrt(dRMS);
    
    return dRMS;
}

- (double)SNRImage1:(Mat)image1 withImage2:(Mat)image2
{
    double dSNR = 0;
    double dMN = image1.rows * image1.cols;
    
    for (int y = 0; y < image1.rows; y++)
        for (int x = 0; x < image1.cols; x++)
            dSNR += pow(image2.at<uchar>(y, x) - image1.at<uchar>(y, x), 2);
    
    dSNR = 10 * log10(dMN * pow(255, 2) / dSNR);
    
    return dSNR;
}

@end
