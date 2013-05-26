#!/usr/bin/env python

# constantshs.py - This is a LSL2dfg.py output module for LSLForge Constants.hs Haskell output.
#
# (C) Copyright 2013 Sei Lisa.
# Sei Lisa is the author's username in the Second Life online virtual world.
#
# This file is part of LSL2 Derived Files Generator.
#
#    LSL2 Derived Files Generator is free software: you can redistribute it
#    and/or modify it under the terms of the GNU Lesser General Public License
#    as published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    LSL2 Derived Files Generator is distributed in the hope that it will be
#    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with LSL2 Derived Files Generator. If not, see
#    <http://www.gnu.org/licenses/>.
#
# Second Life is a trademark of Linden Research, Inc.


import sys
import re

def output(document, defaultdescs, databaseversion, infilename, outfilename, lang, tag):

  def UpperCamelCase_TO_UNDERSCORES(arg):
    # E.g. PermissionTrackCamera -> replaces T with _T and C with _C
    # but  HTTPMethod -> replaces M with _M resulting in HTTP_METHOD
    # It also considers a possible digit as a separator: as in:
    #   AttachHudCenter1 -> ATTACH_HUD_CENTER_1
    # but it will fail with Sqrt2 as it will produce SQRT_2 instead of SQRT2
    # though it can be written as SQRT2 to avoid that problem
    return re.sub('([A-Z0-9])_(?:(?=[A-Z0-9]_)|(?=[A-Z0-9]$))', '\\1', re.sub('([A-Z0-9])', '_\\1', arg))[1:].upper()

  version = "0.0.20130526000"

  document.sort(lambda x,y: cmp(x["name"],y["name"]))

  if infilename is not None:
    inf = open(infilename, "r")
  else:
    inf = sys.stdin

  try:
    inputlines = inf.readlines()

  finally:
    if infilename is not None:
      inf.close()

  # Analyze source looking for preexisting constants
  u2c = {}
  for line in inputlines:
    # Find all occurrences of: llcXYZ = XVal cXYZ
    # (XVal is one of FVal, IVal, KVal, RVal, LVal, SVal, or VVal)
    results = re.findall(r'llc([A-Za-z0-9]+)\s*=\s*[FIKRLSV]Val\s*c\1\s*(?:$|;)', line)
    for const in results:
      u2c[UpperCamelCase_TO_UNDERSCORES(const)] = const

  # Special cases
  u2c['AGENT_BY_LEGACY_NAME'] = 'Agent'  # the value used is that of Agent
  u2c['INVENTORY_BODYPART'] = 'InventoryBodyPart'  # should have been Bodypart for consistence
  u2c['URL_REQUEST_GRANTED'] = 'UrlRequestGranted' # there's no corresponding cXXX constant
  u2c['URL_REQUEST_DENIED'] = 'UrlRequestDenied'   # there's no corresponding cXXX constant
  u2c['ZERO_VECTOR'] = 'ZeroVector'                # there's no corresponding cXXX constant
  u2c['ZERO_ROTATION'] = 'ZeroRotation'            # there's no corresponding cXXX constant

  newline = ""

  if outfilename is not None:
    outf = open(outfilename, "w")
  else:
    outf = sys.stdout

  try:
    for line in inputlines:
      if not line.startswith("<<< %s KEYWORDS >>>" % tag):
        if newline != "":
          outf.write(newline.encode('utf8') + "\n")
          newline = ""
        outf.write(line.encode('utf8'))
      else:
        for element in document:
          if element["cat"] == "constant":
            if newline != "":
              outf.write(newline.encode('utf8') + ",\n")
              newline = ""

            # Special case
            if element["name"] == "EOF":
              newline = '    Constant "EOF" $ SVal cEOF'

            # The Haskell code treats these as key constants, not string constants
            elif element["name"].startswith("TEXTURE_"):
              newline = '    Constant "%s" (KVal $ LSLKey "%s")' % (element["name"], element["value"])

            # Emit those having a constant
            elif element["name"] in u2c:
              newline = '    Constant "%s" llc%s' % (element["name"], u2c[element["name"]])

            # Emit as values
            else:
              value = element["value"]
              if element["type"] == "string":
                value = '"' + value + '"'
              elif element["type"] == "key": # even though there are no key valued constants
                value = '$ LSLKey "' + value + '"'
              elif element["type"] in ("float", "integer"):
                if value[0] == '-':
                  value = '(' + value + ')'
              elif element["type"] in ("vector", "rotation", "quaternion"):
                value = re.sub(', *', ' ', re.sub('(-[-+0-9.eE]+)', '(\\1)', re.sub('\\.0+(?=[^0-9])', '', value)))[1:-1]
              newline = '    Constant "%s" (%sVal %s)' % (element["name"], element["type"][0].upper(), value)

    if newline != "":
      outf.write(newline.encode('utf8') + "\n")

  finally:
    if outfilename is not None:
      outf.close()


pass
