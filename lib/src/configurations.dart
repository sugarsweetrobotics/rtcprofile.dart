


library rtcprofile.configurations;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'namespaces.dart';



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