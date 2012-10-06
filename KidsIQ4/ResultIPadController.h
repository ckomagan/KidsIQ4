//
//  ResultController.h
//  KidsIQ4
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultIPadController : UIViewController <NSURLConnectionDelegate>
{
    IBOutlet UILabel *responseText;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIButton *startoverBtn;
    NSMutableData *responseData;
}

@property (nonatomic, strong) NSString *name, *titleText, *score, *country, *paid;

@property int maxQuestions;
@property (nonatomic, retain) NSMutableData *responseData;

-(IBAction)dismissView;
-(IBAction)loginScreen;
-(IBAction)leaderBoardScreen;

@end
