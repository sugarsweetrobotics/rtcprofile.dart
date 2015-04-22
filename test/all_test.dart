// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library rtcprofile.test;

import 'package:unittest/unittest.dart';
import 'package:rtcprofile/rtcprofile.dart' as rtcprofile;


String text = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?><rtc:RtcProfile rtc:version="0.2" rtc:id="RTC:ssr:Test:TestIn_java:1.0.0" xmlns:rtcExt="http://www.openrtp.org/namespaces/rtc_ext" xmlns:rtcDoc="http://www.openrtp.org/namespaces/rtc_doc" xmlns:rtc="http://www.openrtp.org/namespaces/rtc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><rtc:BasicInfo xsi:type="rtcExt:basic_info_ext" rtcExt:saveProject="TestIn_java" rtc:updateDate="2014-07-14T13:13:04+09:00" rtc:creationDate="2014-07-14T13:13:04+09:00" rtc:version="1.0.0" rtc:vendor="ss\
r" rtc:maxInstances="1" rtc:executionType="PeriodicExecutionContext" rtc:executionRate="1000.0" rtc:description="Test In Component" rtc:category="Test" rtc:componentKind="DataFlowComponent" rtc:activityType="PERIODIC" rtc:componentType="STATIC" rtc:name="TestIn_java"/>
    <rtc:Actions>
        <rtc:OnInitialize xsi:type="rtcDoc:action_status_doc" rtc:implemented="true"/>
        <rtc:OnFinalize xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnStartup xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnShutdown xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnActivated xsi:type="rtcDoc:action_status_doc" rtc:implemented="true"/>
        <rtc:OnDeactivated xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnAborting xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnError xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnReset xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnExecute xsi:type="rtcDoc:action_status_doc" rtc:implemented="true"/>
        <rtc:OnStateUpdate xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnRateChanged xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnAction xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
        <rtc:OnModeChanged xsi:type="rtcDoc:action_status_doc" rtc:implemented="false"/>
    </rtc:Actions>
    <rtc:DataPorts xsi:type="rtcExt:dataport_ext" rtcExt:position="LEFT" rtcExt:variableName="in" rtc:unit="" rtc:subscriptionType="" rtc:dataflowType="" rtc:interfaceType="" rtc:idlFile="" rtc:type="RTC::TimedLong" rtc:name="in" rtc:portType="DataInPort"/>
    <rtc:Language xsi:type="rtcExt:language_ext" rtc:kind="Java"/>
</rtc:RtcProfile>''';

main() {
  rtcprofile.RTCProfile rtcProfile = rtcprofile.RTCProfile.createFromText(text);
  
  print('BasicInfomation: ');
  print(' - name: ${rtcProfile.basicInfo.name}');
  print(' - name: ${rtcProfile.basicInfo.description}');
      
}
