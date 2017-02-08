---
author: abloz
comments: true
date: 2010-03-18 06:37:35+00:00
layout: post
link: http://abloz.com/index.php/2010/03/18/2009-personal-income-tax-and-social-security-calculations/
slug: 2009-personal-income-tax-and-social-security-calculations
title: 2009年的个人所得税和社保计算
wordpress_id: 1167
categories:
- 技术
tags:
- python
---

此前写的2008年的python计算程序，略作修改，以后优化。

    
    
    #!/usr/bin/env python
    #coding:utf8
    # author: zhouhh
    # email: ablozhou@gmail.com
    # date: 2008.6.17
    # update: 2010.3.18
    # money.py
    housing_fun_notes2009 =
    '''
    北京住房公积金管理委员会
    关于2009住房公积金年度住房公积金缴存有关问题的通知
    京房公积金管委会〔2009〕2号
    北京住房公积金管理中心、各住房公积金缴存单位：
        根据《住房公积金管理条例》，经北京住房公积金管理委员会第八次全体会议审议通过，市政府批准，现就北京2009住房公积金年度住房公积金缴存有关问题通知如下：
    
        一、住房公积金缴存比例
        2009住房公积金年度（2009年7月1日至2010年6月30日）住房公积金缴存比例为12%。
    
        二、住房公积金缴存额上限
        2009住房公积金年度的缴存额上限按照2008年北京市职工月均工资的300%，分别乘以单位和职工住房公积金缴存比例确定。按照北京市统计局公布的数据，2009住房公积金年度职工住房公积金月缴存额上限是：3726×300%×12%×2＝2682元（四舍五入）。原则上不允许住房公积金缴存额突破缴存额上限。
    
        三、北京住房公积金管理委员会授权北京住房公积金管理中心审批单位住房公积金缓缴、降低缴存比例申请，并报北京住房公积金管理委员会备案。
    
                                                  北京住房公积金管理委员会
                                                     二○○九年四月二日
    
    '''
    notes2009 =
    '''
    关于调整本市部分社会保险缴费问题的通知
    发布日期：2009年03月03日
    京劳社保发[2008]237号
    各区（县）劳动和社会保障局、各参保单位：
    按照国家及市政府有关规定，经批准，现就调整本市部分社会保险缴费有关问题通知如下：
        一、用人单位缴纳失业保险费的缴费费率由1.5％调整为1％;个人缴纳失业保险费的缴费费率由0.5％调整为0.2％。
        二、用人单位缴纳工伤保险的，按新的浮动档次和缴费费率执行（具体浮动档次和缴费费率附后）。
        三、用人单位按2％的缴费费率按月为农民工缴纳基本医疗保险的，缴费费率由2%调整为1％，其中0.9％划入基本医疗保险统筹基金，0.1％划入大额医疗互助资金。
        四、以上缴费费率的调整均自2009年1月1日起执行。
        五、2009年缴费年度（2009年4月1日至2010年3月31日），本市基本养老保险缴费下限过渡比例暂不调整，具体标准仍为上一年度（2008年度）本市职工月平均工资的40％，自2009年4月1日起执行。
        六、基本医疗保险的缴费周期调整，具体缴费办法和调整时间另行规定。
    附件：《工伤保险费率调整方案》
    北京市劳动和社会保障局
    二○○八年十二月三十一日
    附件：
    工伤保险费率调整方案
    一、一类行业
    1.现行费率为0.2％、0.3％的用人单位不调整。
    2.现行费率为0.5％的用人单位，2007、2008年度无费用支出的，费率下调为0.3;有费用支出，但支出/收入小于0.8（含0.8）的，费率下调为0.4％。
    3.现行费率为0.4％的用人单位，费率下调为0.3％。
    二、二类行业
    1.现行费率为0.8％的用人单位，2007、2008年度无费用支出的，费率下调为0.5％。
    2.现行费率为1.0％的用人单位，2007、2008年度无费用支出的，费率下调为0.8％。
    3.现行费率为1.2％的用人单位，2007、2008年度无费用支出的，费率下调为1.0％。
    4.现行费率为1.5％的用人单位，2007、2008年度无费用支出的，费率下调为1.2％。
    =======================
    北京市基本医疗保险规定：
    http://www.bjld.gov.cn/LDJAPP/search/fgdetail.jsp?no=237
     第十条  职工按本人上一年月平均工资的２％缴纳基本医疗保险费。
     职工本人上一年月平均工资低于上一年本市职工月平均工资60％的，以上一年本市职工月平均工资的６０％为缴费工资基数，缴纳基本医疗保险费。
        职工本人上一年月平均工资高于上一年本市职工月平均工资300％以上的部分，不作为缴费工资基数，不缴纳基本医疗保险费。
        无法确定职工本人上一年月平均工资的，以上一年本市职工月平均工资为缴费工资基数，缴纳基本医疗保险费。
     第十二条  用人单位按全部职工缴费工资基数之和的９％缴纳基本医疗保险费
    
     第二十一条  用人单位缴纳的基本医疗保险费的一部分按照下列标准划入个人帐户：
        （一）不满３５周岁的职工按本人月缴费工资基数的０.８％划入个人帐户；
        （二）３５周岁以上不满４５周岁的职工按本人月缴费工资基数的１％划入个人帐户；
        （三）４５周岁以上的职工按本人月缴费工资基数的２％划入个人帐户；
        （四）不满７０周岁的退休人员按上一年本市职工月平均工资的４.３％划入个人帐户；
        （五）７０周岁以上的退休人员按上一年本市职工月平均工资的４.８％划入个人帐户。
            第三十二条  基本医疗保险统筹基金支付的起付标准按上一年本市职工平均工资的１０％左右确定。个人在一个年度内第二次以及以后住院发生的医疗费用，基本医疗保险统筹基金支付的起付标准按上一年本市职工平均工资的５％左右确定。
        第三十三条  基本医疗保险统筹基金在一个年度内支付职工和退休人员的医疗费用累计最高支付限额按上一年本市职工平均工资的４倍左右确定。
       第三十八条  大额医疗费用互助资金由用人单位和个人共同缴纳。用人单位按全部职工缴费工资基数之和的１％缴纳，职工和退休人员个人按每月３元缴纳。大额医疗费用互助资金在每月缴纳基本医疗保险费时一并缴纳。
     ==============
    
    关于统一2009年度各项社会保险缴费工资基数和缴费金额的通知
    京社保发[2009]24号
    各区（县）社会保险基金管理中心、市经济技术开发区社会保险基金管理中心，各社会保险代办机构，各参保单位：
    根据北京市社会保险的相关规定、市劳动和社会保障局下发的《关于调整本市部分社会保险缴费问题的通知》（京劳社保发〔2008〕237号）和市统计局公布的2008年北京市职工年平均工资（44715元），现就统一2009缴费年度各项社会保险缴费工资基数和缴费金额的有关问题通知如下：
    一、凡以本市上一年职工月平均工资作为缴费基数的，其缴费工资基数为3726元。
    二、凡是上一年职工月平均工资收入超过本市上一年职工月平均工资300％的，其缴费工资基数为11178元。
    三、凡以本市上一年职工月平均工资的70％作为缴费基数的，其缴费工资基数为2608元。我要社保网
    四、凡以本市上一年职工月平均工资的60％作为缴费基数的，其缴费工资基数为2236元。我要社保网
    五、凡以本市上一年职工月平均工资的40％作为缴费基数的，其缴费工资基数为1490元。
    六、本市和外埠农民工按上年度本市职工最低工资标准缴纳养老保险、失业保险费的，其缴费工资基数为800元。
    七、各区（县）社会保险基金管理中心、市经济技术开发区社会保险基金管理中心、社会保险代办机构应根据参保单位申报的职工2008年月平均工资收入，核定参保单位与职工2009年度实际缴费工资基数。
    八、个人委托存档的灵活就业人员缴纳基本养老保险、失业保险和基本医疗保险月缴费金额：
    （一）基本养老保险、失业保险
    1.以本市上一年职工月平均工资为缴费基数的，月缴纳基本养老保险费745.2元、失业保险费44.71元。
    2.以本市上一年职工月平均工资的60％作为缴费基数的，月缴纳基本养老保险费447.2元、失业保险费26.83元。
    3.以本市上一年职工月平均工资的40％作为缴费基数的，月缴纳基本养老保险298元、失业保险费17.88元。
    （二）医疗保险
    1.不享受医疗保险补贴人员：
    个人月缴费为182.56元，其中基本统筹169.52元、大额互助13.04元。
    2.享受医疗保险补贴人员：
    个人月缴费为26.08元，其中基本统筹13.04元、大额互助13.04元。
                                 二○○九年三月二十五日
    '''
    def money(all_salary,has_welfare,has_housing_fund):
        money = all_salary
       #bj_average_salary=3322;#in 2008 using average salary of year 2007
        bj_average_salary=3726;#in 2009 using average salary of year 2008
        min = 1490 #bj_average_salary*0.4
        max = bj_average_salary*3
        welfare_fund = all_salary
        if all_salary > max:
            welfare_fund = max
        if all_salary < min:
            welfare_fund = min
        print("total money=%.2f"%all_salary)
        medical_fund=welfare_fund*0.02+3
        retire_fund=welfare_fund*0.08
        #unemploy_fund =welfare_fund*0.005 #2008
        unemploy_fund =welfare_fund*0.002  #2009
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
    





