//
//  PuzzeViewController.m
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


#define SmallViewTag 123212
#define ViewTag 1231
#define Length 320
#define separateNumber 3

#import "PuzzeViewController.h"
#import "PuzzleBlock.h"
#define  LabelNumberTag 555
@interface PuzzeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *smallPhotoView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *photo;
@property BOOL isEndPlayingNow;
@property int number;
@property (strong, nonatomic) NSDictionary *mPhotos_33;
@property (strong, nonatomic) NSDictionary *mPhotos_44;
@property (strong, nonatomic) NSDictionary *mPhotos_55;
@property (strong, nonatomic) NSMutableDictionary *mPhotos;
@property (strong, nonatomic) NSDictionary *photos;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) NSNumber *operNumber;
@property CGRect smallViewRect;
@property BOOL returnSmallPhoto;
@property (strong, nonatomic) PuzzleBlock *whiteBlock;
@end

@implementation PuzzeViewController
@synthesize number;
@synthesize whiteBlock;
@synthesize operNumber;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.photo) self.photo = [UIImage imageNamed:@"mainPNG"];
    
    
    self.smallPhotoView.userInteractionEnabled = YES;
    self.smallPhotoView.image = self.photo;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTouched)];
    tapGesture.numberOfTapsRequired = 1;
    UITapGestureRecognizer *tapTwoGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(helpTap)];
    tapTwoGesture.numberOfTapsRequired = 2;
    [tapGesture requireGestureRecognizerToFail:tapTwoGesture];
    [self.smallPhotoView addGestureRecognizer:tapTwoGesture];
    [self.smallPhotoView addGestureRecognizer:tapGesture];
     _smallViewRect = CGRectMake(self.smallPhotoView.frame.origin.x, self.smallPhotoView.frame.origin.y,self.smallPhotoView.frame.size.width, self.smallPhotoView.frame.size.height);
    
    [self.view bringSubviewToFront:self.smallPhotoView];
    number = 3;
    [self startBy:number];
    UILabel *numberLabel = (UILabel *)[self.view viewWithTag:LabelNumberTag];
    self.font = numberLabel.font;
    UITapGestureRecognizer *tapNum = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeNumber)];
    [numberLabel addGestureRecognizer:tapNum];
    _isEndPlayingNow = YES;
    

}
#pragma mark HelpMethod
- (void)helpTap {
    UIView *backView = [self.view viewWithTag:ViewTag];
  

    if (_returnSmallPhoto){
        _returnSmallPhoto = NO;
        [UIView animateWithDuration:0.7 animations:^{
            self.smallPhotoView.frame = backView.frame;
            self.smallPhotoView.alpha = 0.7;
        }];
    }else {
        _returnSmallPhoto=YES;
        [UIView animateWithDuration:0.7 animations:^{
            self.smallPhotoView.frame = _smallViewRect;
            self.smallPhotoView.alpha = 1;
        }];
    }
}

- (IBAction)PanView:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
       if (_isEndPlayingNow) {
        if (location.y>290&&location.y<380)
        sender.view.center = CGPointMake(sender.view.center.x,location.y);
       
    }
}

#define ChangeNumber 9876
- (void) changeNumber {
    UILabel *numberLabel = (UILabel *)[self.view viewWithTag:LabelNumberTag];

    numberLabel.font = self.font;
    numberLabel.textColor = [UIColor orangeColor];
    if (_isEndPlayingNow) {
        switch (number) {
            case 3:
                number = 4;
                numberLabel.text = @"4×4";
                numberLabel.font = self.font;
                numberLabel.textColor = [UIColor orangeColor];
                break;
            case 4:
                number = 5;
                numberLabel.text = @"5×5";
                numberLabel.font = self.font;
                numberLabel.textColor = [UIColor orangeColor];
                break;
            case 5:
                number=3;
                numberLabel.text = @"3×3";
                numberLabel.font = self.font;
                numberLabel.textColor = [UIColor orangeColor];
                break;
            default:
                break;
        }
      
        [self startBy:number];
    } else [self stopActionSheet:ChangeNumber];
}
#define PHOTOTOUCHED 889776
#pragma mark pickImage from photLibrary
- (void)photoTouched {
    if (_returnSmallPhoto) {
      if (_isEndPlayingNow) {
    if (!self.imagePicker) self.imagePicker = [[UIImagePickerController alloc] init];
	self.imagePicker.delegate = self;
	self.imagePicker.allowsEditing = YES;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:self.imagePicker animated:YES completion:nil];
      } else [self stopActionSheet:PHOTOTOUCHED];}
}
- (void)displayPhoto {
  
    for (int i=3;i<6;i++) {
        NSString *photsMdict = [NSString stringWithFormat:@"mPhotos_%d%d",i,i];
        [self setValue:nil forKey:photsMdict];

    }
   
    self.smallPhotoView.image = self.photo;
    [self startBy:number];
   
}
- (void)stopActionSheet:(int)operation {
    NSString *operStr;
    switch (operation) {
        case ChangeNumber:
            operStr = @"YES,ChangeNumber&&Restart!";
            break;
        case PHOTOTOUCHED:
            operStr = @"YES,ChangePhoto&&Restart!";
            break;
        default:
            break;
    }
    operNumber = [NSNumber numberWithInt:operation];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"want to give up?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"No,continue to finish it!",operStr, nil];
    [actionSheet showInView:self.view];
}
#pragma mark actionsheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1 )
    {
         _isEndPlayingNow = YES;
        switch ([operNumber intValue]) {
            case ChangeNumber:
              
                [self changeNumber];
                break;
            case PHOTOTOUCHED:
               [self photoTouched];
                break;
            default:
                break;
        }
    }
}
- (void)startBy:(int)numberPass {
    [[self.view viewWithTag:99999] removeFromSuperview];
    NSString *photsMdict = [NSString stringWithFormat:@"mPhotos_%d%d",numberPass,numberPass];
    

    if (![self valueForKey:photsMdict]) [self seperatImage:self.photo byHorizontal:numberPass Vertical:numberPass ];
    self.photos = [self valueForKey:photsMdict];
    for (UIView *view in self.view.subviews) {
        if (view.tag == 22222) [view removeFromSuperview];
    }
    UIImageView *backView = (UIImageView *)[self.view viewWithTag:ViewTag];

    for (UIView *view in backView.subviews)
        [ view removeFromSuperview];
    CGFloat length = (CGFloat)Length/numberPass;
    
    if (numberPass<6&&numberPass>2)
    for (int i=0;i<numberPass;i++)
        for (int j=0;j<numberPass;j++)
        {
           
           
            if (i==0 && j==0) {
                PuzzleBlock *block = [[PuzzleBlock alloc] initWithFrame:CGRectMake(0, 0, length, length)];
                id obj = [self.photos objectForKey:[NSString stringWithFormat:@"%@_%d_%d.jpg",@"puzzle",0,0]];
                block.image = obj;
                block.tag = 0;
                block.xTag = [NSNumber numberWithInt:0];
                block.yTag = [NSNumber numberWithInt:0];
                block.delegate = self;
                [backView addSubview:block];
       
         
                
            } else {
            PuzzleBlock *block = [[PuzzleBlock alloc] initWithFrame:CGRectMake(length*j, length*i, length, length)];
            id obj = [self.photos objectForKey:[NSString stringWithFormat:@"%@_%d_%d.jpg",@"puzzle",i,j]];
            block.image = obj;
            block.tag = i*numberPass + j;
            block.xTag = [NSNumber numberWithInt:j];
            block.yTag = [NSNumber numberWithInt:i];
            block.delegate = self;
            [backView addSubview:block];
            if (i==numberPass-1&&j==numberPass-1) {
                block.image = nil;
                whiteBlock = block;
                }
            }
        }

    for (int i=0;i<250;i++)
    {
        NSMutableArray *mmArray = [NSMutableArray arrayWithCapacity:4];
        for (PuzzleBlock *block in backView.subviews)
            if (abs([block.xTag intValue]-[whiteBlock.xTag intValue])+abs([block.yTag intValue]-[whiteBlock.yTag intValue])==1) [mmArray addObject:[NSNumber numberWithInt:block.tag]];
        
        int newTag = 99;
                int number4 = arc4random()%4;
             
             switch (number4) {
                 case 0:
                     newTag = [[mmArray objectAtIndex:0] intValue];
                     break;
                 case 1:
                     newTag = [[mmArray objectAtIndex:1] intValue];
                     break;
                 case 2:
                     if (mmArray.count>2)
                     newTag = [[mmArray objectAtIndex:2] intValue];
                     break;
                 case 3:
                     if (mmArray.count>3)
                         newTag = [[mmArray objectAtIndex:3] intValue];
                     break;

                 default:
                     break;
             }
        if (newTag!=99) {
            PuzzleBlock *movedBlock = (PuzzleBlock *)[backView viewWithTag:newTag];
            if ([movedBlock.xTag intValue]==number-1&&[movedBlock.yTag intValue]==number-1) i--;
            else [self moveBlock:newTag];
        }else i--;
         
    }
    _isEndPlayingNow = YES;
    
      
}

- (void)moveBlock:(int)tag {
    _isEndPlayingNow = NO;
    UIImageView *backView = (UIImageView *)[self.view viewWithTag:ViewTag];

    int whiteX = [whiteBlock.xTag intValue];
    int whiteY = [whiteBlock.yTag intValue];
  
    PuzzleBlock *block = (PuzzleBlock *)[backView viewWithTag:tag];
    int blockX = [block.xTag intValue];
    int blockY = [block.yTag intValue];
    if (abs(blockX-whiteX) + abs(blockY-whiteY)==1) {
        CGPoint Center = block.center;
        [UIView animateWithDuration:0.3 animations:^{
            block.center = whiteBlock.center;
            block.xTag = [NSNumber numberWithInt:whiteX];
            block.yTag = [NSNumber numberWithInt:whiteY];
            whiteBlock.center = Center;
            whiteBlock.xTag = [NSNumber numberWithInt:blockX];
            whiteBlock.yTag = [NSNumber numberWithInt:blockY];
        }];
    }
    if ([whiteBlock.xTag intValue] == number-1 && [whiteBlock.yTag intValue] == number-1)
        [self isPlayerWin];
}
- (void)isPlayerWin {
  
    BOOL isWin = YES;
    for (int i=1;i<number*number;i++) {
        PuzzleBlock *block = (PuzzleBlock *)[self.view viewWithTag:i];
        if ([block.xTag intValue]==i%number && [block.yTag intValue]==i/number) isWin=YES;
        else {
            isWin = NO;
            break;
        }
    }
    
    
    if (isWin) [self ifWin];
    
}
- (void)ifWin{
    UIImageView *backView = (UIImageView *)[self.view viewWithTag:ViewTag];
    CGRect centerFrame = CGRectMake(backView.frame.origin.x, backView.frame.origin.y, backView.frame.size.width, backView.frame.size.height);
    UIImageView *imageIview = [[UIImageView alloc] initWithFrame:centerFrame];
    imageIview.tag = 99999;
    imageIview.image = self.photo;
    [self.view addSubview:imageIview];
    _isEndPlayingNow = YES;
    UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:@"^*^" message:@"Congratulations!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue",@"exit", nil];
    winAlert.delegate = self;
    [winAlert show];
}
#pragma mark AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) [self startBy:number];
    else if (buttonIndex == 1) exit(0);
}
#pragma mark seperateImage
- (void)seperatImage:(UIImage*)image byHorizontal:(int)x Vertical:(int)y  {
   	//kill errors
	if (x<1) {
		NSLog(@"illegal x!");

	}else if (y<1) {
		NSLog(@"illegal y!");
	
	}
    if (![image isKindOfClass:[UIImage class]]) {
                NSLog(@"illegal image format!");

    }

    //attributes of element
    float _xstep=image.size.width*1.0/y;
    float _ystep=image.size.height*1.0/x;
  
    if (!self.mPhotos) self.mPhotos = [NSMutableDictionary dictionaryWithCapacity:2];
    else [self.mPhotos removeAllObjects];
    NSString *prefixName = @"puzzle";
    
   //snap in context and create element image view
    for (int i=0;i<x;i++)
        for (int j=0;j<y;j++)
            {
                CGRect rect = CGRectMake(_xstep*j, _ystep*i, _xstep, _ystep);
                CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
                UIImage *elementImage = [UIImage imageWithCGImage:imageRef];
                NSString *_imageString = [NSString stringWithFormat:@"%@_%d_%d.jpg",prefixName,i,j];
                [self.mPhotos setObject:elementImage forKey:_imageString];
             }
    NSString *photsMdict = [NSString stringWithFormat:@"mPhotos_%d%d",x,y];
    [self setValue:[NSDictionary dictionaryWithDictionary:self.mPhotos] forKey:photsMdict];
  
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
	self.photo = [info objectForKey:UIImagePickerControllerEditedImage];
    [self displayPhoto];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -  noRotationScreen
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}
#pragma mark memoryNotition

@end
