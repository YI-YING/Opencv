//
//  ViewController.m
//  Homework3
//
//  Created by MCUCSIE on 6/21/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import "UIImage+Opencv.h"
#import "ViewController.h"

using namespace std;
using namespace cv;

#define Historgram_Height 256
#define Historgram_Width 256

int iPDF[Historgram_Width];
int iCDF[Historgram_Width];

int iMax = 0;
int iTotal = 0;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageviewOriginal;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewResult;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewPDF;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewCDF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Mat matImages[4];

    matImages[0] = [[UIImage imageNamed: @"NeedStrengthImage.bmp"] cvMatGray];    // Original image
    matImages[1] = Mat(matImages[0].rows, matImages[0].cols, CV_8UC1);            // Result image
    matImages[2] = Mat(Historgram_Height, Historgram_Width, CV_8UC1, Scalar(0));  // PDF before strengthen
    matImages[3] = Mat(Historgram_Height, Historgram_Width, CV_8UC1, Scalar(0));  // PDF after strengthen

    [self drawPDFOf:matImages[0] at:matImages[2]];
    [self calcCDF:matImages[0]];
    [self imageStrengthenOriginalImage:matImages[0] to:matImages[1]];
    [self drawPDFOf:matImages[1] at:matImages[3]];

    for (int i = 0; i < 4; i++)
        [self drawImage:matImages[i] withID:i];

}

- (void)drawPDFOf:(Mat)image at:(Mat)pdf{
    for (int i = 0; i < Historgram_Width; i++)
        iPDF[i] = 0;

    int iColorValue;

    // Count PDF
    for (int i = 0; i < image.rows; i++)
        for (int j = 0; j < image.cols; j++) {
            iColorValue = (int)image.at<uchar>(i, j);
            iPDF[iColorValue]++;
        }

    // Count total pixel num and find max pixel num among 0~255
    for (int i = 0; i < Historgram_Width; i++) {
        iTotal += iPDF[i];

        if (iPDF[i] > iMax)
            iMax = iPDF[i];
    }

    Point_<int> pt1, pt2;
    for (int i = 0; i < Historgram_Width; i++) {
        pt1 = Point_<int>(i, 255);
        pt2 = Point_<int>(i, 255 - (double)iPDF[i] * 255 / iMax);
        line(pdf, pt1, pt2, Scalar(255));
    }
}

- (void)calcCDF:(Mat)image {

    iCDF[0] = iPDF[0];
    for (int i = 1; i < Historgram_Width; i++)
        iCDF[i] = iPDF[i] + iCDF[i -1];
}



- (void)imageStrengthenOriginalImage:(Mat)original to:(Mat)result {
    int iColorValue;

    for (int i = 0; i < original.rows; i++)
        for (int j = 0; j < original.cols; j++) {
            iColorValue = (int)original.at<uchar>(i, j);
            result.at<uchar>(i, j) = (double)iCDF[iColorValue] * 255 / iTotal;
        }
}


- (void)drawImage:(Mat)image withID:(int)ID {
    switch (ID) {
        case 0:
            self.imageviewOriginal.image = [UIImage UIImageFromCVMat:image];
            break;

        case 1:
            self.imageviewResult.image = [UIImage UIImageFromCVMat:image];
            break;

        case 2:
            self.imageviewPDF.image = [UIImage UIImageFromCVMat:image];
            break;

        case 3:
            self.imageviewCDF.image = [UIImage UIImageFromCVMat:image];
            break;
    }
}

@end
