
library rtcprofile.languages;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'namespaces.dart';

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