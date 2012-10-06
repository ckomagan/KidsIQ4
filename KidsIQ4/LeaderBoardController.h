//
//  LeaderBoardController.h
//  KidsIQ5
//
//  Created by Chan Komagan on 9/21/12.
//  Copyright (c) 2012 Chan Komagan. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LeaderBoardController : UIViewController <UITableViewDelegate, UITextFieldDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *leaderList;
    IBOutlet UIButton *moreLeaders, *prevLeaders;
    NSMutableData *responseData;
    NSMutableArray *leaders, *columns, *nameList, *countryList, *scoreList;
    NSMutableArray *copyNameList, *copyCountryList, *copyScoreList;
    UITableViewCell *cell, *tvCell;
}

@property (nonatomic, retain) NSMutableData *responseData;

- (void)addColumn:(CGFloat)position;
-(IBAction)dismissView;
-(IBAction)loginScreen;
-(IBAction)showMoreLeaders;
-(IBAction)showPreviousLeaders;

@end
