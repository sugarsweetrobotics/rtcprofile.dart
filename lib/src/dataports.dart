


library rtcprofile.dataports;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'namespaces.dart';



class DataPorts {
  String name = "";
  String type = "";
  String unit = "";
  String subscriptionType = "";
  String dataflowType = "";
  String interfaceType = "";
  String idlFile = "";
  String variableName = "";
  String portType = "";
  
  String position = "";
  
  DataPortsDocumentation documentation;
  
  DataPorts() {
    documentation = new DataPortsDocumentation();
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    documentation = new DataPortsDocumentation();
    
    name = elem.getAttribute('name', namespace: ns_rtc);
    unit = elem.getAttribute('unit', namespace: ns_rtc);
    variableName = elem.getAttribute('variableName', namespace: ns_rtcExt);
    type = elem.getAttribute('type', namespace: ns_rtc);
    position = elem.getAttribute('position', namespace : ns_rtcExt);
    portType = elem.getAttribute('portType', namespace: ns_rtc);
    idlFile = elem.getAttribute('idlFile', namespace: ns_rtc);
    interfaceType = elem.getAttribute('interfaceType', namespace: ns_rtc);
    subscriptionType = elem.getAttribute('subscriptionType', namespace: ns_rtc);
    dataflowType = elem.getAttribute('dataflowType', namespace: ns_rtc);
    
    elem.findAllElements('Doc', namespace : ns_rtcDoc).forEach((elem) {
      documentation.loadFromXmlElement(elem);
    });
  }
  
  static DataPorts load(xml.XmlElement elem) {
    return new DataPorts()
    ..loadFromXmlElement(elem);
  }
  
  void buildXml(xml.XmlBuilder builder ) {
    builder.element('DataPorts', namespace : ns_rtc,
      attributes : {
        'xsi:type' : 'rtcExt:dataport_ext',
        'rtcExt:position' : position,
        'rtcExt:variableName' : variableName,
        'rtc:unit' : unit,
        'rtc:subscriptionType' : subscriptionType,
        'rtc:dataflowType' : dataflowType,
        'rtc:interfaceType' : interfaceType,
        'rtc:idlFile' : idlFile,
        'rtc:type' : type,
        'rtc:name' : name,
        'rtc:portType' : portType},
      nest : () {
        documentation.buildXml(builder);
      });
  }
}

/// DataPorts Documentation
class DataPortsDocumentation {
  String description = "";
  String unit = "";
  String type = "";
  String occerrence = "";
  String semantics = "";
  String operation = "";
  String number = "";
 
  DataPortsDocumentation() {}
  
  void loadFromXmlElement(xml.XmlElement elem) {
    description = elem.getAttribute('description', namespace : ns_rtcDoc);
    unit = elem.getAttribute('unit', namespace : ns_rtcDoc);
    occerrence = elem.getAttribute('occerrence', namespace : ns_rtcDoc);
    type = elem.getAttribute('type', namespace : ns_rtcDoc);
    semantics = elem.getAttribute('semantics', namespace : ns_rtcDoc);
    operation = elem.getAttribute('operation', namespace : ns_rtcDoc);
    number= elem.getAttribute('number', namespace : ns_rtcDoc);
  }
  
  void buildXml(xml.XmlBuilder builder ) {
    builder.element('Doc', namespace : ns_rtcDoc,
      attributes : {
        'rtcDoc:operation' : operation,
        'rtcDoc:occerrence' : occerrence,
        'rtcDoc:unit' : unit,
        'rtcDoc:semantics' : semantics,
        'rtcDoc:number' : number,
        'rtcDoc:type' : type,
        'rtcDoc:description' : description
      }
      );
  }
}