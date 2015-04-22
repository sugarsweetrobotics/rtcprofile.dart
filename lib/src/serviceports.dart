


library rtcprofile.serviceports;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'namespaces.dart';


class ServicePorts {
  String name;
  String position;
  ServicePortsDocumentation documentation;
  List<ServiceInterface> serviceInterfaces;
  ServicePorts() {
    documentation = new ServicePortsDocumentation();
    serviceInterfaces = new List<ServiceInterface>();
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    documentation = new ServicePortsDocumentation();
    serviceInterfaces.clear();
    
    name = elem.getAttribute('name', namespace: ns_rtc);
    position = elem.getAttribute('position', namespace : ns_rtcExt);
    
    elem.findAllElements('ServiceInterface', namespace : ns_rtc).forEach((e) {
      serviceInterfaces.add(new ServiceInterface()
        ..loadFromXmlElement(e));
    });
    
    
    elem.findAllElements('Doc', namespace : ns_rtcDoc).forEach((e) {
      documentation.loadFromXmlElement(e);
    });
  }
  
  static ServicePorts load(xml.XmlElement elem) {
    return new ServicePorts()
    ..loadFromXmlElement(elem);
  }
  
  void buildXml(xml.XmlBuilder builder ) {
    builder.element('ServicePorts', namespace : ns_rtc,
      attributes : {
        'xsi:type' : 'rtcExt:serviceport_ext',
        'rtcExt:position' : position,
        'rtc:name' : name },
      nest : () {
        serviceInterfaces.forEach((i) {
          i.buildXml(builder);
        });
        documentation.buildXml(builder);
      });
  }
}
  
class ServicePortsDocumentation {
  String description;
  String ifdescription;
   
  ServicePortsDocumentation() {}
   
  void loadFromXmlElement(xml.XmlElement elem) {
    description = elem.getAttribute('description', namespace: ns_rtcDoc);
    ifdescription = elem.getAttribute('ifdescription', namespace : ns_rtcDoc);
  }
   
  void buildXml(xml.XmlBuilder builder ) {
    builder.element('Doc', namespace : ns_rtcDoc,
      attributes : {
        'rtcDoc:description' : description,
        'rtcDoc:ifdescription' : ifdescription
      });
  }
}


class ServiceInterface {

  String variableName;
  String path;
  String type;
  String idlFile;
  String instanceName;
  String direction;
  String name;
  
  ServiceInterfaceDocumentation documentation;
  ServiceInterface() {
    documentation = new ServiceInterfaceDocumentation();
  }

  void loadFromXmlElement(xml.XmlElement elem) {
    documentation = new ServiceInterfaceDocumentation();
    
    name = elem.getAttribute('name', namespace: ns_rtc);
    variableName = elem.getAttribute('variableName', namespace: ns_rtcExt);
    type = elem.getAttribute('type', namespace: ns_rtc);
    instanceName = elem.getAttribute('instanceName', namespace: ns_rtc);
    direction = elem.getAttribute('direction', namespace: ns_rtc);
    idlFile = elem.getAttribute('idlFile', namespace: ns_rtc);
    path = elem.getAttribute('path', namespace: ns_rtc);
    
    elem.findAllElements('Doc', namespace : ns_rtcDoc).forEach((e) {
       documentation.loadFromXmlElement(e);
     });
  }
   
  void buildXml(xml.XmlBuilder builder) {
    builder.element('ServiceInterface', namespace : ns_rtc,
      attributes : {
        'xsi:type' : 'rtcExt:serviceinterface_ext',
        'rtc:name' : name,
        'rtcExt:variableName' : variableName,
        'rtc:type' : type,
        'rtc:instanceName' : instanceName,
        'rtc:direction' : direction,
        'rtc:idlFile' : idlFile,
        'rtc:path' : path
      },
      nest : () {
        documentation.buildXml(builder);
      });
  }
}

class ServiceInterfaceDocumentation {

  String docPostCondition = "";
  String docPreCondition = "";
  String docException = "";
  String docReturn = "";
  String docArgument = "";
  String description = "";

  ServiceInterfaceDocumentation() {}
  
  void loadFromXmlElement(xml.XmlElement elem) {
    description = elem.getAttribute('description', namespace: ns_rtcDoc);
    docPostCondition = elem.getAttribute('docPostCondition', namespace : ns_rtcDoc);
    docPreCondition = elem.getAttribute('docPreCondition', namespace : ns_rtcDoc);
    docException = elem.getAttribute('docException', namespace : ns_rtcDoc);
    docReturn = elem.getAttribute('docReturn', namespace : ns_rtcDoc);
    docArgument = elem.getAttribute('docArgument', namespace : ns_rtcDoc);
    
  }
   
  void buildXml(xml.XmlBuilder builder ) {
    builder.element('Doc', namespace : ns_rtcDoc,
      attributes : {
        'rtcDoc:description' : description,
        'rtcDoc:docPreCondition' : docPreCondition,
        'rtcDoc:docPostCondition' : docPostCondition,
        'rtcDoc:docException' : docException,
        'rtcDoc:docReturn' : docReturn,
        'rtcDoc:docArgument' : docArgument
      });
  }

}
