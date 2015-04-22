
library rtcprofile.actions;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'namespaces.dart';

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
