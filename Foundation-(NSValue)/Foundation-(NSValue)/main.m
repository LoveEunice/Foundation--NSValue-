//
//  main.m
//  Foundation-(NSValue)
//
//  Created by qingyun on 16/4/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // NSValue 封装任意类型的数据
        int a=10;
        float b=11.1;
        double c=12.21;
        char d='s';
        BOOL e=YES;
        NSPoint point=NSMakePoint(21, 23);
        NSRange range=NSMakeRange(21, 22);
        NSSize size=NSMakeSize(32, 33);
        NSRect rect=NSMakeRect(1, 3, 3, 3);
        
        //装箱操作（数值类型--->对象）
        NSValue *intVal=[NSValue valueWithBytes:&a objCType:@encode(int)];
        NSValue *fVal=[NSValue valueWithBytes:&b objCType:@encode(float)];
        NSValue *dVal=[NSValue valueWithBytes:&c objCType:@encode(double)];
        NSValue *cValue=[NSValue valueWithBytes:&d objCType:@encode(char)];
        NSValue *bValue=[NSValue valueWithBytes:&e objCType:@encode(BOOL)];
        NSValue *pValue=[NSValue value:&point withObjCType:@encode(NSPoint)];
        
        //OC的结构体通常不用这两种装箱操作
        NSValue *rValue=[NSValue valueWithRange:range];
        NSValue *sValue=[NSValue valueWithSize:size];
        NSValue *reValue=[NSValue valueWithRect:rect];
        NSArray *arr1=@[intVal,fVal,dVal,cValue,bValue,pValue,rValue,sValue,reValue];
        NSLog(@"arr1=%@",arr1);
        //拆箱操作 （对象-->数值类型）
        double readDouble;
        [dVal getValue:&readDouble];
        NSLog(@"readDouble==%g",readDouble);
        // dval getvalue 
        NSPoint readPoint;
        [pValue getValue:&readPoint];
        NSLog(@"readPoint==%@",NSStringFromPoint(readPoint));//针对OC结构体，拆箱操作不用这种方式
        NSPoint readPoint2=[pValue pointValue];
        NSLog(@"readPoint===%@",NSStringFromPoint(readPoint2));
        NSLog(@"readRange===%@",NSStringFromRange([rValue rangeValue]));
        NSLog(@"readSize==%@",NSStringFromSize([sValue sizeValue]));
        NSLog(@"readRect==%@",NSStringFromRect([reValue rectValue]));
        //装箱C的结构体
        struct Student
        {
            char name[100];
            int age;
            char *sex;
        }s1={"xiaoming",21,"man"};
        NSValue *strValue=[NSValue valueWithBytes:&s1 objCType:@encode(struct Student)];
        NSLog(@"%@",strValue);
        //拆箱
        struct Student s2;
        [strValue getValue:&s2];
        NSLog(@"%s,%d,%s",s2.name,s2.age,s2.sex);
        
        char *str="hello";
        char str2[100]="qingyun";
        //装箱
        NSValue *strValue2=[NSValue valueWithBytes:str objCType:@encode(char *)];
        NSLog(@"%@",strValue2);
        NSValue *strValue3=[NSValue valueWithBytes:str2 objCType:@encode(char[])];
        NSLog(@"%@",strValue3);
        //拆箱
        char *readP=malloc(8);
//        char readP[100]={"\0"};
        NSLog(@"readP=%p",readP);
        [strValue2 getValue:readP];
        NSLog(@"readP==%p",readP);
        NSLog(@"read==%s",readP);
        
    }
    return 0;
}
