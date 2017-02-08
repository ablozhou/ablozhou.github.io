---
author: abloz
comments: true
date: 2008-06-18 09:36:30+00:00
layout: post
link: http://abloz.com/index.php/2008/06/18/a-calculation-of-the-beijing-2008-after-tax-income-of-python-code-updated/
slug: a-calculation-of-the-beijing-2008-after-tax-income-of-python-code-updated
title: 一段计算北京2008年最新税后收入的python代码
wordpress_id: 316
categories:
- 技术
tags:
- python
---


下面的代码用于计算北京2008年7月1号后，扣除社会保险，公积金和个人所得税后收入。如果和你的收入不一致，可能公司财务计算基数等有差别。根据自己需要修改代码即可。

用法：money(税前工资，是否有社会保险（0，1），是否有住房公积金（0，1）)

    
    
    #!/bin/env python
    
    # author: zhouhh
    
    # email: ablozhou@gmail.com
    
    # date: 2008.6.17
    
    # money.py
    
    
    
    def money(all_salary,has_welfare,has_housing_fund):
    
        money = all_salary
    
        bj_average_salary=3322;#in 2008 using average salary of year 2007
    
        min = bj_average_salary*0.6
    
        max = bj_average_salary*3
    
        welfare_fund = all_salary
    
        if all_salary > max:
    
            welfare_fund = max
    
        if all_salary < min:
    
            welfare_fund = min
    
        print("total money=%.2f"%all_salary)
    
        medical_fund=welfare_fund*0.02+3
    
        retire_fund=welfare_fund*0.08
    
        unemploy_fund =welfare_fund*0.005
    
        if not has_welfare:
    
            welfare_fund = 0
    
            medical_fund=0
    
            retire_fund=0
    
            unemploy_fund =0
    
        else:
    
            print("medical fund = %d*0.02+3=%.2f"%(welfare_fund,medical_fund) )
    
            print("retirement fund = %d*0.08 =%.2f"%(welfare_fund,retire_fund) )
    
            print("unemployment fund  = %d*0.005=%.2f"%(welfare_fund,unemploy_fund ))
    
        housing_fund=welfare_fund*0.12
    
        if  not has_housing_fund:
    
            housing_fund = 0
    
        else:
    
            print("housing fund = %d*0.12=%.2f"%(welfare_fund,housing_fund))
    
        all_welfare_fund=medical_fund+retire_fund+unemploy_fund +housing_fund
    
        print("all welfare fund=%.2f"% all_welfare_fund)
    
        money -=all_welfare_fund
    
        before_tax = money
    
        print("before tax money =%.2f"%before_tax )
    
        if before_tax < 2000 :
    
            print(" you have no tax,you own money=%.2f"%before_tax)
    
            return before_tax
    
            #after 2008.3.1 tax
    
        l1=500*0.05 #2000-2500, %5
    
        l2=1500*0.10 #2500-4000 %10              +=25
    
        l3=3000*0.15 #4000-7000 %0.15           +=175
    
        l4=15000*0.20 #7000-22000 %20         += 625
    
        l5=20000*0.25 #22000-42000 %25      +=3625
    
        l6=20000*0.30 #42000-62000 %30      +=8625
    
        l7=20000*0.35 #62000-82000 %35      +=14625
    
        l8=20000*0.40 #82000-102000 %40    +=21625
    
        l9=0                                          #    +=29625
    
        money -=2000
    
        tax=0;
    
        if money<500:
    
            l1=money*0.05
    
            tax=l1
    
            print("you are in level 1,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 500
    
        if money<1500:
    
            l2=money*0.10
    
            tax=l1+l2
    
            print("you are in level 2,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 1500
    
        if money<3000:
    
            l3=money*0.15
    
            tax=l1+l2+l3
    
            print("you are in level 3,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 3000
    
        if money<15000:
    
            l4=money*0.20
    
            tax=l1+l2+l3+l4
    
            print("you are in level 4,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 15000
    
        if money<20000:
    
            l5=money*0.25
    
            tax=l1+l2+l3+l4+l5
    
            print("you are in level 5,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 20000
    
        if money<20000:
    
            l6=money*0.30
    
            tax=l1+l2+l3+l4+l5+l6
    
            print("you are in level 6,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 20000
    
        if money<20000:
    
            l7=money*0.35
    
            tax=l1+l2+l3+l4+l5+l6+l7
    
            print("you are in level 7,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 20000
    
        if money<20000:
    
            l8=money*0.40
    
            tax=l1+l2+l3+l4+l5+l6+l7+l8
    
            print("you are in level 8,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
            return before_tax-tax
    
        money -= 20000
    
    
    
        l9=money*0.45
    
        tax=l1+l2+l3+l4+l5+l6+l7+l8+l9
    
        print("you are in level 9,tax =%.2f, you own money=%.2f"%(tax,(before_tax-tax)))
    
        return before_tax-tax
    
    


一、什么是五险一金？

“五险一金”讲的是五种保险,包括养老保险(retirement fund)、医疗保险(medical fund)、
失业保险(unemployment fund)、工伤保险、生育保险和住房公积金(housing fund)。
其中养老保险、医疗保险和失业保险，这三种险是由企业和个人共同缴纳的保费，工伤保险和生育
保险完全是由企业承担的。个人不需要缴纳。这里要注意的是“五险”是法定的，而“一金”不是法定的。
“五险一金”的缴费比例：
医疗保险：其中单位部分按10%计缴，职工个人部分按2%计缴。
养老保险：基数为上年度平均工资，缴费比例为20%，其中8%记入个人账户，个人比例为8%。
失业保险：其中单位部分按2%计缴，职工个人部分按1%计缴。
注：目前北京养老保险缴费比例：单位20％(其中17％划入统筹基金，3％划入个人帐户)，
个人8％（全部划入个人帐户）；医疗保险缴费比例：单位10％，个人2％+3元；失业保险缴费比例：
单位1.5％，个人0.5％；工伤保险根据单位被划分的行业范围来确定它的工伤费率；生育保险缴费比例：
单位0.8％，个人不交钱。
职工缴费基数按照本人上一年月平均工资计算，缴费基数上限统一按上年本市职工月平均工资的300％确定，
养老、失业、工伤保险缴费基数下限统一按上年本市最低工资确定，生育保险缴费基数下限和外地农民工
参加工伤保险缴费基数下限按上年本市职工月平均工资的60％确定。（最低工资标准不包含劳动者个人应
缴纳的各项社会保险费和住房公积金；劳动者在中班、夜班、高温、低温、井下、有毒有害等特殊工作环境、
条件下的津贴；劳动者应得的加班、加点工资。为保障低收入群体的基本生活，北京一般是每年上浮一次
最低工资。）

二、基本公式：

实付工资 = 税前工资-（基本养老保险＋医疗保险＋失业保险＋住房公积金）-个人所得税

缴费工资基数：上一年度的月平均工资(第一年工作的是当年月平均工资)，

最低限额： 目前，北京市职工最低工资标准为每月730元，小时最低工资标准为4.36元。（2008 有望到800）

最高限额：最高不能超过本市上年职工月平均工资的3倍 (2007年北京这个上限为3322×3=9966元)

三、各项计算方法：（税前工资7000元为例）

1.基本养老保险

个人缴纳：缴费工资基数×8%

最高限额：9966*8%=797

企业缴纳：缴费工资基数×20%

2.医疗保险

(1) 基本医疗保险：

个人缴纳：缴费工资基数 ×2%

企业缴纳：缴费工资基数×9%

(2) 大额医疗费用互助资金：

个人缴纳：3元

企业缴纳：缴费工资基数×1%

3.失业保险

个人缴纳：缴费工资基数×0.5% 企业缴纳：缴费工资基数×1.5%

4.工伤保险

企业缴纳：缴费工资基数×0.4%(因行业不同0.2%-3%企业缴费,个人不负担,IT业0.4%)

5.住房公积金

个人缴纳：缴费工资基数×12% （从2008年7月1日起）

最高限额从2008年7月1日起调整为9966*0.12=1196

企业缴纳：缴费工资基数×12%

最高限额从2008年7月1日起调整为1196

6.个人所得税

基数从2008年3月1日起调整为2000元

个人所得税计算公式：

1不超过500元的部分，税率5%，速算扣除数为0； 2超过500元至2000元的部分，税率10%，速算扣除数为25 3超过2000元至5000元的部分，税率15 %，速算扣除数为175 4超过5000元至20000元的部分，税率20 %，速算扣除数为625 5超过20000元至40000元的部分，税率25%，速算扣除数为3625

6超过40000元至60000元的部分，税率30%，速算扣除数为8625 7超过60000元至80000元的部分，税率35%，速算扣除数为14625 8超过80000元至100000元的部分，税率40%，速算扣除数为21625 9超过100000元的部分，税率45%，速算扣除数为29625 个人每月收入减去三险一金，减去起征点（2000），剩下的部分套用上面的公式。

年终奖扣税：

年终奖金单独作为一个月的工资，计算交纳所得税。 本人年终奖金总额÷12，根据商数去查找适用的税率和速算扣除数，然后按下列公式计算： 奖金总额×适用的税率－速算扣除数

附：《中华人民共和国个人所得税法》
