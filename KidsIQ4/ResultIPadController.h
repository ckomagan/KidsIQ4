//
//  ResultController.h
//  KidsIQ4
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioToolbox.h"
#import "AVFoundation/AVFoundation.h"

@interface ResultIPadController : UIViewController <NSURLConnectionDelegate>
{
    IBOutlet UILabel *responseText;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *scoreLabel;
    NSMutableData *responseData;
}

@property (nonatomic, strong) NSString *name, *titleText, *score, *country, *paid;
@property Boolean paidFlag;

@property int maxQuestions, fCount, fTCount, mCount, mTCount, sCount, sTCount;
@property (nonatomic, retain) NSMutableData *responseData;
@property (strong, nonatomic) AVAudioPlayer *player;

-(IBAction)dismissView;
-(IBAction)loginScreen;
-(IBAction)leaderBoardScreen;
-(IBAction)FBScreen;

@end
