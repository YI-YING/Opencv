//
//  UIImage+UIImage_Opencv.h
//  Practice2
//
//  Created by MCUCSIE on 3/20/17.
//  Copyright © 2017 MCUCSIE. All rights reserved.
//
#pragma clang diagnostic ignored "-Wdocumentation"
#import <opencv2/opencv.hpp>
#import <UIKit/UIKit.h>

//Add Medthod for transform UIImage to/from Mat format
@interface UIImage (Opencv)

- (cv::Mat)cvMatGray;
- (cv::Mat)cvMatRGB;
+ (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;

@end
