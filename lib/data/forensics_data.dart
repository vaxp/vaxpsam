// lib/data/forensics_data.dart

import 'package:vaxpsam/domain/forensics_tool.dart';

class ForensicsData {
  // قائمة الحزم الكاملة لـ APT لتسهيل وظيفة "تثبيت الكل"
  static const List<String> kAllToolPackages = [
    'sleuthkit',
    'foremost',
    'testdisk', // يشمل PhotoRec
    'autopsy',
    'coreutils', // يشمل Dd/ddrescue
    'chkrootkit',
    'rkhunter',
    'libimage-exiftool-perl',
    'scalpel',
    'hashdeep',
    'plaso',
    'readstat',
  ];

  static const List<ForensicsTool> kForensicsTools = [
    ForensicsTool(
      name: 'The Sleuth Kit (TSK)',
      package: 'sleuthkit',
      description: 'Toolkit for forensic investigation of file systems',
    ),
    ForensicsTool(
      name: 'Foremost',
      package: 'foremost',
      description: 'File recovery tool using signature analysis (Carving)',
    ),
    ForensicsTool(
      name: 'TestDisk',
      package: 'testdisk',
      description: 'Tool for recovering lost hard drive partitions',
    ),
    ForensicsTool(
      name: 'PhotoRec',
      package: 'testdisk',
      description: 'File recovery tool (included with TestDisk)',
    ),
    ForensicsTool(
      name: 'Autopsy',
      package: 'autopsy',
      description:
          'Graphical interface to Sleuth Kit for comprehensive analysis',
    ),
    ForensicsTool(
      name: 'Dd/ddrescue',
      package: 'coreutils',
      description: 'Disk imaging tools',
    ),
    ForensicsTool(
      name: 'Chkrootkit',
      package: 'chkrootkit',
      description: 'System scanning tool for rootkits',
    ),
    ForensicsTool(
      name: 'Rkhunter',
      package: 'rkhunter',
      description: 'Tool for detecting rootkits and malware',
    ),
    ForensicsTool(
      name: 'Exiftool',
      package: 'libimage-exiftool-perl',
      description: 'Reads, writes, and modifies metadata for images and files',
    ),
    ForensicsTool(
      name: 'Scalpel',
      package: 'scalpel',
      description: 'Fast file recovery tool based on Carving',
    ),
    ForensicsTool(
      name: 'Hashdeep',
      package: 'hashdeep',
      description:
          'Hash calculator for several types of hashes (useful for verifying evidence)',
    ),
    ForensicsTool(
      name: 'Plaso',
      package: 'plaso',
      description: 'Tool for timeline analysis',
    ),
    ForensicsTool(
      name: 'Readstat',
      package: 'readstat',
      description: 'Tool for reading statistical files (data analysis)',
    ),
  ];
}
