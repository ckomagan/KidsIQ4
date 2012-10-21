//
//  LeaderBoardDetailController.h
//  KidsIQ4
//
//  Created by Chan Komagan on 10/19/12.
//  Copyright (c) 2012 Chan Komagan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardDetailController : UIViewController
{
    IBOutlet UILabel *nameLabel, *scoreLabel, *fCountLabel, *mCountLabel, *sCountLabel;
    IBOutlet UIProgressView *fCountView, *mCountView, *sCountView;
    IBOutlet UIImageView *imageView;
}
@property (nonatomic, retain) NSString *name, *country, *scoreDetail;
@property int fCount, mCount, sCount, fTCount, mTCount, sTCount;

- (NSString*)getFlags:(NSString*)countryname;

-(IBAction)dismissView;

@end
