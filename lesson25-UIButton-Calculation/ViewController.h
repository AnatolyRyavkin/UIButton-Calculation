//
//  ViewController.h
//  lesson25-UIButton-Calculation
//
//  Created by Anatoly Ryavkin on 09/05/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVViewArea.h"


@interface ViewController : UIViewController
- (IBAction)divisionAction:(UIButton *)sender;
- (IBAction)multiplicationAction:(UIButton *)sender;
- (IBAction)subtractionAction:(UIButton *)sender;
- (IBAction)additionAction:(UIButton *)sender;
- (IBAction)resultAction:(UIButton *)sender;
- (IBAction)cleaningAction:(UIButton *)sender;
- (IBAction)changeSign:(UIButton *)sender;
- (IBAction)interestAction:(UIButton *)sender;
- (IBAction)commaAction:(UIButton *)sender;
- (IBAction)ziroAction:(UIButton *)sender;
- (IBAction)oneAction:(UIButton *)sender;
- (IBAction)twoAction:(UIButton *)sender;
- (IBAction)threeAction:(UIButton *)sender;
- (IBAction)fourAction:(UIButton *)sender;
- (IBAction)fiveAction:(UIButton *)sender;
- (IBAction)sixAction:(UIButton *)sender;
- (IBAction)sevenAction:(UIButton *)sender;
- (IBAction)eigthAction:(UIButton *)sender;
- (IBAction)nineAction:(UIButton *)sender;

- (IBAction)numberAction:(UIButton *)sender;
- (IBAction)operationAction:(UIButton *)sender;

-(int)number: (int) number inDegree: (int) degree;
-(void)outputResult: (CGFloat) resultFloat;

@property (weak) IBOutlet AVViewArea *baseArea;
@property (weak, nonatomic) IBOutlet UITextField *resultArea;

@property CGFloat resultNumber;
@property CGFloat setNumber;
@property CGFloat firstNumber;
@property CGFloat secondNumber;
@property NSMutableString* resultString;
@property int count;
@property BOOL flagChangeSign;
@property BOOL flagAdd;
@property BOOL flagComma;
@property BOOL flagOperationActive;
@property BOOL flagInputNumber;
@property BOOL flagZiro;
@property BOOL flagDeliver;
@property int countZiro;
@property (nonatomic, copy) CGFloat (^blockOperation)(CGFloat,CGFloat);
@end

