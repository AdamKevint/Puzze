//
//  MoveCore.h
//  GlowPuzzle
//
//  Created by Ibokan on 13-9-3.
//  Copyright (c) 2013年 majun. All rights reserved.
//
/***************************************************************
 *       ___       ______        ___         ____     ____      *
 *      / __ \    |  ___  \     / __ \      |  _ \   / _  |     *
 *     / /__\ \   | |    \ |   / /__\ \     | | \ \_/ / | |     *
 *    / ______ \  | |____/ |  / ______ \    | |  \___/  | |     *
 *   /_/      \_\ |_______/  /_/      \_\   |_|         |_|     *
 *                                                              *
 *********************about.me/adam_kevint**********************/

#import <Foundation/Foundation.h>

@protocol MoveDelegate <NSObject,UIWebViewDelegate>
- (void)moveBlock:(int)tag ;
@end
