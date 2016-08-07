//
//  AppDelegate.h
//  MoveCollectionView
//
//  GitHub:https://github.com/szweee
//  Blog:  http://www.szweee.com
//
//  Created by 索泽文 on 16/5/30.
//  Copyright © 2016年 索泽文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,assign)CGPoint pushCenter;
@property(nonatomic,assign)CGPoint popCenter;

@end

