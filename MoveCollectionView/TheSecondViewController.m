//
//  TheSecondViewController.m
//  MoveCollectionView
//
//  GitHub:https://github.com/szweee
//  Blog:  http://www.szweee.com
//
//  Created by 索泽文 on 16/5/30.
//  Copyright © 2016年 索泽文. All rights reserved.
//

#import "TheSecondViewController.h"
#import "AppDelegate.h"

@interface TheSecondViewController ()

@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation TheSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,200)];
    image.backgroundColor = [UIColor lightGrayColor];
    image.image = self.img;
    [self.view addSubview:image];
    _imageView =[[UIImageView alloc]init];
    _imageView.center = CGPointMake(70, 200);
    _imageView.bounds = CGRectMake(0, 0, 100, 100);
    _imageView.image = self.img;
    [self.view addSubview:_imageView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(0 ,100 ,100 ,50);
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [self expandCoop];
    
}

//放大的圈圈
-(void)expandCoop {
    CGRect rect = CGRectInset(_imageView.frame, -600, -600);
    
    CGPathRef startPath = CGPathCreateWithEllipseInRect(rect, NULL);
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(_imageView.frame, NULL);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = startPath;
    
    self.view.layer.mask = maskLayer;
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    pingAnimation.fromValue = (__bridge id)(endPath);
    pingAnimation.toValue   = (__bridge id)(startPath);
    pingAnimation.duration  = 1;
    pingAnimation.delegate = self;
    [pingAnimation setValue:@"animate1" forKey:@"animate1"];
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert1"];
    
    CGPathRelease(startPath);
    CGPathRelease(endPath);
}

//缩小的圈圈
-(void)scalaCoop {
    CGRect rect = CGRectInset(_imageView.frame, -600, -600);
    
    CGPathRef startPath = CGPathCreateWithEllipseInRect(rect, NULL);
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(_imageView.frame, NULL);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = endPath;
    
    self.view.layer.mask = maskLayer;
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.delegate = self;
    [pingAnimation setValue:@"animate2" forKey:@"animate2"];

    pingAnimation.fromValue = (__bridge id)(startPath);
    pingAnimation.toValue   = (__bridge id)(endPath);
    pingAnimation.duration  = 1;
    
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert2"];
    
    CGPathRelease(startPath);
    CGPathRelease(endPath);
    //[self performSelector:@selector(animation) withObject:nil afterDelay:2];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if ([[anim valueForKey:@"animate1"] isEqualToString:@"animate1"]) {
         [self removeImage];
    }else if([[anim valueForKey:@"animate2"] isEqualToString:@"animate2"]) {
        [self animation];
    }
}


-(void)removeImage {
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    [appdele.img removeFromSuperview];

}

-(void)addImage {
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    [appdele.window addSubview:appdele.img];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    imgView.image = appdele.img.image;
    imgView.backgroundColor = [UIColor lightGrayColor];
}

-(void)goBack:(UIButton *)sender {
    sender.enabled = NO;
    [self addImage];
    [self scalaCoop];
}

-(void)animation {
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    UIImageView *imageView = appdele.img;
    NSArray *vcArr = self.navigationController.viewControllers;
    UIViewController *vc = vcArr[vcArr.count-2];
    vc.view.alpha = 0;
    [appdele.window addSubview:vc.view];

    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            imageView.bounds = CGRectMake(0, 0, 110, 110);
            imageView.layer.shadowOffset = CGSizeMake(4, 4);
            imageView.layer.shadowRadius = 30;
            imageView.layer.shadowColor = [UIColor blackColor].CGColor;
            imageView.layer.shadowOpacity = 0.9;
            imageView.center = appdele.pushCenter;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^{
                imageView.bounds = CGRectMake(0,0, 100, 100);
                vc.view.alpha = 1;
                
            } completion:^(BOOL finished) {
                imageView.layer.shadowOffset = CGSizeMake(0, 0);
                imageView.layer.shadowRadius = 0;
                imageView.layer.shadowColor = [UIColor clearColor].CGColor;
                [appdele.img removeFromSuperview];
                [self performSelector:@selector(goToNextVc:) withObject:vc afterDelay:0.3];
            }];
        }];
    }];
}

-(void)goToNextVc:(UIViewController *)vc {
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)dealloc {
    
}
@end
