library rtcprofile.base;

import 'package:xml/xml.dart' as xml;
import 'dart:core';

var ns_rtc = 'http://www.openrtp.org/namespaces/rtc';
var ns_rtcDoc = 'http://www.openrtp.org/namespaces/rtc_doc';
var ns_xsi = "http://www.w3.org/2001/XMLSchema-instance";
var ns_rtcExt = "http://www.openrtp.org/namespaces/rtc_ext";

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

class Actions {
  Action onInitializeAction;
  Action onFinalizeAction;
  Action onStartupAction;
  Action onShutdownAction;
  Action onActivatedAction;
  Action onDeactivatedAction;
  Action onErrorAction;
  Action onAbortingAction;
  Action onResetAction;
  Action onExecuteAction;
  Action onStateUpdateAction;
  Action onRateChangedAction;
  Action onActionAction;
  Action onModeChangedAction;
  
  Actions() {
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    onInitializeAction = new Action();
    onFinalizeAction = new Action();
    onStartupAction = new Action();
    onShutdownAction = new Action();
    onActivatedAction = new Action();
    onDeactivatedAction = new Action();
    onErrorAction = new Action();
    onAbortingAction = new Action();
    onResetAction = new Action();
    onExecuteAction = new Action();
    onStateUpdateAction = new Action();
    onRateChangedAction = new Action();
    onActionAction = new Action();
    onModeChangedAction = new Action();

    elem.children.forEach((node) {
      if(node is xml.XmlElement) {
       if (node.name.toString() == 'rtc:OnInitialize') {
         onInitializeAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnFinalize') {
         onFinalizeAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnStartup') {
         onStartupAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnShutdown') {
         onShutdownAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnActivated') {
         onActivatedAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnDeactivated') {
         onDeactivatedAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnExecute') {
         onExecuteAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnAborting') {
         onAbortingAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnError') {
         onErrorAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnReset') {
         onResetAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnStateUpdate') {
         onStateUpdateAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnModeChanged') {
         onModeChangedAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnAction') {
         onActionAction.loadFromXmlElement(node);
       }
       else if (node.name.toString() == 'rtc:OnRateChanged') {
         onRateChangedAction.loadFromXmlElement(node);
       }
      
      }
    });
    
    
  }
  
  static Actions load(xml.XmlElement elem) {
    return new Actions()
    ..loadFromXmlElement(elem);
  }
  

  void buildXml(xml.XmlBuilder builder) {
    builder.element('Actions', namespace: ns_rtc,
        nest : () {
          onInitializeAction.buildXml(builder);
          onFinalizeAction.buildXml(builder);
          onStartupAction.buildXml(builder);
          onShutdownAction.buildXml(builder);
          onActivatedAction.buildXml(builder);
          onDeactivatedAction.buildXml(builder);
          onAbortingAction.buildXml(builder);
          onErrorAction.buildXml(builder);
          onResetAction.buildXml(builder);
          onExecuteAction.buildXml(builder);
          onStateUpdateAction.buildXml(builder);
          onRateChangedAction.buildXml(builder);
          onActionAction.buildXml(builder);
          onModeChangedAction.buildXml(builder);
        });
  }
}

class Action {
  
  bool implemented = false;
  ActionDocumentation documentation;
  xml.XmlName name;
  
  Action() {
    documentation = new ActionDocumentation();
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    name = elem.name;
    documentation = new ActionDocumentation();
    implemented = elem.getAttribute('implemented', namespace : ns_rtc) == 'true' ? true : false;
    elem.findAllElements('Doc', namespace : ns_rtcDoc).forEach((elem) {
      documentation.loadFromXmlElement(elem);
    });
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element(name.local, namespace : name.namespaceUri,
        attributes: {
          'xsi:type' : 'rtcDoc:action_status_doc',
          'rtc:implemented' : implemented.toString()},
          nest : () {
            documentation.buildXml(builder);
          });
  }
}


class ActionDocumentation {
  String postCondition;
  String preCondition;
  String description;
  ActionDocumentation() {
    postCondition = "";
    preCondition = "";
    description = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    postCondition = "";
    preCondition = "";
    description = "";
    
    postCondition = elem.getAttribute('postCondition', namespace : ns_rtcDoc);
    preCondition = elem.getAttribute('preCondition', namespace : ns_rtcDoc);
    description = elem.getAttribute('description', namespace : ns_rtcDoc);
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element('Doc', namespace : ns_rtcDoc,
        attributes: {
            'rtcDoc:preCondition' : preCondition,
            'rtcDoc:postCondition' : postCondition,
            'rtcDoc:description' : description,
        });
  }   
}


class ConfigurationSet {
  
  List<Configuration> configurations;
  ConfigurationSet() {
    configurations = new List<Configuration>();
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    configurations = new List<Configuration>();
    elem.children.forEach((node) {
      if(node is xml.XmlElement) {
        configurations.add(new Configuration()
        ..loadFromXmlElement(node));
      }
    });
  }
  
  static ConfigurationSet load(xml.XmlElement elem) {
    return new ConfigurationSet() 
      ..loadFromXmlElement(elem);
  }
  

  void buildXml(xml.XmlBuilder builder) {

    builder.element('ConfigurationSet', namespace : ns_rtc,
        nest : () {
          configurations.forEach((conf) {
            conf.buildXml(builder);
          });
        });
  }
}


class Configuration {
  String name;
  String type;
  String variableName;
  String defaultValue;
  String unit;
  
  String widget = "";
  String step = "";

  ConfigurationDocumentation documentation;
  
  Property _property;
  
  Constraint constraint;
  
  String toString() {
    return name + ' : ' + type;  
  }
  
  
  Configuration() {
    name = "";
    type = "";
    variableName = "";
    defaultValue = "";
    unit = "";
    documentation = new ConfigurationDocumentation();
    _property = new Property();
    constraint = new Constraint();
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    name = elem.getAttribute('name', namespace: ns_rtc);
    type = elem.getAttribute('type', namespace: ns_rtc);
    variableName = elem.getAttribute('variableName', namespace: ns_rtcExt);
    defaultValue = elem.getAttribute('defaultValue', namespace: ns_rtc);
    unit = elem.getAttribute('unit', namespace: ns_rtc);
    documentation = new ConfigurationDocumentation();
    _property = new Property();
    constraint = new Constraint();
    
    elem.findAllElements('Doc', namespace : ns_rtcDoc).forEach((elem) {
      documentation.loadFromXmlElement(elem);
    });
    
    elem.children.forEach((node) {
      if (node is xml.XmlElement) {
        if(node.name.toString() == 'rtc:Constraint') {
           constraint.loadFromXmlElement(node);        
        }
      }
    });
    
    elem.findAllElements('Properties', namespace : ns_rtcExt).forEach((elem) {
      _property.loadFromXmlElement(elem);
      var tokens = _property.value.split('.');
      if(tokens.length > 1) {
        widget = tokens[0];
        step = tokens[1];
      }
      else {
        widget = _property.value;
        step = "";
      }
    });
    
  }
  

  void buildXml(xml.XmlBuilder builder) {
    builder.element('Configuration', namespace : ns_rtc,
      attributes: {
        'xsi:type': 'rtcExt:configuration_ext',
        'rtcExt:variableName' : variableName,
        'rtc:unit' : unit,
        'rtc:defaultValue' : defaultValue,
        'rtc:type' : type,
        'rtc:name' : name},
        nest : () {
          constraint.buildXml(builder);
          documentation.buildXml(builder);
          
          String widgetstr = widget;
          if (step.length > 0) {
            widgetstr = widgetstr + "." + step;
          }
          builder.element('Properties', namespace : ns_rtcExt,
              attributes : {
                'rtcExt:value' : widgetstr,
                'rtcExt:name' : '__widget__'
              });
        }
        );    
  }
}

class Property {
  String name;
  String value;
  
  Property() {
    name = "";
    value = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    name = elem.getAttribute('name', namespace : ns_rtcExt);
    value = elem.getAttribute('value', namespace : ns_rtcExt);
  }
}

class Constraint {
  
  String value = "";
  
  void loadConstraintListType(xml.XmlElement elem) {
    // Array Type
    value = "";
    var literals = elem.findAllElements('Literal', namespace: ns_rtc);
    for(int i = 0;i < literals.length;i++) {
      var literal = literals.elementAt(i);
      value += (literal.firstChild as xml.XmlText).text;
      if(i != literals.length-1) {
        value += ',';
      }
    }
  }

  void loadConstraintUnitType(xml.XmlElement elem) {
    value = "";
    for(xml.XmlNode node in elem.children) {
      if(node is xml.XmlElement) {
        if(node.name.toString() == 'rtc:Or') {
          value = '(';
          var literals = elem.findAllElements('Literal', namespace: ns_rtc);
          for(int i = 0;i < literals.length;i++) {
            var literal = literals.elementAt(i);
            value += (literal.firstChild as xml.XmlText).text;
            if(i != literals.length-1) {
              value += ',';
            }
          }
          value += ')';
        }
      }
    }
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    value = "";
    elem.children.forEach((node) {
      if (node is xml.XmlElement) {
        if (node.name.toString() == 'rtc:ConstraintListType') {
          loadConstraintListType(node);
          return;
        } else if (node.name.toString() == 'rtc:ConstraintUnitType') {
          loadConstraintUnitType(node);
          return;
        }
      }
    });
  }
  
  void buildXml(xml.XmlBuilder builder) {
    if(value.length > 0) {
      builder.element('Constraint', namespace : ns_rtc,
        nest : () {
          if (value.startsWith('(')) {
            // Enumerate Pattern
            _addEnumerateConstraint(builder);
          } else if(value.length > 0){
            // Array Pattern
            _addArrayConstraint(builder);
          }
        });
    }
  }
  

  void _addLiteral(xml.XmlBuilder builder, String literal) {
    builder.element('Constraint', namespace : ns_rtc,
      nest : () {
        builder.element('ConstraintUnitType', namespace : ns_rtc,
          nest : () {
            builder.element('propertyIsEqualTo', namespace : ns_rtc,
              attributes : {
                'rtc:matchCase' : 'false'
              },
              nest : () {
                builder.element('Literal', namespace : ns_rtc,
                    nest : () {
                      builder.text(literal);
                    });
              }
              );
          }
          );
      }
      );
                                
  }
  
  void _addEnumerateConstraint(xml.XmlBuilder builder) {
    builder.element('ConstraintUnitType', namespace : ns_rtc,
        nest : () {
          builder.element('Or', namespace : ns_rtc,
              nest : () {
                String constraintValue = value.substring(1, value.length-1);
                for(String v in constraintValue.split(',')) {
                  _addLiteral(builder, v);
                }
              }
              );
        }
        );
  }
    
  void _addArrayConstraint(xml.XmlBuilder builder) {
    builder.element('ConstraintListType', namespace : ns_rtc,
      nest : () {
        String constraintValue = value;
        for(String v in constraintValue.split(',')) {
          _addLiteral(builder, v);
        }

      }
      );
  }
}


class ConfigurationDocumentation {
  String description;
  String constraint;
  String unit;
  String dataRange;
  String defaultValue;
  String dataName;
  
  ConfigurationDocumentation() {
    description = "";
    constraint = "";
    unit = "";
    dataRange = "";
    defaultValue = "";
    dataName = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    description = elem.getAttribute('description', namespace: ns_rtcDoc);
    constraint  = elem.getAttribute('constraint', namespace: ns_rtcDoc);
    unit = elem.getAttribute('unit', namespace: ns_rtcDoc);
    dataRange = elem.getAttribute('range', namespace: ns_rtcDoc);
    defaultValue = elem.getAttribute('defaultValue', namespace: ns_rtcDoc);
    dataName = elem.getAttribute('dataname', namespace: ns_rtcDoc);
  }

  void buildXml(xml.XmlBuilder builder) {
    builder.element('Doc', namespace : ns_rtcDoc,
      attributes : {
       'rtcDoc:constraint' : constraint,
       'rtcDoc:range' : dataRange,
       'rtcDoc:unit' : unit,
       'rtcDoc:description' : description, 
       'rtcDoc:defaultValue' : defaultValue,
       'rtcDoc:dataname' : dataName
       });
  }
}



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


class Language {
  String kind;
  
  List<Targets> targets;
  
  Language() {
    targets = new List<Targets>();
  }
 
  void loadFromXmlElement(xml.XmlElement elem) {
    targets = new List<Targets>();
    kind = elem.getAttribute('kind', namespace: ns_rtc);
    elem.findAllElements('targets', namespace: ns_rtcExt).forEach((e) {
      targets.add(new Targets() .. loadFromXmlElement(e));
    });
  }
  
  static Language load(xml.XmlElement elem) {
    return new Language()
    ..loadFromXmlElement(elem);
  }

  void buildXml(xml.XmlBuilder builder ) {
    builder.element('Language', namespace : ns_rtc,
      attributes : {
        'xsi:type' : 'rtcExt:language_ext',
        'rtc:kind' : kind
      },
      nest : () {
        targets.forEach((t) {
          t.buildXml(builder);
        });
      });
  }
}

class Targets {
  String os = "";
  String langVersion = "";
  String other = "";
  String cpuOther = "";
  
  List<OSVersion> osVersions;
  List<CPU> cpus;
  List<Library> libraries;

  Targets() {}
  
  
  void loadFromXmlElement(xml.XmlElement elem) {
    cpuOther = elem.getAttribute('cpuOther', namespace : ns_rtcExt);
    other = elem.getAttribute('other', namespace : ns_rtcExt);
    langVersion = elem.getAttribute('langVersion', namespace : ns_rtcExt);
    os = elem.getAttribute('os', namespace: ns_rtcExt);
    
    osVersions = new List<OSVersion>();
    elem.findAllElements('osVersions', namespace : ns_rtcExt).forEach((e) {
       osVersions.add(new OSVersion() .. loadFromXmlElement(e));  
    });
    
    cpus = new List<CPU>();
    elem.findAllElements('cpus', namespace : ns_rtcExt).forEach((e) {
       cpus.add(new CPU() .. loadFromXmlElement(e));  
    });
    
    libraries = new List<Library>();
    elem.findAllElements('libraries', namespace : ns_rtcExt).forEach((e) {
      libraries.add(new Library() .. loadFromXmlElement(e));  
    });
    
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element('targets', namespace : ns_rtcExt,
      attributes : {
        'rtcExt:cpuOther' : cpuOther,
        'rtcExt:other' : other,
        'rtcExt:os' : os,
        'rtcExt:langVersion' : langVersion
      },
      nest : () {
        osVersions.forEach((o) {
          o.buildXml(builder);
        });
        cpus.forEach((c) {
          c.buildXml(builder);
        });
        libraries.forEach((l) {
          l.buildXml(builder);
        });
      });
  }
}

class OSVersion {
  String value;
  OSVersion() {
    value = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    elem.children.forEach((n) {
      value = n.text;
    });
  }

  void buildXml(xml.XmlBuilder builder) {
    builder.element('osVersion', namespace : ns_rtcExt,
        nest : () {
          builder.text(value);
        });
  }
}

class CPU {
  String value;
  CPU() {
    value = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    elem.children.forEach((n) {
      value = n.text;
    });
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element('cpu', namespace : ns_rtcExt,
      nest : () {
        builder.text(value);
      });    
  }
}

class Library {
  String name;
  String version;
  String other;
  Library() {
    name = "";
    version = "";
    other = "";
  }
  
  void loadFromXmlElement(xml.XmlElement elem) {
    name = elem.getAttribute('name', namespace: ns_rtcExt);
    version = elem.getAttribute('version', namespace: ns_rtcExt);
    other = elem.getAttribute('other', namespace: ns_rtcExt);
  }
  
  void buildXml(xml.XmlBuilder builder) {
    builder.element('libraries', namespace : ns_rtcExt,
       attributes : {
         'rtcExt:other' : other,
         'rtcExt:version' : version,
         'rtcExt:name' : name
       }
       );
  }
}

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

/// RTCProfile class 
class RTCProfile {
  BasicInfo basicInfo;
  List<DataPorts> dataPorts;
  List<ServicePorts> servicePorts;
  ConfigurationSet configurationSet;
  Actions actions;
  Language language;
  
  List<DataPorts> get dataInPorts {
    List<DataPorts> ps = new List<DataPorts>();
    dataPorts.forEach((p) {
      if(p.portType == 'DataInPort') {
        ps.add(p);
      }
    });
    return ps;
  }
  
  List<DataPorts> get dataOutPorts {
    List<DataPorts> ps = new List<DataPorts>();
    dataPorts.forEach((p) {
      if(p.portType == 'DataOutPort') {
        ps.add(p);
      }
    });
    return ps;
  }
  
  RTCProfile() {
    dataPorts = new List<DataPorts>();
    servicePorts = new List<ServicePorts>();
    configurationSet = new ConfigurationSet();
  }
  
  static RTCProfile createFromText(String text) {
    xml.XmlDocument doc = xml.parse(text);
    return createFromXmlDocument(doc);
  }
  
  /// This fuction create RTCProfile class instance from XmlDocument data;
  /// If invalid Xml is passed, null is returned;
  static RTCProfile createFromXmlDocument(xml.XmlDocument doc) {
    var rtcp = new RTCProfile();
    doc.findAllElements('BasicInfo', namespace: ns_rtc).forEach((elem) {
      rtcp.basicInfo = BasicInfo.load(elem);
    });
    
    doc.findAllElements('Actions', namespace: ns_rtc).forEach((elem) {
      rtcp.actions = Actions.load(elem);
    });
    
    doc.findAllElements('ConfigurationSet', namespace: ns_rtc).forEach((elem) {
      rtcp.configurationSet = ConfigurationSet.load(elem);
    });
    
    doc.findAllElements('DataPorts', namespace: ns_rtc).forEach((elem) {
      rtcp.dataPorts.add(DataPorts.load(elem));
    });
    
    doc.findAllElements('ServicePorts', namespace: ns_rtc).forEach((elem) {
      rtcp.servicePorts.add(ServicePorts.load(elem));
    });
    
    doc.findAllElements('Language', namespace: ns_rtc).forEach((elem) {
      rtcp.language = Language.load(elem);
    });
    return rtcp;
  }
  
  String _getId() {
    return 'RTC:${basicInfo.vendor}:${basicInfo.category}:${basicInfo.name}:${basicInfo.version}';
  }
  
  /// buildXml
  /// This function returns XmlDocument object which generated by RTCProfile.
  xml.XmlDocument buildXml() {
    xml.XmlBuilder builder = new xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8" standalone="yes"');
    
    builder.element('RtcProfile', namespace: ns_rtc,
      namespaces: {ns_rtc: 'rtc', ns_rtcDoc: 'rtcDoc', ns_rtcExt: 'rtcExt', ns_xsi: 'xsi'}, 
      attributes: {'rtc:version': '0.2', 'rtc:id': _getId()},
      nest : () {
        basicInfo.buildXml(builder);
        actions.buildXml(builder);
        if(configurationSet != null) {
           configurationSet.buildXml(builder);
        }
        dataPorts.forEach((p) {
          p.buildXml(builder);
        });

        servicePorts.forEach((p) {
          p.buildXml(builder);
        });
        
        language.buildXml(builder);
    });
    return builder.build();
  }
  
  RTCProfile clone() {
    xml.XmlDocument doc = this.buildXml();
    return RTCProfile.createFromXmlDocument(doc);
  }
}