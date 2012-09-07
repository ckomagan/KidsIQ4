//
//  ResultControllerIPad.h
//  KidsIQ4
//
//  Created by Chan Komagan on 9/4/12.
//
//

#import <UIKit/UIKit.h>

@interface ResultIPadController : UIViewController
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIButton *startoverBtn;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *score;
@property int maxQuestions;

-(IBAction)dismissView;
-(IBAction)loginScreen;

@end
