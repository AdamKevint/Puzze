//
//  PuzzeViewController.h
//  JunPuzze
//
//  Created by Ibokan on 13-9-5.
//  Copyright (c) 2013年 majun. All rights reserved.
/***************************************************************
 *       ___       ______        ___         ____     ____      *
 *      / __ \    |  ___  \     / __ \      |  _ \   / _  |     *
 *     / /__\ \   | |    \ |   / /__\ \     | | \ \_/ / | |     *
 *    / ______ \  | |____/ |  / ______ \    | |  \___/  | |     *
 *   /_/      \_\ |_______/  /_/      \_\   |_|         |_|     *
 *                                                              *
 *********************about.me/adam_kevint**********************/



#import <UIKit/UIKit.h>
#import "MoveDelegate.h"
@interface PuzzeViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,MoveDelegate,UIGestureRecognizerDelegate,MoveDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@end
