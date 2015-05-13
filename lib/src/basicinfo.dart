
library rtcprofile.basicinfo;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'namespaces.dart';


/// Basic Info 
class BasicInfo {
  String name;
  String description;
  String version;
  String vendor;
  String category;
  String componentType;
  String activityType;
  String componentKind;
  String maxInstances;
  String executionType;
  String executionRate;
  String abstract;
  String saveProject;
  String updateDate;
  String creationDate;
  
  BasicInfoDocumentation documentation;
  List<VersionUpLog> versionUpLogs;
  
  BasicInfo() {
    documentation = new BasicInfoDocumentation();
    versionUpLogs = new List<VersionUpLog>();
    name = "";
    description = "";
    version = "";
    vendor = "";
    category = "";
    componentType = "";
    activityType = "";
    componentKind = "";
    maxInstances = "";
    executionType = "";
    executionRate = "";
    abstract = "";
    saveProject = "";
    updateDate = "";
    creationDate = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    documentation = new BasicInfoDocumentation();
    versionUpLogs = new List<VersionUpLog>();
    name = "";
    description = "";
    version = "";
    vendor = "";
    category = "";
    componentType = "";
    activityType = "";
    componentKind = "";
    maxInstances = "";
    executionType = "";
    executionRate = "";
    abstract = "";
    saveProject = "";
    updateDate = "";
    creationDate = "";

    name = elem.getAttribute('name', namespace: ns_rtc);
    description = elem.getAttribute('description', namespace: ns_rtc);
    version = elem.getAttribute('version', namespace: ns_rtc);
    vendor = elem.getAttribute('vendor', namespace: ns_rtc);
    category = elem.getAttribute('category', namespace: ns_rtc);

    componentType = elem.getAttribute('componentType', namespace: ns_rtc);
    componentKind = elem.getAttribute('componentKind', namespace: ns_rtc);
    activityType = elem.getAttribute('activityType', namespace: ns_rtc);
    
    maxInstances = elem.getAttribute('maxInstances', namespace: ns_rtc);
    executionType = elem.getAttribute('executionType', namespace: ns_rtc);
    executionRate = elem.getAttribute('executionRate', namespace: ns_rtc);
    
    saveProject = elem.getAttribute('saveProject', namespace: ns_rtcExt);
    updateDate = elem.getAttribute('updateDate', namespace: ns_rtc);
    creationDate = elem.getAttribute('creationDate', namespace: ns_rtc);
    
    elem.findAllElements('Doc', namespace : ns_rtcDoc).forEach((elem) {
      documentation.loadFromXmlElement(elem);
    });
    elem.findAllElements('VersionUpLogs', namespace : ns_rtcExt).forEach((elem) {
      versionUpLogs.add(new VersionUpLog()
      ..loadFromXmlElement(elem)
      );
    });
  }
  
  static BasicInfo load(xml.XmlElement elem) {
    return new BasicInfo()..loadFromXmlElement(elem);
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element('BasicInfo', namespace: ns_rtc,
           attributes: {
             'xsi:type' : 'rtcExt:basic_info_ext',
             'rtcExt:saveProject' : saveProject,
             'rtc:updateDate' : updateDate,
             'rtc:creationDate' : creationDate,
             'rtc:version' : version,
             'rtc:vendor' : vendor,
             'rtc:maxInstances' : maxInstances,
             'rtc:executionType' : executionType,
             'rtc:executionRate' : executionRate,
             'rtc:description' : description,
             'rtc:category' : category,
             'rtc:componentKind' : componentKind,
             'rtc:activityType' : activityType,
             'rtc:componentType' : componentType,
             'rtc:abstract' : abstract,
             'rtc:name' : name},
             nest : () {
               documentation.buildXml(builder);
               versionUpLogs.forEach((log) {
                 log.buildXml(builder);
               });
             }
       );
  }
}



class BasicInfoDocumentation {
  
  String description;
  String inout;
  String algorithm;
  String creator;
  String license;
  String reference;  
  BasicInfoDocumentation() {
    reference = "";
    license = "";
    creator = "";
    algorithm = "";
    inout = "";
    description = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    reference = "";
    license = "";
    creator = "";
    algorithm = "";
    inout = "";
    description = "";
    
    reference = elem.getAttribute('reference', namespace : ns_rtcDoc);
    license   = elem.getAttribute('license', namespace: ns_rtcDoc);
    creator   = elem.getAttribute('creator', namespace: ns_rtcDoc);
    algorithm   = elem.getAttribute('algorithm', namespace: ns_rtcDoc);
    inout   = elem.getAttribute('inout', namespace: ns_rtcDoc);
    description   = elem.getAttribute('description', namespace: ns_rtcDoc);
  }
  
  static BasicInfoDocumentation load(xml.XmlElement elem) {
    return new BasicInfoDocumentation()
    ..loadFromXmlElement(elem);
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element('Doc', namespace : ns_rtcDoc,
      attributes : {
        'rtcDoc:reference' : reference,
        'rtcDoc:license' : license,
        'rtcDoc:creator' : creator,
        'rtcDoc:algorithm' : algorithm,
        'rtcDoc:inout' : inout,
        'rtcDoc:description' : description
      });
  }
}


class VersionUpLog {
  String text = "";
  VersionUpLog() {}
  
  void loadFromXmlElement(xml.XmlElement elem) {
    text = "";
    elem.children.forEach((node) {
      text = node.text;
    });
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element('VersionUpLogs', namespace : ns_rtcExt,
      nest : () {
        builder.text(text);
      }
      );   
  }
}
