//
//  ViewController.m
//  Practice4
//
//  Created by MCUCSIE on 4/6/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Opencv.h"
using namespace std;
using namespace cv;

#define Flag_Width 300
#define Flag_Height 180
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Mat matFlags[3];
    
    for (int i = 0; i < 3; i++) {
        matFlags[i] = Mat(Size_<int>(Flag_Width, Flag_Height), CV_8UC4);
        
        [self makeAFlagWithImage:matFlags[i] andFlagIndex:i];
        [self showResult:matFlags[i] atLocation:i];
    }
    
}

- (void)showResult:(Mat)matrix atLocation:(NSInteger)location
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage UIImageFromCVMat:matrix]];
    imageView.frame = CGRectMake(0, 20 * (location + 1) + location * Flag_Height, Flag_Width, Flag_Height);
    [self.view addSubview:imageView];
    
}

- (void)makeAFlagWithImage:(Mat)image andFlagIndex:(NSInteger)index
{
    switch (index) {
        case 1:
            [self makeNetherlandsFlagWithImage:image];
            break;

        case 2:
            [self makeJapanFlagWithImage:image];
            break;
            
        default:
            [self makeFranceFlagWithImage:image];
    }
}

- (void)makeFranceFlagWithImage:(Mat)image
{
    int iInterval = image.cols / 3;
    
    Point_<int> pt1, pt2;
    Scalar sColor[3] = {Scalar(  0,   0, 255),
                        Scalar(255, 255, 255),
                        Scalar(255,   0,   0)};
    
    for (int i = 0; i < 3; i++) {
        pt1 = Point_<int>(i * iInterval, 0);
        pt2 = Point_<int>((i + 1) * iInterval, image.rows);
        rectangle(image, pt1, pt2, sColor[i], CV_FILLED);
    }
}

- (void)makeNetherlandsFlagWithImage:(Mat)image
{
    int iInterval = image.rows / 3;
    
    Point_<int> pt1, pt2;
    Scalar sColor[3] = {Scalar(255,   0,   0),
                        Scalar(255, 255, 255),
                        Scalar(  0,   0, 255)};
    
    for (int i = 0; i < 3; i++) {
        pt1 = Point_<int>(0, i * iInterval);
        pt2 = Point_<int>(image.cols, (i + 1) * iInterval);
        rectangle(image, pt1, pt2, sColor[i], CV_FILLED);
    }
    
}

- (void)makeJapanFlagWithImage:(Mat)image
{
    image = Scalar(255, 255, 255);
    circle(image, Point_<int>(image.cols / 2, image.rows / 2),
           image.rows / 4, Scalar(255, 0, 0), CV_FILLED);
}
@end
