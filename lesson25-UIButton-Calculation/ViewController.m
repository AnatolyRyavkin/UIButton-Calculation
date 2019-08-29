//
//  ViewController.m
//  lesson25-UIButton-Calculation
//
//  Created by Anatoly Ryavkin on 09/05/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView*v = [[AVViewArea alloc]initWithFrame:self.baseArea.frame];
    v.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0];
    [v setNeedsDisplay];
    self.resultString = [[NSMutableString alloc]initWithString:@"0"];
    [self.resultArea setNeedsDisplay];
    self.resultArea.text=self.resultString;
    self.count=1;
    self.flagOperationActive=NO;
    self.flagChangeSign=NO;
    self.flagInputNumber=NO;
    self.countZiro=0;
    self.flagDeliver=NO;
    self.blockOperation = ^CGFloat(CGFloat f1, CGFloat f2) {
        return f1;
    };
}

// степень
-(int)number: (int) number inDegree: (int) degree{
    int result=1;
    for(int i=0;i<degree;i++){
        result=result*number;
    }
    return result;
}

//очистка
- (IBAction)cleaningAction:(UIButton *)sender {
    self.resultNumber=0;
    self.firstNumber=0;
    self.secondNumber=0;
    self.setNumber=0;
    self.count=1;
    self.flagComma=NO;
    self.flagAdd=NO;
    self.flagOperationActive=NO;
    self.flagZiro=NO;
    [self outputResult:self.resultNumber];
    self.flagInputNumber=NO;
    self.flagDeliver=NO;
}

// изменение знака
- (IBAction)changeSign:(UIButton *)sender {
    self.setNumber=self.setNumber*(-1);
    [self outputResult:self.setNumber];
    self.flagChangeSign=YES;
    self.firstNumber=self.setNumber;
    if(self.flagOperationActive==NO && self.flagAdd==YES){
        self.resultNumber=self.resultNumber*(-1);
        [self outputResult:self.resultNumber];
         self.firstNumber=self.resultNumber;
        self.secondNumber=self.resultNumber;
         self.setNumber=self.resultNumber;
    }
}

//запятая
- (IBAction)commaAction:(UIButton *)sender {
    if(![self.resultString containsString:@"."]){
        self.count=1;
        [self.resultString appendString:@"."];
        self.resultArea.text=self.resultString;
    }
        self.flagComma=YES;
    if(self.flagAdd==YES)
        self.resultArea.text=@"0";
}

//печать
-(void)outputResult: (CGFloat) resultFloat{
if(resultFloat-(long int)resultFloat==0 && self.flagZiro!=YES){
    self.resultString=[NSMutableString stringWithFormat:@"%li",(long int)resultFloat];
}
else
    self.resultString=[NSMutableString stringWithFormat:@"%f",resultFloat];

if([self.resultString containsString:@"."]){
    NSArray*arrayStrPaths=[self.resultString componentsSeparatedByString:@"."];
    NSString*strFloatPathSecond=[arrayStrPaths objectAtIndex:1];
    NSUInteger i=[strFloatPathSecond length];
    BOOL ziro=YES;
    while(ziro==YES && i>=1){
        i=i-1;
        unichar char1=[strFloatPathSecond characterAtIndex:i];
        NSString*strTemp=[[NSString alloc]initWithCharacters:&char1 length:1];
        if(![strTemp isEqualToString:@"0"]){
            ziro=NO;
            break;
        };
        NSString*strFloatNewPathSecond;
        if(ziro==NO)
            strFloatNewPathSecond=[[NSMutableString alloc]initWithString:[strFloatPathSecond substringToIndex:i+1]];
        else
            strFloatNewPathSecond=[[NSMutableString alloc]initWithString:[strFloatPathSecond substringToIndex:i]];

    self.resultString=[NSMutableString stringWithFormat:@"%@%@%@",[arrayStrPaths objectAtIndex:0],@".",strFloatNewPathSecond];
    if(self.flagZiro==YES && [strFloatNewPathSecond length]<5){
        for(int i=0;i<=self.countZiro;i++)
        [self.resultString appendString:@"0"];
    }
    }
    if([self.resultString length]>16){
        unichar char1=[self.resultString characterAtIndex:16];
        NSString*char17=[[NSString alloc]initWithCharacters:&char1 length:1];
        if(char17.integerValue>4){
            unichar char1=[self.resultString characterAtIndex:15];
            NSString*char16=[[NSString alloc]initWithCharacters:&char1 length:1];
            NSString*char16New=[NSString stringWithFormat:@"%ld",char16.integerValue+1];
            [self.resultString replaceCharactersInRange:NSMakeRange(15, 1) withString:char16New];
        }
         self.resultString=[NSMutableString stringWithString:[self.resultString substringWithRange:NSMakeRange(0, 15)]];
    }
}else{
    if([self.resultString length]>16)
         self.resultString=[NSMutableString stringWithFormat:@"%@%@",@"E",[NSMutableString stringWithString:[self.resultString substringWithRange:NSMakeRange(0, 15)]]];
}
 self.resultArea.text=self.resultString;
}
//ввод числа
- (IBAction)numberAction:(UIButton *)sender {
    if(self.flagAdd==YES || (self.flagComma==YES && self.flagChangeSign==YES)){
        self.resultNumber=0;
        self.firstNumber=0;
        self.secondNumber=0;
        self.setNumber=0;
        self.count=1;
        self.flagComma=NO;
        self.flagAdd=NO;
        self.flagOperationActive=NO;
        self.flagZiro=NO;
        [self outputResult:self.resultNumber];
        self.flagInputNumber=NO;
        self.flagAdd=NO;
    }

    if(sender.tag==0 && self.flagComma==YES)
        self.flagZiro=YES;
    else
        self.flagZiro=NO;
    self.flagInputNumber=YES;
    if(self.flagChangeSign==YES){
        self.setNumber=0;
    }
    if(self.flagComma==YES){
        self.setNumber=self.setNumber+(CGFloat)sender.tag/[self number:10 inDegree:self.count];
        self.count=self.count+1;
    }else{
        self.setNumber=self.setNumber*10+sender.tag;
    }
    [self outputResult:self.setNumber];
    self.firstNumber=self.setNumber;
    self.flagChangeSign=NO;
    if(self.flagZiro==YES)
        self.countZiro++;
    else
        self.countZiro=0;
}
//подсчет и вывод
- (IBAction)resultAction:(UIButton *)sender {
    self.flagZiro=NO;
    self.flagInputNumber=NO;
    if(!(self.flagDeliver==YES && self.firstNumber==0)){
    self.resultNumber=self.blockOperation(self.firstNumber,self.secondNumber);
    [self outputResult:self.resultNumber];
    self.secondNumber=self.resultNumber;
    }else{
        self.resultArea.text=@"ERROR";
        self.resultNumber=0;
        self.firstNumber=0;
        self.secondNumber=0;
        self.setNumber=0;
        self.count=1;
        self.flagComma=NO;
        self.flagAdd=NO;
        self.flagOperationActive=NO;
        self.flagZiro=NO;
        self.flagInputNumber=NO;
        self.flagDeliver=NO;
    }
    self.flagOperationActive=NO;
    self.flagAdd=YES;
}
//выбор операции
- (IBAction)operationAction:(UIButton *)sender {
    self.flagZiro=NO;
    self.flagInputNumber=NO;
    self.flagComma=NO;
    self.setNumber=0;
    if(self.flagOperationActive==NO)
        self.secondNumber=self.firstNumber;
    if(self.flagAdd==YES)
        self.secondNumber=self.resultNumber;
    CGFloat (^block)(CGFloat,CGFloat)=self.blockOperation;
    switch (sender.tag) {
        case 11:
            self.blockOperation = ^CGFloat(CGFloat f1, CGFloat f2) {
                return f1+f2;
            };
            break;
        case 12:
            self.blockOperation = ^CGFloat(CGFloat f1, CGFloat f2) {
                return f2-f1;
            };
            break;
        case 13:
            self.flagDeliver=YES;
            self.blockOperation = ^CGFloat(CGFloat f1, CGFloat f2) {
                return f2/f1;
            };
            break;
        case 14:
            self.blockOperation = ^CGFloat(CGFloat f1, CGFloat f2) {
                return f1*f2;
            };
            break;
        case 15:
            self.blockOperation = ^CGFloat(CGFloat f1, CGFloat f2) {
                return f2/f1*100;
            };
            break;
        default:
            break;
    }
    if(self.flagOperationActive==YES && self.flagChangeSign==NO){
            self.resultNumber=block(self.firstNumber,self.secondNumber);
            [self outputResult:self.resultNumber];
            self.secondNumber=self.resultNumber;
    }
    self.flagChangeSign=NO;
    self.flagOperationActive=YES;
    self.flagAdd=NO;
}

//////////////////////////////////////////////////////////

    - (IBAction)ziroAction:(UIButton *)sender {
    }

    - (IBAction)oneAction:(UIButton *)sender {
    }

    - (IBAction)twoAction:(UIButton *)sender {
    }

    - (IBAction)threeAction:(UIButton *)sender {
    }

    - (IBAction)fourAction:(UIButton *)sender {
    }

    - (IBAction)fiveAction:(UIButton *)sender {
    }

    - (IBAction)sixAction:(UIButton *)sender {
    }

    - (IBAction)sevenAction:(UIButton *)sender {
    }

    - (IBAction)eigthAction:(UIButton *)sender {
    }

    - (IBAction)nineAction:(UIButton *)sender {
    }
- (IBAction)divisionAction:(UIButton *)sender {
}
- (IBAction)multiplicationAction:(UIButton *)sender {
}
- (IBAction)subtractionAction:(UIButton *)sender {
}
- (IBAction)additionAction:(UIButton *)sender {
}
- (IBAction)interestAction:(UIButton *)sender {
}
@end
