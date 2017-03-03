//
//  HomeCourseDetailModel.h
//  第三方框架
//
//  Created by 金亮齐 on 2017/3/3.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCourseDetailModel : NSObject

@property (nonatomic, strong) NSString *CourseID;
@property (nonatomic, strong) NSString *SID;
@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *CourseType;
@property (nonatomic, strong) NSString *Status;

@property (nonatomic, strong) NSString *SaleStatus;
@property (nonatomic, strong) NSString *StudentNumber;
@property (nonatomic, strong) NSString *TrialNumber;
@property (nonatomic, strong) NSString *AppraiseGoodCount;
@property (nonatomic, strong) NSString *AppraiseMiddleCount;

@property (nonatomic, strong) NSString *AppraiseBadCount;
@property (nonatomic, strong) NSString *CourseInfoVer;
@property (nonatomic, strong) NSString *ClassListVer;
@property (nonatomic, strong) NSString *ClassHour;
@property (nonatomic, strong) NSString *Cost;

@property (nonatomic, strong) NSString *ExpiryTime;
@property (nonatomic, strong) NSString *PayEndTime;
@property (nonatomic, strong) NSString *AssureTimeLength;
@property (nonatomic, strong) NSString *PayStudentLimit;
@property (nonatomic, strong) NSString *LiveStudentLimit;

@property (nonatomic, strong) NSString *CourseName;
@property (nonatomic, strong) NSString *PhotoURL;
@property (nonatomic, strong) NSString *Brief;
@property (nonatomic, strong) NSString *KeyWords;
@property (nonatomic, strong) NSString *Courseware;

@property (nonatomic, strong) NSString *Individuation;
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *VideoDownload;
@property (nonatomic, strong) NSNumber *ClassNumber;
@property (nonatomic, strong) NSString *SchoolName;

@property (nonatomic, strong) NSMutableArray *StepList;
@property (nonatomic, strong) NSString *TotalAppraise;
@property (nonatomic, strong) NSString *IsCollect;

@end
