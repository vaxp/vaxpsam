// lib/data/forensics_data.dart

import 'package:vaxpsam/domain/forensics_tool.dart';

class ForensicsData {
  // قائمة الحزم الكاملة لـ APT لتسهيل وظيفة "تثبيت الكل"
  static const List<String> kAllToolPackages = [
    // --- Your Original Packages (12) ---
    'sleuthkit',
    'foremost',
    'testdisk', // يشمل PhotoRec
    'autopsy',
    'coreutils', // يشمل Dd
    'chkrootkit',
    'rkhunter',
    'libimage-exiftool-perl', // (Package name for Exiftool)
    'scalpel',
    'hashdeep',
    'plaso',
    'readstat',

    // --- New Packages Added (21) ---
    'gpart',
    'parted',
    'gddrescue', // (Specific tool for rescuing data, different from coreutils 'dd')
    'magicrescue',
    'volatility3',
    'volatility',
    'memdump',
    'binwalk',
    'hexedit',
    'ghex',
    'bless',
    'read-edb-tools',
    'steghide',
    'stegsnow',
    'outguess',
    'chntpw',
    'reglookup',
    'afflib-tools',
    'ewf-tools',
    'dc3dd',
    'guymager',
  ];

  static const List<ForensicsTool> kForensicsTools = [
    // --- Your Original Tools (13) ---
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
      description: 'Disk imaging tools (basic `dd` command)',
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

    // --- New Tools Added (21) ---
    ForensicsTool(
      name: 'GPart',
      package: 'gpart',
      description: 'Tool to guess PC-type hard disk partitions',
    ),
    ForensicsTool(
      name: 'Parted',
      package: 'parted',
      description: 'Utility for creating and manipulating partition tables',
    ),
    ForensicsTool(
      name: 'GNU ddrescue',
      package: 'gddrescue',
      description: 'Data recovery tool that copies data from failing drives (bad sectors)',
    ),
    ForensicsTool(
      name: 'Magic Rescue',
      package: 'magicrescue',
      description: 'Recovers files by looking for "magic bytes"',
    ),
    ForensicsTool(
      name: 'Volatility 3',
      package: 'volatility3',
      description: 'The standard framework for memory dump analysis (RAM forensics)',
    ),
    ForensicsTool(
      name: 'Volatility (Legacy)',
      package: 'volatility',
      description: 'The legacy (Python 2) version of the Volatility framework',
    ),
    ForensicsTool(
      name: 'MemDump',
      package: 'memdump',
      description: 'Simple utility to dump the memory contents of a process',
    ),
    ForensicsTool(
      name: 'Binwalk',
      package: 'binwalk',
      description: 'Tool for analyzing and extracting firmware images and binaries',
    ),
    ForensicsTool(
      name: 'HexEdit',
      package: 'hexedit',
      description: 'Simple terminal-based hexadecimal file editor',
    ),
    ForensicsTool(
      name: 'GHex',
      package: 'ghex',
      description: 'Simple GNOME (GUI) hexadecimal editor',
    ),
    ForensicsTool(
      name: 'Bless Hex Editor',
      package: 'bless',
      description: 'Advanced graphical (GUI) hexadecimal editor',
    ),
    ForensicsTool(
      name: 'EDB Tools',
      package: 'read-edb-tools',
      description: 'Utilities to read Exchange Server Database (.edb) files',
    ),
    ForensicsTool(
      name: 'Steghide',
      package: 'steghide',
      description: 'Hides and extracts data in image/audio files',
    ),
    ForensicsTool(
      name: 'StegSnow',
      package: 'stegsnow',
      description: 'Hides data in whitespace of text files',
    ),
    ForensicsTool(
      name: 'OutGuess',
      package: 'outguess',
      description: 'A universal steganographic tool',
    ),
    ForensicsTool(
      name: 'chntpw',
      package: 'chntpw',
      description: 'Utility to reset passwords in Windows SAM database',
    ),
    ForensicsTool(
      name: 'RegLookup',
      package: 'reglookup',
      description: 'Command-line tool for reading Windows NT Registry files',
    ),
    ForensicsTool(
      name: 'AFF Tools',
      package: 'afflib-tools',
      description: 'Tools for Advanced Forensics Format (AFF) images',
    ),
    ForensicsTool(
      name: 'EWF Tools',
      package: 'ewf-tools',
      description: 'Tools for Expert Witness Format (EWF / EnCase) images',
    ),
    ForensicsTool(
      name: 'dc3dd',
      package: 'dc3dd',
      description: 'Forensic-enhanced version of `dd` with hashing',
    ),
    ForensicsTool(
      name: 'Guymager',
      package: 'guymager',
      description: 'GUI-based forensic imager for media acquisition',
    ),
  ];
}