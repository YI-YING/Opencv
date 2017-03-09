//
//  ViewController.m
//  Practice1
//
//  Created by YI-YING on 2017/3/8.
//  Copyright © 2017年 MCU. All rights reserved.
//

#import "ViewController.h"
using namespace std;

#define Card_Num 52
#define Row 7
#define Column 5
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *uitxtvInformation;
@property (weak, nonatomic) IBOutlet UILabel *uilblQuetion;
@property (weak, nonatomic) IBOutlet UIButton *uibtYes;
@property (weak, nonatomic) IBOutlet UIButton *uibtNo;
@property (weak, nonatomic) IBOutlet UIButton *uibtStart;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nslyotcStart;


@property (nonatomic, strong) NSMutableArray *nsmusarrImages;
@property (nonatomic) CGSize cgsImage;
@property (nonatomic) int iYourCard;
@property (nonatomic) int iRun;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

#pragma mark - Data Processing
- (void)showPoker
{
    for (int j = 1; j <= 52; j++)
        if (j & (1 << self.iRun))
            [self displayCard:j atLocation:(int)self.nsmusarrImages.count];
    
    self.uilblQuetion.hidden = NO;
    self.uibtYes.hidden = NO;
    self.uibtNo.hidden = NO;
}

- (void)destroyAllImageView
{

    for (UIImageView *imageView in self.nsmusarrImages)
        [imageView removeFromSuperview];
    
    [self.nsmusarrImages removeAllObjects];
}

- (void)displayCard:(int)index atLocation:(int)location
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:(index < 10)? @"0%d.jpg": @"%d.jpg", index]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    int iOffSet = [UIApplication sharedApplication].statusBarFrame.size.height;

    imageView.frame = CGRectMake(location % Column * self.cgsImage.width, location / Column * self.cgsImage.height + iOffSet,
                                 self.cgsImage.width, self.cgsImage.height);
    
    [self.nsmusarrImages addObject:imageView];

    [self.view addSubview:imageView];
}

#pragma mark - Getter and Setter
- (CGSize)cgsImage
{
    int iOffSet = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat cgfWidth = int(self.view.frame.size.width / Column);
    CGFloat cgfHeight = int((self.view.frame.size.height -iOffSet) / Row);
    
    _cgsImage = CGSizeMake(cgfWidth, cgfHeight);
    
    return _cgsImage;
}

- (NSMutableArray *)nsmusarrImages
{
    if (!_nsmusarrImages)
        _nsmusarrImages = [NSMutableArray array];

    return _nsmusarrImages;
}

#pragma mark - Game Function
- (IBAction)gameStart:(UIButton *)sender
{
    self.uitxtvInformation.hidden = YES;
    self.iYourCard = 0;
    self.iRun = 0;

    sender.hidden = YES;
    
    [self destroyAllImageView];
    [self showPoker];

}

- (IBAction)choise:(UIButton *)sender
{
    self.uilblQuetion.hidden = YES;
    self.uibtYes.hidden = YES;
    self.uibtNo.hidden = YES;

    self.iYourCard = [sender isEqual:self.uibtYes] ?
        self.iYourCard | (1 << self.iRun) : self.iYourCard;

    self.iRun++;

    if (self.iRun < 6) {
        NSLog(@"%d", self.iYourCard);
        [self destroyAllImageView];
        [self showPoker];
    }
    else
        [self gameOver];
    
}

- (void)gameOver
{
    NSString *sTemp;
    sTemp = (!self.iYourCard || self.iYourCard > 52) ?
        @"You lie!\n\n Or \n\n You don't chose a card \n\n in mind!" : @"Can you believe!!! \n\n The magic thing \n\n will be happen !! \n\n The poker in your mind \n\n is";
    
    self.uitxtvInformation.text = sTemp;
    self.uitxtvInformation.hidden = NO;
    
    
    [self destroyAllImageView];
    
    if (self.iYourCard && self.iYourCard <= 52) {
        int iPosition = Row / 2 * Column + Column / 2;
        [self displayCard:self.iYourCard atLocation:iPosition];
    }
    
    [self.nslyotcStart setConstant:(self.iYourCard && self.iYourCard <= 52) ?50.0 : 0];
    [self.uibtStart setTitle:@"Restart" forState:UIControlStateNormal];
    self.uibtStart.hidden = NO;
    
    NSLog(@"%@", self.uibtStart);
}
@end
