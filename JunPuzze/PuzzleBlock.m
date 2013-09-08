//
//  PuzzleCore.m
//  GlowPuzzle
//
//  Created by Ibokan on 13-9-3.
//  Copyright (c) 2013年 majun. All rights reserved.
/***************************************************************
 *       ___       ______        ___         ____     ____      *
 *      / __ \    |  ___  \     / __ \      |  _ \   / _  |     *
 *     / /__\ \   | |    \ |   / /__\ \     | | \ \_/ / | |     *
 *    / ______ \  | |____/ |  / ______ \    | |  \___/  | |     *
 *   /_/      \_\ |_______/  /_/      \_\   |_|         |_|     *
 *                                                              *
 *********************about.me/adam_kevint**********************/


#import "PuzzleBlock.h"

@implementation PuzzleBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColor.grayColor.CGColor;
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled=YES;
    }
    return self;
}
- (void)tapAction:(id)sender
{
    [self.delegate moveBlock:self.tag];
}

@end
